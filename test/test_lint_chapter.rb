# frozen_string_literal: true

require_relative "test_helper"

# scripts/lint_chapter.rb: mechanical voice and source checks per chapter file.
class TestLintChapter < ToolTest
  FM = <<~MD
    ---
    id: chx
    chapter: "Teste"
    sources:
      - {post: 2026/02/10/primeiro-post, sha256: "#{'0' * 64}"}
    blog_commit: "abc"
    ---
  MD

  # Writes a unit with the standard front matter and lints it.
  def lint(body, lang: "pt", fm: FM)
    fx.write("book/#{lang}/chx.md", fm + body)
    fx.run("lint_chapter", fx.path("book/#{lang}/chx.md"), env: { "BOOK_LANG" => lang })
  end

  # Line of `needle` in the linted file (1-based), to check reported positions.
  def line_of(needle, lang: "pt")
    fx.read("book/#{lang}/chx.md").lines.index { _1.include?(needle) } + 1
  end

  # Guards against false positives: the clean fixture book must lint clean in
  # both editions, otherwise `rake check` would fail on good text.
  def test_fixture_book_is_clean
    %w[pt en].each do |lang|
      res = fx.run("lint_chapter", *Dir[fx.path("book/#{lang}/*.md")], env: { "BOOK_LANG" => lang })
      assert_exit 0, res
      assert_includes res.out, "0 error(s), 0 warning(s)"
    end
  end

  # Guards the PT voice bans (negative parallelism, honesty signaling, relative time).
  def test_pt_banned_patterns
    res = lint(<<~MD)

      <!-- src: original -->
      Isso não é um detalhe, é o centro da questão.

      Pra ser honesto, ontem eu errei.
    MD
    assert_exit 1, res
    assert_includes res.out, "chx.md:#{line_of('não é um detalhe')}: error: negative parallelism 'não é X, é Y'"
    assert_match(/directness\/honesty signaling/, res.out)
    assert_match(/relative time/, res.out)
  end

  # Guards the EN voice bans; the PT list must not apply to the EN edition and vice versa.
  def test_en_banned_patterns
    res = lint(<<~MD, lang: "en")

      <!-- src: original -->
      To be honest, it's not a bug, it's a feature.

      Last week I tried it.
    MD
    assert_exit 1, res
    assert_match(/negative parallelism 'it's not X, it's Y'/, res.out)
    assert_match(/directness\/honesty signaling/, res.out)
    assert_match(/relative time/, res.out)

    pt = lint("\n<!-- src: original -->\nTo be honest, last week was fine.\n")
    assert_exit 0, pt, "EN bans must not apply to the PT edition"
  end

  # Guards the common bans (dashes, curly quotes, stock AI words) in any language.
  def test_common_bans
    res = lint("\n<!-- src: original -->\nUm texto — com travessão e uma tapestry.\n")
    assert_exit 1, res
    assert_match(/em\/en dash/, res.out)
    assert_match(/stock AI word/, res.out)
  end

  # Guards the 4-sentence paragraph ceiling: a warning (exit 0) at the paragraph's first line.
  def test_paragraph_ceiling_warning
    res = lint(<<~MD)

      <!-- src: original -->
      Um. Dois. Três. Quatro. Cinco.

      Um. Dois. Três. Quatro.
    MD
    assert_exit 0, res
    assert_includes res.out, "chx.md:#{line_of('Cinco')}: warning: paragraph has 5 sentences (ceiling 4)"
    assert_equal 1, res.out.scan("warning:").size, "a 4-sentence paragraph is within the ceiling"
  end

  # Guards against counting abbreviations and decimals as sentence ends.
  def test_paragraph_ceiling_ignores_abbreviations_and_decimals
    res = lint("\n<!-- src: original -->\nO Dr. Silva usou a versão 4.5 etc. e gostou. Depois parou. Fim. Mesmo.\n")
    assert_exit 0, res
    assert_includes res.out, "0 warning(s)"
  end

  # Guards the raw-URL ban: links must go through the bibliography.
  def test_raw_url
    res = lint("\n<!-- src: original -->\nVeja https://example.com/x pra saber mais.\n")
    assert_exit 1, res
    assert_includes res.out, "chx.md:#{line_of('https://')}: error: raw URL in prose"
  end

  # Guards citation-key validation, including keys only proposed in _refs/ (not merged yet).
  def test_unknown_citation_key
    res = lint("\n<!-- src: original -->\nComo diz [@nobody2026] e [@smith2026ai], e @sec-ch01 não é citação.\n")
    assert_exit 1, res
    assert_includes res.out, "unknown citation key @nobody2026"
    refute_match(/@smith2026ai|@sec-ch01/, res.out)

    fx.write("book/pt/_refs/chx.yaml", { "references" => [{ "id" => "nobody2026" }] }.to_yaml)
    res = fx.run("lint_chapter", fx.path("book/pt/chx.md"))
    assert_exit 0, res
  end

  # Guards glossary-key validation: lowercased span text, or key= alias.
  def test_glossary_keys
    res = lint("\n<!-- src: original -->\nUm [LLM]{.gls} e [modelos]{.gls key=llm} e [Foo Bar]{.gls}.\n")
    assert_exit 1, res
    assert_includes res.out, "glossary key 'foo bar' unknown"
    assert_equal 1, res.out.scan("glossary key").size, "LLM and key=llm are known"
  end

  # Guards the EN edition accepting keys that exist only in the PT glossary (EN mid-translation).
  def test_en_accepts_pt_only_glossary_key
    fx.edit("book/back/glossary-pt.yml") { _1 + "novo:\n  term: Novo\n  def: x\n" }
    res = lint("\n<!-- src: original -->\nA [new thing]{.gls key=novo}.\n", lang: "en")
    assert_exit 0, res
  end

  # Guards required front-matter keys and the source entry shape.
  def test_missing_front_matter_keys
    res = lint("\n<!-- src: original -->\nTexto.\n", fm: <<~MD)
      ---
      sources:
        - {post: 2026/02/10/primeiro-post}
      ---
    MD
    assert_exit 1, res
    %w[id blog_commit].each { assert_includes res.out, "front matter lacks '#{_1}'" }
    assert_includes res.out, "front matter needs 'chapter'"
    assert_match(/source .* needs post \+ sha256/, res.out)
  end

  # Guards against a file with no front matter at all slipping through.
  def test_no_front_matter
    fx.write("book/pt/chx.md", "# Sem front matter\n")
    res = fx.run("lint_chapter", fx.path("book/pt/chx.md"))
    assert_exit 1, res
    assert_includes res.out, "chx.md:1: error: missing YAML front matter"
  end

  # Guards the provenance rule: a unit without any src marker is an error.
  def test_provenance_marker_required
    res = lint("\nTexto sem marcador.\n")
    assert_exit 1, res
    assert_includes res.out, "no <!-- src: ... --> provenance markers"
  end

  # Guards reported line numbers: they must point at the source line, front matter included.
  def test_line_numbers_match_source
    res = lint("\n<!-- src: original -->\nPrimeira linha limpa.\n\nSegunda linha cirúrgica.\n")
    assert_includes res.out, "chx.md:#{line_of('cirúrgica')}: error: 'cirúrgico' as praise"
  end

  # Guards code blocks and comments being exempt from prose checks.
  def test_code_blocks_and_comments_exempt
    res = lint("\n<!-- src: original -->\nTexto.\n\n```\ncurl https://example.com # ontem\n```\n\n<!-- nota: https://x.y ontem -->\n")
    assert_exit 0, res
  end

  # Guards the authoring contract that keeps future figures accessible in both editions.
  def test_figure_accessibility_fields
    missing = lint("\n<!-- src: original -->\n![Legenda.](assets/figures/x.png){#fig-x}\n")
    assert_exit 1, missing
    assert_includes missing.out, "figure lacks fig-alt"
    assert_includes missing.out, "figure lacks fig-desc"

    long = "a" * 141
    over = lint("\n<!-- src: original -->\n![Legenda.](assets/figures/x.png){#fig-x fig-alt=\"#{long}\" fig-desc=\"Descrição completa.\"}\n")
    assert_exit 1, over
    assert_includes over.out, "fig-alt has 141 characters (maximum 140)"

    good = lint("\n<!-- src: original -->\n![Legenda.](assets/figures/x.png){#fig-x fig-alt=\"Resumo.\" fig-desc=\"Descrição completa.\"}\n")
    assert_exit 0, good
  end

  RULES = <<~YAML
    naming_rules:
      - {pattern: '\\bGPT (\\d)', use: 'GPT-\\1', langs: [pt, en]}
      - {pattern: '\\bGPT-(\\d(?:\\.\\d)?)[- ](sol|luna|terra|astra)\\b', use: 'GPT-\\1 \\2 (tier capitalised)', langs: [pt, en]}
      - {pattern: '\\bGPT-(\\d(?:\\.\\d)?)-(Sol|Luna|Terra|Astra)\\b', use: 'GPT-\\1 \\2', langs: [pt, en]}
      - {pattern: '\\bz\\.ai\\b', use: 'Z.ai', langs: [pt, en]}
      - {pattern: '(?i:\\b(um|o|este|esse|aquele) sprint\\b)', use: 'feminine', langs: [pt]}
  YAML

  # Guards naming_rules (book/continuity.yml): each violation is an error that
  # names the preferred form; correct spellings pass.
  def test_naming_rules_flag_violations
    fx.write("book/continuity.yml", RULES)
    res = lint(<<~MD)

      <!-- src: original -->
      O GPT 5.5 e o GPT-5.6 luna e o GPT-5.6-Sol rodaram na z.ai com um sprint curto.

      O GPT-5.6 Sol, a Z.ai e a sprint estão certos.
    MD
    assert_exit 1, res
    n = line_of("O GPT 5.5")
    assert_includes res.out, "chx.md:#{n}: error: naming: 'GPT 5' should be 'GPT-5'"
    assert_includes res.out, "naming: 'GPT-5.6 luna' should be 'GPT-5.6 luna (tier capitalised)'"
    assert_includes res.out, "naming: 'GPT-5.6-Sol' should be 'GPT-5.6 Sol'"
    assert_includes res.out, "naming: 'z.ai' should be 'Z.ai'"
    assert_includes res.out, "naming: 'um sprint' should be 'feminine'"
    assert_includes res.out, "5 error(s)", "the correct line adds none"
  end

  # Guards per-language rules (sprint is PT only) and the opt-out zones: link
  # texts and italic titles followed by a URL are quoted post titles.
  def test_naming_rules_langs_and_title_exemptions
    fx.write("book/continuity.yml", RULES)
    assert_exit 0, lint("\n<!-- src: original -->\nThe sprint was short, a one sprint plan.\n", lang: "en")
    res = lint(<<~MD)

      <!-- src: original -->
      Veja [GPT 5 e a z.ai](https://example.com/x) e *Rodei o GPT 5* (https://example.com/y) sem medo.
    MD
    refute_includes res.out, "naming:"
    assert_includes lint("\n<!-- src: original -->\n*Rodei o GPT 5* sem URL.\n").out, "naming:"
  end

  # Guards the cross-reference article rules in the real book/continuity.yml:
  # "Capítulo 5" and "Seção 15.7" need the contracted article, unnumbered
  # targets (rendered as their title) don't.
  def test_real_naming_rules_require_the_article_before_numbered_references
    real = YAML.load_file(File.join(FixtureData::REPO_ROOT, "book", "continuity.yml"))
    fx.write("book/continuity.yml", { "naming_rules" => real["naming_rules"] }.to_yaml)
    res = lint(<<~MD)

      <!-- src: original -->
      Em @sec-ch05 você viu, como em @sec-apB e na peça de @sec-ch19b, o que fica pra @sec-aptecnico.

      A lista está em @sec-como-ler-anuncio e em @sec-aptecnico-rag.

      No @sec-ch05, na @sec-aptecnico-rag, do @sec-apB, pra @sec-ch15-nas e em @sec-antes estão certos.
    MD
    assert_exit 1, res
    n = line_of("Em @sec-ch05")
    assert_includes res.out, "chx.md:#{n}: error: naming: 'Em @sec-ch05' should be 'no/do/pro @sec-ch05'"
    assert_includes res.out, "naming: 'em @sec-apB' should be 'no/do/pro @sec-apB'"
    assert_includes res.out, "naming: 'de @sec-ch19b' should be 'no/do/pro @sec-ch19b'"
    assert_includes res.out, "naming: 'pra @sec-aptecnico' should be 'no/do/pro @sec-aptecnico'"
    assert_includes res.out, "naming: 'em @sec-como-ler-anuncio' should be 'na/da @sec-como-ler-anuncio'"
    assert_includes res.out, "naming: 'em @sec-aptecnico-rag' should be 'na/da @sec-aptecnico-rag'"
    assert_includes res.out, "6 error(s)", "the correct line adds none"
  end

  # Guards the opt-in: without naming_rules in continuity.yml (or the file) nothing is checked.
  def test_naming_rules_absent
    assert_exit 0, lint("\n<!-- src: original -->\nO GPT 5 na z.ai.\n")
  end

  # Guards R3: watch-list phrases from continuity.yml warn (per language), never error.
  def test_generalization_watch_warns
    fx.write("book/continuity.yml", {"generalization_watch" => {"pt" => ['\\ba maioria (dos|das) pessoas\\b'], "en" => ['\\bmost people\\b']}}.to_yaml)
    res = lint("<!-- src: original -->\nA maioria das pessoas desiste cedo.\n\n<!-- src: original -->\nNa minha experiência, desisto cedo.\n")
    assert_exit 0, res
    assert_includes res.out, "chx.md:#{line_of('A maioria das pessoas')}: warning: possible unsupported generalization (EDITORIAL-RULES R3)"
    assert_equal 1, res.out.scan("R3").size
    en = lint("<!-- src: original -->\nMost people give up early.\n", lang: "en")
    assert_includes en.out, "R3"
  end

  # Guards R9: five distinct versioned names in one sentence warn; four, or the
  # same name repeated, do not; appendices are exempt.
  def test_name_dense_sentence
    dense = "Testei GPT-5.5, Opus 4.8, Gemini-3, Kimi-K3 e DeepSeek-V4 no mesmo dia."
    res = lint("<!-- src: original -->\n#{dense}\n\n<!-- src: original -->\nTestei GPT-5.5, Opus 4.8, Gemini-3 e GPT-5.5 de novo.\n")
    assert_includes res.out, "chx.md:#{line_of('Testei GPT-5.5, Opus 4.8, Gemini-3, Kimi')}: warning: name-dense sentence (EDITORIAL-RULES R9)"
    assert_equal 1, res.out.scan("R9").size
    fx.write("book/pt/apZ.md", FM + "<!-- src: original -->\n#{dense}\n")
    ap = fx.run("lint_chapter", fx.path("book/pt/apZ.md"))
    refute_includes ap.out, "R9"
  end

  # Guards R9 for lists: nine bullets in prose warn once; eight do not; appendices are exempt.
  def test_long_bullet_list
    items = ->(n) { (1..n).map { "- item #{_1}\n" }.join }
    assert_includes lint("<!-- src: original -->\nLista:\n\n#{items.(9)}").out, "bullet list longer than 8 items"
    refute_includes lint("<!-- src: original -->\nLista:\n\n#{items.(8)}").out, "bullet list"
    fx.write("book/pt/apZ.md", FM + "<!-- src: original -->\n#{items.(12)}")
    refute_includes fx.run("lint_chapter", fx.path("book/pt/apZ.md")).out, "bullet list"
  end
end
