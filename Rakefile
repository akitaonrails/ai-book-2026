# frozen_string_literal: true

# Book build. Everything runs from pinned tools in tools/ (see tools/SHA256SUMS).
#   rake tools          fetch + verify + unpack pinned toolchain
#   rake inventory      re-scan the blog (hashes, links)
#   rake drift          what in the book is stale vs the blog (DIFF=1 for diffs)
#   rake check          outline coverage + chapter lint
#   rake diagrams       render assets/diagrams/*.d2 for each language
#   rake build          render PT edition (EPUB, print + ebook PDF, HTML, DOCX) + epubcheck + page audit
#   rake audit          page-level layout audit of the PDFs (scripts/page_audit.rb)
#   rake build BOOK_LANG=en  same for the EN edition
#   rake review DIR=reviews/<version>/<lang>  validate + summarise copyedit findings (scripts/review.rb)
#   rake balance        words per unit and per source post, overlap between units (build/<lang>/balance.md)
#   rake test           regression tests of the tools (test/, isolated fixture book)
#   rake audiobook      read the built EPUB aloud into build/<lang>/<title>.m4b (VOICE=..., SAMPLE=1, network, hours)

require "digest"
require "fileutils"
require "open3"
require "rake/testtask"
require "shellwords"
require "yaml"
require_relative "scripts/kdp_template"
require_relative "scripts/print_editions"
require_relative "scripts/uiclap_template"

ROOT = __dir__
LANG = ENV.fetch("BOOK_LANG", "pt")
TOOLS = File.join(ROOT, "tools")
QUARTO = File.join(TOOLS, "quarto-1.10.19", "bin", "quarto")
EPUBCHECK_JAR = File.join(TOOLS, "epubcheck-5.4.0", "epubcheck.jar")
D2 = File.join(TOOLS, "d2-v0.9.0", "bin", "d2")
ACE = File.join(TOOLS, "a11y", "node_modules", ".bin", "ace")
DOWNLOADS = {
  "quarto-1.10.19-linux-amd64.tar.gz" => "https://github.com/quarto-dev/quarto-cli/releases/download/v1.10.19/quarto-1.10.19-linux-amd64.tar.gz",
  "epubcheck-5.4.0.zip" => "https://github.com/w3c/epubcheck/releases/download/v5.4.0/epubcheck-5.4.0.zip",
  "d2-v0.9.0-linux-amd64.tar.gz" => "https://github.com/terrastruct/d2/releases/download/v0.9.0/d2-v0.9.0-linux-amd64.tar.gz",
}.freeze

desc "Fetch, verify and unpack the pinned toolchain"
task :tools do
  cache = File.join(TOOLS, "cache")
  FileUtils.mkdir_p(cache)
  sums = File.readlines(File.join(TOOLS, "SHA256SUMS")).to_h { |l| l.split.reverse }
  DOWNLOADS.each do |name, url|
    path = File.join(cache, name)
    sh "curl -sSfL -o #{path} #{url}" unless File.exist?(path)
    actual = Digest::SHA256.file(path).hexdigest
    raise "checksum mismatch for #{name}: #{actual}" unless actual == sums.fetch(name)
  end
  Dir.chdir(TOOLS) do
    sh "tar xzf cache/quarto-1.10.19-linux-amd64.tar.gz" unless File.exist?(QUARTO)
    sh "unzip -qo cache/epubcheck-5.4.0.zip" unless File.exist?(EPUBCHECK_JAR)
    sh "tar xzf cache/d2-v0.9.0-linux-amd64.tar.gz" unless File.exist?(D2)
  end
  unless File.exist?(ACE)
    sh({ "PUPPETEER_SKIP_DOWNLOAD" => "1" }, "npm", "ci", chdir: File.join(TOOLS, "a11y"))
  end
end

desc "Re-scan the blog: hashes, links"
task :inventory do
  ruby "scripts/inventory.rb"
  ruby "scripts/links.rb"
end

desc "Report chapters/analyses out of sync with the blog"
task drift: :inventory do
  args = ["--lang", LANG]
  args << "--diff" if ENV["DIFF"]
  ruby "scripts/drift.rb", *args
