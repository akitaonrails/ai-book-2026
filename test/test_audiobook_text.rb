# frozen_string_literal: true

require_relative "test_helper"

class TestAudiobookText < ToolTest
  CONTAINER = <<~XML
    <?xml version="1.0" encoding="UTF-8"?>
    <container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
      <rootfiles><rootfile full-path="EPUB/content.opf" media-type="application/oebps-package+xml"/></rootfiles>
    </container>
  XML

  # pages: [[file name, <section> markup], ...] in spine order.
  def epub_with(pages, lang: "pt-BR", cover: true, cover_href: "media/cover.png")
    src = "audio-src"
    fx.write("#{src}/mimetype", "application/epub+zip")
    fx.write("#{src}/META-INF/container.xml", CONTAINER)
    items = pages.map { |name, _| %(<item id="#{name}" href="text/#{name}.xhtml" media-type="application/xhtml+xml"/>) }
    items << %(<item id="cover_png" properties="cover-image" href="#{cover_href}" media-type="image/png"/>) if cover
    fx.write("#{src}/EPUB/content.opf", <<~XML)
      <?xml version="1.0" encoding="UTF-8"?>
      <package xmlns="http://www.idpf.org/2007/opf" version="3.0">
        <metadata xmlns:dc="http://purl.org/dc/elements/1.1/">
          <dc:title>Livro de Teste</dc:title>
          <dc:creator>Fabio Akita</dc:creator>
        </metadata>
        <manifest>#{items.join}</manifest>
        <spine>#{pages.map { |name, _| %(<itemref idref="#{name}"/>) }.join}</spine>
      </package>
    XML
    pages.each do |name, body|
      fx.write("#{src}/EPUB/text/#{name}.xhtml", <<~XML)
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE html>
        <html xmlns="http://www.w3.org/1999/xhtml" lang="#{lang}" xml:lang="#{lang}"><head><title>#{name}</title></head>
        <body>#{body}</body></html>
      XML
    end
    fx.write("#{src}/EPUB/media/cover.png", FixtureData::PNG) if cover
    epub = fx.path("audio.epub")
    Dir.chdir(fx.path(src)) do
      system("zip", "-X0q", epub, "mimetype", exception: true)
      system("zip", "-Xr9Dq", epub, ".", "-x", "mimetype", exception: true)
    end
    epub
  end

  def narrate(epub, *flags)
    res = fx.run("audiobook_text", *flags, epub, fx.path("out/book.txt"))
    assert_exit 0, res
    fx.read("out/book.txt").lines(chomp: true).reject(&:empty?)
  end

  def chapter(id, h1, body, cls: "level1")
    %(<section id="#{id}" class="#{cls}"><h1>#{h1}</h1>#{body}</section>)
  end

  def test_reads_chapters_in_spine_order_with_spoken_titles
    lines = narrate(epub_with([
      ["ch001", chapter("sec-prefacio", "Prefácio", "<p>Abertura.</p>", cls: "level1 unnumbered")],
      ["ch002", chapter("sec-ch01", '<span class="header-section-number">1</span> Um gerador', "<p>Primeiro parágrafo.</p><p>Segundo.</p>")],
      ["ch003", chapter("sec-apA", 'Apêndice <span class="header-section-number">A</span> — Feito por IA?', "<p>Anexo.</p>")],
    ]))
    assert_equal ["Title: Livro de Teste", "Author: Fabio Akita",
                  "# Prefácio", "Abertura.",
                  "# Capítulo 1. Um gerador", "Primeiro parágrafo.", "Segundo.",
                  "# Apêndice A — Feito por IA?", "Anexo."], lines
  end

  def test_english_edition_says_chapter
    lines = narrate(epub_with([["ch001", chapter("sec-ch01", '<span class="header-section-number">3</span> Hands', "<p>Text.</p>")]], lang: "en"))
    assert_includes lines, "# Chapter 3. Hands"
  end

  def test_leaves_out_the_generated_back_matter
    back = %w[sec-fontes sec-creditos sec-glossario sec-bibliografia].map.with_index do |id, i|
      ["back#{i}", chapter(id, id, "<p>Lista de #{id}.</p>", cls: "level1 unnumbered")]
    end
    lines = narrate(epub_with([["ch001", chapter("sec-ch01", "Um", "<p>Texto.</p>")], *back]))
    assert_equal ["# Um", "Texto."], lines.drop(2)
  end

  def test_drops_what_a_listener_cannot_use_and_keeps_captions
    body = <<~HTML
      <p>Um episódio <span class="citation" data-cites="x">(<a href="ch9.xhtml#ref-x">Flow, 2025</a>)</span>. Veja <a href="https://example.com/a" class="uri">https://example.com/a</a> e o <a href="ch3.xhtml#sec-apB" class="quarto-xref">Apêndice B</a>.</p>
      <div id="fig-a" class="quarto-float quarto-figure"><figure><div><img src="../media/a.png" alt="Texto alternativo"/></div>
      <figcaption>Figura 1.1: O ciclo.</figcaption></figure></div>
      <div id="fig-a-description" class="figure-description"><p>Descrição detalhada da imagem: longa.</p></div>
      <div class="sourceCode"><pre><code>rake build</code></pre></div>
      <p>Solto em https://example.org/x no meio.</p>
    HTML
    lines = narrate(epub_with([["ch001", chapter("sec-ch01", "Um", body)]]))
    assert_equal ["Um episódio. Veja e o Apêndice B.", "Figura 1.1: O ciclo.", "Solto em no meio."], lines.drop(3)
  end

  def test_reads_list_items_and_table_rows_as_lines
    body = <<~HTML
      <h2>Seção</h2>
      <ul><li>Primeiro item.</li><li><p>Item com parágrafo.</p></li></ul>
      <table><caption>Linha do tempo.</caption>
      <thead><tr><th>Quando</th><th>O quê</th></tr></thead>
      <tbody><tr><td>1958</td><td>Perceptron.</td></tr><tr><td>2017</td><td>Transformer</td></tr></tbody></table>
    HTML
    lines = narrate(epub_with([["ch001", chapter("sec-ch01", "Um", body)]]))
    assert_equal ["Seção", "Primeiro item.", "Item com parágrafo.", "Linha do tempo.", "1958. Perceptron.", "2017. Transformer."], lines.drop(3)
  end

  def test_sample_keeps_the_opening_of_the_first_four_chapters
    pages = (1..5).map do |n|
      ["ch00#{n}", chapter("sec-ch0#{n}", %(<span class="header-section-number">#{n}</span> Cap #{n}), "<p>A#{n}.</p><p>B#{n}.</p><p>C#{n}.</p>")]
    end
    lines = narrate(epub_with(pages), "--sample")
    assert_equal ["Title: Livro de Teste", "Author: Fabio Akita",
                  *(1..4).flat_map { ["# Capítulo #{_1}. Cap #{_1}", "A#{_1}.", "B#{_1}."] }], lines
    assert fx.exist?("out/cover.png")
  end

  def test_a_paragraph_starting_with_hash_is_not_read_as_a_chapter
    lines = narrate(epub_with([["ch001", chapter("sec-ch01", "Um", "<p># comentário de shell</p>")]]))
    assert_equal "comentário de shell", lines.last
  end

  def test_writes_the_cover_next_to_the_text
    narrate(epub_with([["ch001", chapter("sec-ch01", "Um", "<p>Texto.</p>")]]))
    assert_equal FixtureData::PNG, File.binread(fx.path("out/cover.png"))
  end

  def test_replaces_a_cover_left_by_a_previous_edition
    fx.write("out/cover.jpg", "old")
    narrate(epub_with([["ch001", chapter("sec-ch01", "Um", "<p>Texto.</p>")]]))
    refute fx.exist?("out/cover.jpg")
  end

  def test_refuses_a_path_that_leaves_the_epub
    fx.write("secret.png", "private")
    epub = epub_with([["ch001", chapter("sec-ch01", "Um", "<p>Texto.</p>")]], cover_href: "#{"../" * 20}#{fx.path("secret.png")}")
    res = fx.run("audiobook_text", epub, fx.path("out/book.txt"))
    assert_exit 1, res
    assert_includes res.err, "points outside the EPUB"
    refute fx.exist?("out/cover.png")
  end

  def test_refuses_a_container_that_leaves_the_epub
    epub = epub_with([["ch001", chapter("sec-ch01", "Um", "<p>Texto.</p>")]])
    fx.write("secret.xml", CONTAINER)
    Dir.mktmpdir do |dir|
      FileUtils.mkdir_p(File.join(dir, "META-INF"))
      File.symlink(fx.path("secret.xml"), File.join(dir, "META-INF", "container.xml"))
      Dir.chdir(dir) { system("zip", "-qy", epub, "META-INF/container.xml", exception: true) }
    end
    res = fx.run("audiobook_text", epub, fx.path("out/book.txt"))
    assert_exit 1, res
    assert_includes res.err, "points outside the EPUB"
  end

  def test_fails_when_the_epub_has_no_chapters
    res = fx.run("audiobook_text", epub_with([["ch001", "<p>Só página de título.</p>"]], cover: false), fx.path("out/book.txt"))
    assert_exit 1, res
    assert_includes res.err, "no chapters found"
  end
end
