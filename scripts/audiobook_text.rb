#!/usr/bin/env ruby
# frozen_string_literal: true

# Turns a built EPUB into the narration script epub2tts-edge reads aloud
# (rake audiobook): "Title:" and "Author:" lines, then one "# " line per
# chapter and one line per paragraph, which is the plain-text format
# epub2tts-edge expects. Reading the EPUB rather than book/<lang>/*.md means
# the audiobook says exactly what the released edition says, with Quarto's
# cross-references, glossary links and numbering already resolved.
#
# What a listener can't use is left out: the generated back matter (sources,
# image credits, glossary, bibliography), citations, bare URLs, images and
# their long descriptions, and code blocks. Figure and table captions are
# kept, and each table row is read as one line, so the timeline appendix
# still makes sense out loud.
#
# Usage: scripts/audiobook_text.rb [--sample] BOOK.epub OUT.txt
#   Also writes the EPUB's cover image next to OUT.txt as cover.<ext>.
#   --sample keeps only the opening of the first chapters: a few minutes of
#   audio to judge the voice and the chapter marks without reading the book.

require "fileutils"
require "rexml/document"
require "tmpdir"

# The back matter scripts/gen_back_matter.rb generates, same ids in both editions.
SKIP_UNITS = %w[sec-fontes sec-creditos sec-glossario sec-bibliografia].freeze
CHAPTER = { "pt" => "Capítulo", "en" => "Chapter" }.freeze
# --sample: the front matter and the first numbered chapter, two lines each.
SAMPLE_UNITS = 4
SAMPLE_LINES = 2

def classes(el) = el.attributes["class"].to_s.split

# A path named by the EPUB's own XML, refused if it leaves the extracted tree:
# an href with ../ or a symlinked entry would otherwise read, or copy out as
# the cover, any local file.
def inside(root, path)
  real = File.realpath(path)
  abort "#{path} points outside the EPUB" unless real.start_with?("#{File.realpath(root)}/")
  real
end

# Inline text of an element, without what makes no sense read aloud.
def inline(node)
  node.children.map do |child|
    case child
    when REXML::Text then child.value
    when REXML::Element
      next "" if child.name == "img"
      next "" if child.name == "span" && classes(child).include?("citation")
      next "" if child.name == "a" && (classes(child).include?("uri") || child.attributes["aria-hidden"] == "true")
      inline(child)
    else ""
    end
  end.join
end

def clean(text)
  text.gsub(%r{https?://\S+}, "")
      .gsub(/\s+/, " ")
      .gsub(/\(\s*\)/, "")          # parentheses left empty by a removed citation or URL
      .gsub(/\s+([.,;:!?)])/, '\1') # space left before punctuation by the same
      .strip
      .sub(/\A#+\s*/, "")           # a line starting with # would be read as a chapter
end

def heading(h1, lang)
  title = clean(inline(h1))
  first = h1.children.find { !(_1.is_a?(REXML::Text) && _1.value.strip.empty?) }
  # "1 Um gerador de texto" -> "Capítulo 1. Um gerador de texto"; appendices
  # ("Apêndice <number>A</number> — ...") already name themselves.
  return title unless first.is_a?(REXML::Element) && classes(first).include?("header-section-number")

  "#{CHAPTER.fetch(lang)} #{first.text}. #{clean(title.delete_prefix(first.text.to_s))}"
end

# Appends the spoken lines of a block-level element to out.
def blocks(el, out)
  el.elements.each do |child|
    case child.name
    when "p", "h2", "h3", "h4", "h5", "h6", "figcaption", "caption", "dt"
      out << clean(inline(child))
    when "ul", "ol"
      child.elements.each("li") do |li|
        li.elements["p|ul|ol|blockquote"] ? blocks(li, out) : out << clean(inline(li))
      end
    when "table"
      out << clean(inline(child.elements["caption"])) if child.elements["caption"]
      child.elements.each("tbody/tr") do |tr|
        cells = tr.elements.to_a("td").map { clean(inline(_1)).sub(/[.;:]\z/, "") }.reject(&:empty?)
        out << "#{cells.join('. ')}." unless cells.empty?
      end
    when "h1", "pre", "img", "hr" # h1 is the chapter title, read by the caller
      next
    when "div"
      next if (classes(child) & %w[sourceCode figure-description]).any?

      blocks(child, out)
    else # section, blockquote, figure, dl, dd: read what's inside
      blocks(child, out)
    end
  end
end

sample = ARGV.delete("--sample")
epub, out_path = ARGV.map { File.expand_path(_1) }
abort "usage: audiobook_text.rb [--sample] BOOK.epub OUT.txt" unless epub && out_path

Dir.mktmpdir("audiobook-text") do |dir|
  system("unzip", "-q", epub, "-d", dir, exception: true)
  container = REXML::Document.new(File.read(inside(dir, File.join(dir, "META-INF", "container.xml"))))
  opf_path = inside(dir, File.join(dir, container.root.elements["//rootfile"].attributes["full-path"]))
  opf = REXML::Document.new(File.read(opf_path))
  manifest = opf.root.elements.to_a("manifest/item").to_h { [_1.attributes["id"], _1] }
  title = opf.root.elements["metadata/dc:title"]&.text.to_s.strip
  author = opf.root.elements["metadata/dc:creator"]&.text.to_s.strip
  abort "no dc:title in #{File.basename(epub)}" if title.empty?

  lines = ["Title: #{title}", "Author: #{author}", ""]
  units = 0
  opf.root.elements.each("spine/itemref") do |ref|
    item = manifest.fetch(ref.attributes["idref"])
    next unless item.attributes["media-type"] == "application/xhtml+xml"
    next if sample && units >= SAMPLE_UNITS

    page = REXML::Document.new(File.read(inside(dir, File.join(File.dirname(opf_path), item.attributes["href"]))))
    lang = page.root.attributes["lang"].to_s.start_with?("en") ? "en" : "pt"
    REXML::XPath.each(page, "//*[local-name()='section'][contains(concat(' ', @class, ' '), ' level1 ')]") do |section|
      next if SKIP_UNITS.include?(section.attributes["id"])
      next if sample && units >= SAMPLE_UNITS

      h1 = section.elements["h1"] or next
      spoken = []
      blocks(section, spoken)
      lines << "# #{heading(h1, lang)}" << ""
      spoken.reject!(&:empty?)
      spoken = spoken.first(SAMPLE_LINES) if sample
      spoken.each { lines << _1 << "" }
      units += 1
    end
  end
  abort "no chapters found in #{File.basename(epub)}" if units.zero?

  FileUtils.mkdir_p(File.dirname(out_path))
  File.write(out_path, lines.join("\n"))

  FileUtils.rm_f(Dir[File.join(File.dirname(out_path), "cover.*")]) # a previous edition's, maybe another format
  cover = manifest.values.find { _1.attributes["properties"].to_s.split.include?("cover-image") }
  if cover
    src = inside(dir, File.join(File.dirname(opf_path), cover.attributes["href"]))
    FileUtils.cp(src, File.join(File.dirname(out_path), "cover#{File.extname(src)}"))
  end
  warn "audiobook_text: #{units} chapters, #{lines.sum { _1.split.size }} words in #{File.basename(out_path)}"
end