end

desc "Validate outline coverage and lint chapter sources"
task :check do
  ruby "scripts/outline_check.rb"
  generated = %w[glossario.md bibliografia.md fontes.md creditos.md]
  files = Dir[File.join(ROOT, "book", LANG, "*.md")].reject { generated.include?(File.basename(_1)) }
  ruby "scripts/lint_chapter.rb", *files unless files.empty?
  ruby "scripts/en_quote_punct.rb", "--check" if LANG == "en" # EN house style: punctuation inside quotes
  ruby "scripts/doctor.rb", "--lang", LANG
end

desc "Copyedit step 2: validate and summarise findings (DIR=reviews/<version>/<lang>, GREP=regex optional)"
task :review do
  dir = ENV["DIR"] or abort "usage: rake review DIR=reviews/<version>/<lang> [GREP=regex]"
  ruby "scripts/review.rb", "validate", dir
  summary = ["summary", dir]
  summary += ["--grep", ENV["GREP"]] if ENV["GREP"]
  ruby "scripts/review.rb", *summary
end

desc "Integrity check of the sources (scripts/doctor.rb): refs, citations, glossary, figures, provenance, callbacks, parity"
task :doctor do
  ruby "scripts/doctor.rb", "--lang", LANG
end

desc "Copyedit step 1: mechanical style report (repetition, tics, variants) in build/<lang>/style-report.md"
task :style do
  ruby "scripts/style_report.rb", "--lang", LANG
end

desc "Structural balance: words per unit and per source post, overlap, in build/<lang>/balance.md"
task :balance do
  ruby "scripts/balance_report.rb", "--lang", LANG
end

desc "Strict pre-release check: doctor in release mode (placeholders and stale translations are errors)"
task :release_check do
  ruby "scripts/doctor.rb", "--lang", LANG, "--release", "--output"
end

# Each test runs the scripts inside a throwaway fixture repository (see
# test/test_helper.rb); the real book is never touched. No Quarto render.
Rake::TestTask.new(:test) do |t|
  t.description = "Regression tests of the tools (scripts/, filters/) against a fixture book"
  t.libs << "test"
  t.test_files = FileList["test/test_*.rb"].exclude("test/test_helper.rb")
  t.warning = false
end

desc "Render D2 diagrams for the current language"
task diagrams: :tools do
  Dir[File.join(ROOT, "assets", "diagrams", "*.d2")].each do |src|
    ruby "scripts/render_diagram.rb", src, LANG, D2
  end
end

desc "Render matplotlib charts/diagrams (assets/charts/*.py) for the current language"
task :charts do
  Dir[File.join(ROOT, "assets", "charts", "*.py")].sort.each do |py|
    # chart_check.py runs the script and refuses to save if a label spills out
    # of its box or off the canvas (labels change length between languages).
    sh "uv", "run", "--quiet", "--with", "matplotlib", "--with", "numpy", "python", "-I", "scripts/chart_check.py", py, LANG
  end
  # Label overlays on AI art (ImageMagick), same language convention.
  Dir[File.join(ROOT, "assets", "charts", "*.rb")].sort.each { |rb| ruby rb, LANG }
end

desc "Generate the Quarto profile from book/outline.yml"
task :config do
  ruby "scripts/gen_quarto.rb", LANG
end

desc "Merge per-chapter bibliography and glossary proposals"
task :merge do
  ruby "scripts/merge_refs.rb", LANG
  ruby "scripts/merge_glossary.rb", LANG
end

desc "Generate glossary/bibliography/sources pages and figure placeholders"
task :backmatter do
  ruby "scripts/gen_back_matter.rb", LANG
  ruby "scripts/figures.rb", LANG, "--placeholders"
end

desc "Build all formats for LANG (default pt), fit and audit the PDF, validate the EPUB"
task build: %i[tools merge backmatter config] do
  profile = File.join(ROOT, "_quarto-#{LANG}.yml")
  raise "missing profile #{profile}" unless File.exist?(profile) # quarto ignores unknown profiles silently
  # Keep Quarto's output in build/logs/render-<lang>.log (outside the output
  # dir, which Quarto wipes at the start of a render): the doctor's output
  # checks read it for unresolved cross-references, unknown glossary keys and
  # missing citations (Quarto only warns about those).
  log = File.join(ROOT, "build", "logs", "render-#{LANG}.log")
  FileUtils.mkdir_p(File.dirname(log))
  status = Open3.popen2e(QUARTO, "render", "--profile", LANG) do |_in, out, wait|
    File.open(log, "w") { |f| out.each_line { |l| print l; f.write(l) } }
    wait.value
  end
  raise "quarto render failed (see #{log})" unless status.success?
  FileUtils.cp(File.join(ROOT, "index.typ"), PrintEditions.typ(ROOT, LANG))
  Rake::Task[:fit].invoke
  Rake::Task[:paperback_pdf].invoke if YAML.load_file(File.join(ROOT, "book", "outline.yml")).dig("meta", "isbn_paperback", LANG)
  Rake::Task[:ebook_pdf].invoke
  Rake::Task[:epub_clean].invoke
  Rake::Task[:epub_accessibility].invoke
  Rake::Task[:epubcheck].invoke
  Rake::Task[:a11y].invoke
  Rake::Task[:audit].invoke
  ruby "scripts/doctor.rb", "--lang", LANG, "--output"
end

# Quarto renders the print PDF (6x9 in, mirrored margins, no cover) and keeps
# the Typst source (keep-typ) as index.typ. The tasks below recompile that
# per-language index-<lang>.typ source with Quarto's bundled typst;
# build/<lang>/.tighten holds the
# per-chapter tightening (`--input tighten=...`) shared by every compile and
# by the audit, so they all see the same layout.
# Resolved lazily: in a fresh checkout Quarto (which bundles Typst) is only
# unpacked by the tools task, after this file is loaded.
def typst_bin
  Dir[File.join(TOOLS, "quarto-1.10.19", "bin", "tools", "*", "typst")].first or raise "typst not found; run rake tools"
end
TIGHTEN = File.join(ROOT, "build", LANG, ".tighten")

def typst_sources
  typ = PrintEditions.typ(ROOT, LANG)
  print_pdf = PrintEditions.pdf(File.join(ROOT, "build", LANG))
  raise "run `rake build` first (missing #{typ} or the print PDF)" unless File.exist?(typ) && print_pdf

  [typ, print_pdf]
end

def typst_compile(typ, pdf, edition, binding: "hardcover")
  tighten = File.exist?(TIGHTEN) ? File.read(TIGHTEN).strip : ""
  sh typst_bin, "compile", "--root", ROOT, "--font-path", File.join(ROOT, "assets", "fonts"), "--pdf-standard", "ua-1",
     "--input", "edition=#{edition}", "--input", "binding=#{binding}", "--input", "tighten=#{tighten}", typ, pdf
end

# A chapter whose last page holds 1-3 lines (RUNT-END in the audit) is set a
# hair tighter (level 1, then 2: see ak-unit in the template) and the print PDF is
# recompiled, until no runt is left or every runt chapter is at level 3.
desc "Recompile the print PDF, tightening chapters that end in a runt page"
task :fit do
  typ, print_pdf = typst_sources
  levels = {}
  File.write(TIGHTEN, "")
  4.times do
    runts = `#{RbConfig.ruby} #{File.join(ROOT, 'scripts', 'page_audit.rb')} --lang #{LANG} --runts`.strip.split(",")
    grow = runts.reject { levels.fetch(_1, 0) >= 3 }
    break if grow.empty?

    grow.each { levels[_1] = levels.fetch(_1, 0) + 1 }
    File.write(TIGHTEN, levels.map { "#{_1}:#{_2}" }.join(","))
    puts "fit: tightening #{File.read(TIGHTEN)}"
    typst_compile(typ, print_pdf, "print")
  end
end

# The ebook PDF is the same source compiled with `--input edition=ebook`
# (cover page, symmetric margins, no blank pages). See
# _extensions/akita-book/typst-template.typ.
desc "Compile the ebook PDF from the Typst source kept by the last render"
task :ebook_pdf do
  typ, print_pdf = typst_sources
  typst_compile(typ, print_pdf.sub(/\.pdf\z/, "-ebook.pdf"), "ebook")
end

desc "Compile the paperback interior with its own ISBN (only configured languages)"
task :paperback_pdf do
  isbn = YAML.load_file(File.join(ROOT, "book", "outline.yml")).dig("meta", "isbn_paperback", LANG)
  raise "no paperback ISBN configured for #{LANG}" unless isbn

  typ, print_pdf = typst_sources
  raise "paperback ISBN missing from rendered source; run rake build BOOK_LANG=#{LANG}" unless File.read(typ).include?(isbn)
  typst_compile(typ, print_pdf.sub(/\.pdf\z/, "-paperback.pdf"), "print", binding: "paperback")
end

desc "Build only the PT-BR UICLAP 16x23 print interior (no Amazon/ebook outputs)"
task :uiclap_pdf do
  raise "UICLAP is PT-BR print only" unless LANG == "pt"
  %i[tools merge backmatter].each { Rake::Task[_1].invoke }
  ruby "scripts/gen_quarto.rb", "pt", "uiclap"
  dir = File.join(ROOT, "build/uiclap/pt")
  log = File.join(ROOT, "build/logs/render-pt-uiclap.log")
  FileUtils.mkdir_p(File.dirname(log))
  status = Open3.popen2e(QUARTO, "render", "--profile", "pt-uiclap", "--to", "akita-book-typst") do |_input, out, wait|
    File.open(log, "w") { |f| out.each_line { |line| f.write(line) } }
    wait.value
  end
  raise "UICLAP render failed: #{log}" unless status.success?
  if File.read(log).match?(/Unable to resolve crossref|\[glossary\] unknown key:|citation (?:not found|missing)|citation .* not found/i)
    raise "Unresolved reference in UICLAP render: #{log}"
  end
  typ = File.join(ROOT, "index-pt-uiclap.typ")
  FileUtils.cp(File.join(ROOT, "index.typ"), typ)
  pdf = File.join(dir, "Competente-o-Suficiente-uiclap-16x23.pdf")
  tighten = File.join(dir, ".tighten")
  File.write(tighten, "")
  levels = {}
  4.times do
    out, status = Open3.capture2(RbConfig.ruby, File.join(ROOT, "scripts/page_audit.rb"), "--edition", "uiclap", "--runts")
    raise "UICLAP runt audit failed" unless status.success?
    grow = out.strip.split(",").reject { levels.fetch(_1, 0) >= 3 }
    break if grow.empty?
    grow.each { levels[_1] = levels.fetch(_1, 0) + 1 }
    File.write(tighten, levels.map { "#{_1}:#{_2}" }.join(","))
    sh typst_bin, "compile", "--root", ROOT, "--font-path", File.join(ROOT, "assets/fonts"), "--pdf-standard", "ua-1",
       "--input", "tighten=#{File.read(tighten)}", typ, pdf
  end
  ruby "scripts/page_audit.rb", "--edition", "uiclap", "--strict"
  puts "UICLAP interior: #{pdf} (ISBN omitted unless meta.isbn_uiclap.pt is configured)"
end

desc "Build the UICLAP upload JPG and a PDF proof from the supplied cover measurements"
task :uiclap_cover do
  raise "UICLAP is PT-BR only" unless LANG == "pt"
  dir = File.join(ROOT, "build/uiclap/pt")
  pdf = File.join(dir, "Competente-o-Suficiente-uiclap-16x23.pdf")
  info, status = Open3.capture2("pdfinfo", pdf)
  raise "UICLAP interior missing or unreadable" unless status.success?
  template = File.join(ROOT, "assets/cover/uiclap-medidas-capa.jpg")
  UiclapTemplate.validate!(template, info[/^Pages:\s+(\d+)/, 1].to_i)
  raise "UICLAP interior must be 160 x 230 mm" unless info.match?(/Page size:\s+453\.54\d* x 651\.96\d* pts/)
  ruby "scripts/compose_kdp_cover.rb", template, File.join(dir, "Competente-o-Suficiente-uiclap-cover.pdf"), "--lang", "pt", "--uiclap"
end

desc "Page-level layout audit of the print and ebook PDFs (STRICT=1 fails on findings)"
task :audit do
  args = ["--lang", LANG]
  args << "--strict" if ENV["STRICT"]
  ruby "scripts/page_audit.rb", *args, "--edition", "print"
  ruby "scripts/page_audit.rb", *args, "--edition", "ebook"
  ruby "scripts/page_audit.rb", *args, "--edition", "paperback" if PrintEditions.pdf(File.join(ROOT, "build", LANG), "paperback")
end

desc "Strip Quarto's unused inline CSS (data: URI icons, flex panels) from the EPUBs, for Kindle"
task :epub_clean do
  Dir[File.join(ROOT, "build", LANG, "*.epub")].each { ruby "scripts/epub_clean.rb", _1 }
end

desc "Add body, glossary, bibliography and credits landmarks to the EPUBs"
task :epub_accessibility do
  Dir[File.join(ROOT, "build", LANG, "*.epub")].each { ruby "scripts/epub_accessibility.rb", _1 }
end

desc "Validate built EPUBs with epubcheck"
task :epubcheck do
  Dir[File.join(ROOT, "build", LANG, "*.epub")].each do |epub|
    sh "java", "-jar", EPUBCHECK_JAR, "--failonwarnings", epub
  end
end

desc "Check generated accessibility semantics and run DAISY Ace on the EPUBs"
task a11y: :tools do
  ruby "scripts/a11y_check.rb", "--lang", LANG
  Dir[File.join(ROOT, "build", LANG, "*.epub")].each do |epub|
    report = File.join(ROOT, "build", "a11y", LANG, File.basename(epub, ".epub"))
    FileUtils.rm_rf(report)
    FileUtils.mkdir_p(File.dirname(report))
    # GitHub's hosted runner cannot provide Electron's setuid sandbox. CI only
    # checks EPUBs generated from this trusted checkout; local checks retain it.
    ace_command = ENV["CI"] ? ["xvfb-run", "-a", ACE, "--no-sandbox"] : [ACE]
    sh(*ace_command, "--exiterror2", "--force", "--outdir", report, epub)
  end
end

# Each binding's wraparound cover is built locally from KDP's cover template
# (cover calculator PNG, unzipped under assets/cover/kdp/). The template is
# drawn for one page count (one per edition): after an interior's page count
# changes, download a new template. Upload build/kdp/<title>-<binding>-cover.pdf to KDP.
desc "Compose a wraparound cover (BINDING=hardcover|paperback, TEMPLATE=path optional)"
task :kdp_cover do
  binding = ENV.fetch("BINDING", "hardcover")
  raise "BINDING must be hardcover or paperback" unless %w[hardcover paperback].include?(binding)
  print_pdf = PrintEditions.pdf(File.join(ROOT, "build", LANG), binding)
  raise "run `rake build BOOK_LANG=#{LANG}` first (the cover name and page count come from the print PDF)" unless print_pdf

  # Match both the actual interior's page count and the requested binding.
  pages = `pdfinfo #{print_pdf.shellescape}`[/^Pages:\s+(\d+)/, 1].to_i
  template = KdpTemplate.select(Dir[File.join(ROOT, "assets", "cover", "kdp", "*", "*.png")],
                                binding:, pages:, explicit: ENV["TEMPLATE"])

  # build/kdp/, not build/<lang>/: the build tasks treat every PDF there as the book.
  title = File.basename(print_pdf, ".pdf").delete_suffix("-paperback")
  out = File.join(ROOT, "build", "kdp", title + "-#{binding}-cover.pdf")
  FileUtils.mkdir_p(File.dirname(out))
  ruby "scripts/compose_kdp_cover.rb", template, out, "--lang", LANG
end

# The audiobook is read by Microsoft Edge's online voices through
# epub2tts-edge, pinned by commit and run with uv like the charts (it needs
# Python 3.11: pydub still imports audioop). Not part of build: it needs the
# network and takes hours. In CI only the book workflow's audiobook job runs
# it, on release tags once the AUDIOBOOK repository variable is "true". The
# work dir is keyed by the narration text and the voice, so an edited edition
# never reuses stale audio, and an interrupted run resumes from the last
# finished chapter (epub2tts-edge keeps each one as partN.flac).
EPUB2TTS = "git+https://github.com/aedocw/epub2tts-edge@6fb7a0f125188c0ff961a8db260f10221eb32c3c"
VOICES = { "pt" => "pt-BR-AntonioNeural", "en" => "en-US-AndrewNeural" }.freeze

desc "Read the built EPUB aloud into an M4B with chapters and cover (VOICE=<edge-tts voice>, SAMPLE=1 for a few minutes)"
task :audiobook do
  epub = Dir[File.join(ROOT, "build", LANG, "*.epub")].first
  raise "run `rake build BOOK_LANG=#{LANG}` first (missing the EPUB)" unless epub

  voice = ENV.fetch("VOICE") { VOICES.fetch(LANG) }
  # It names the work dir and the output file, and goes to epub2tts-edge as an argument.
  raise "VOICE must be an edge-tts voice name, like #{VOICES.fetch(LANG)}" unless voice.match?(/\A[A-Za-z]{2,3}(-[A-Za-z0-9]+)+\z/)

  # SAMPLE=1: the opening of the first chapters, to judge the voice and the
  # chapter marks in minutes instead of hours.
  sample = %w[1 true].include?(ENV["SAMPLE"])
  title = File.basename(epub, ".epub") + (sample ? "-sample" : "")
  staging = File.join(ROOT, "build", "audiobook", LANG)
  text = File.join(staging, "#{title}.txt")
  ruby "scripts/audiobook_text.rb", *("--sample" if sample), epub, text
  work = File.join(staging, "#{Digest::SHA256.file(text).hexdigest[0, 12]}-#{voice}")
  FileUtils.mkdir_p(work)
  FileUtils.cp(text, work)
  # What an interrupted run leaves behind besides finished chapters. Paragraphs
  # of a half-read chapter would be resumed with the chapter title spoken in the
  # middle (epub2tts-edge prepends it to the first paragraph it synthesises),
  # and the last one may be truncated; leftovers of the final mux make ffmpeg
  # stop to ask, after which epub2tts-edge deletes the chapters anyway.
  stem = "#{title} (#{voice})"
  FileUtils.rm_f(Dir[File.join(work, "{pgraphs*.flac,sntnc*.mp3}")] +
                 %W[#{stem}.m4a #{stem}.m4b filelist.txt FFMETADATAFILE].map { File.join(work, _1) })
  # epub2tts-edge tags the cover as JPEG whatever it is; the EPUB's is a PNG.
  cover = Dir[File.join(staging, "cover.*")].first
  sh "ffmpeg", "-y", "-loglevel", "error", "-f", "image2", "-i", cover, File.join(work, "cover.jpg") if cover
  # Pauses shorter than epub2tts-edge's 1200 ms, which drag over a 15-hour book.
  cmd = ["uvx", "--quiet", "--python", "3.11", "--from", EPUB2TTS, "epub2tts-edge", File.basename(text),
         "--speaker=#{voice}", "--sentencepause", "500", "--paragraphpause", "900"]
  cmd += ["--cover", "cover.jpg"] if cover
  # NLTK downloads its sentence tokenizer into the first existing NLTK_DATA dir,
  # private, or into ~/nltk_data otherwise.
  nltk = File.join(ROOT, "build", "audiobook", "nltk_data")
  FileUtils.mkdir_p(nltk, mode: 0o700)
  sh({ "NLTK_DATA" => nltk }, *cmd, chdir: work)
  # epub2tts-edge ignores ffmpeg's exit status, so success is the file existing.
  m4b = File.join(work, "#{stem}.m4b")
  raise "epub2tts-edge finished without writing #{m4b}; see its ffmpeg output above" unless File.exist?(m4b)

  FileUtils.mv(m4b, File.join(ROOT, "build", LANG, "#{title}.m4b"))
end

task default: %i[check build]
