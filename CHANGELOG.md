# Changelog

Editions of *Competente o Suficiente*. Each version is a git tag (`vX.Y.Z`);
pushing the tag builds the book and publishes a GitHub Release with the
files.

## Unreleased

- Fixed a missing word in the PT preface ("pronto em uma hora e meia"); the
  English edition already read correctly. Reported in #8, fixed in #7.
- Add `rake audiobook`: reads the built EPUB aloud with Microsoft Edge's
  online voices (epub2tts-edge, pinned) into an M4B with chapters and cover.
  The generated back matter, citations, URLs, images and code blocks are left
  out; figure captions and table rows are read. `SAMPLE=1` reads only the
  opening of the first chapters. The `book` workflow can attach an M4B per
  edition to each release; it stays off until the `AUDIOBOOK` repository
  variable is set to `true`.

## 1.0.0 — 2026-10-17

First stable release of the published Brazilian Portuguese and English editions.
The book text is unchanged from preview.9; this release finalizes the print
production targets and templates.

- Add a local-only PT-BR UICLAP print target at 16x23 cm, with
  isolated layout auditing and ISBN metadata; Amazon and ebook outputs remain unchanged.
- Add the UICLAP 600-dpi CMYK JPG cover with its supplied 28 mm spine
  template and a clear 70x50 mm barcode/ISBN area. The 547-page interior
  is retained unchanged; UICLAP files remain local, outside GitHub release assets.
- Build separate PT-BR hardcover and paperback interiors with their respective
  ISBNs. Paperback ISBN: 9798162938088. English remains hardcover-only.
- Add binding-aware KDP cover builds: PT-BR hardcover and paperback, EN
  hardcover. Template selection checks binding as well as page count; paperback
  composition uses its own spine and bleed geometry, without hardcover hinges.

## 1.0.0-preview.9

The world will not wait: work, authorship and learning in the age of agents.

- **New chapter 21, "O mundo não vai esperar" / "The World Won't Wait"**:
  the six-site redesign, real job displacement, Nolan's direction and the
  craft of learning beyond recipes. The existing final chapter becomes 22.
- **Target-reader adjustments**: tighter explanations around the cinema and
  cooking analogies, plus a discount-and-return exercise that fits ordinary
  assigned work. The five-persona review is recorded in `reviews/ch19b-2026-10-16/`.
- **Two photographs** selected by the author: the Roadster demonstration and
  Nolan on the set of The Odyssey, with accessible alternatives and full
  descriptions. Source and unverified-rights records accompany the assets.
- **Employment claims**: surrounding passages no longer imply that seniority
  or useful judgment guarantees a developer's job survives automation.
- **Copyedit and PT/EN parity**: carries the reviewed corrections merged in
  PR #4 and the precise prompt-caching timeline dates.
- **Blog synchronization**: incorporates the RTX 5090 decision-model rerun,
  distinguishing its deployment timings from the original mini-PC results.
- Both editions retain automatic Kindle cleanup, EPUBCheck, accessibility
  checks and print-page audits. New interior page counts require new KDP
  cover templates; old wraparound covers are not regenerated for this release.

## 1.0.0-preview.8

Accessible digital editions and a guarded Kindle pipeline.

- **Accessible EPUB and HTML**: all 55 figures in each language now have a
  concise alternative and a complete description; tables have captions; cover
  alternatives, localized accessibility summaries and EPUB landmarks identify
  the body, glossary, references and image credits.
- **Future chapters are covered**: `rake check` rejects figures without both
  descriptions or with alternatives over 140 characters. The authoring
  contract is documented in `docs/ACCESSIBILITY.md`.
- **Release validation**: every build runs EPUBCheck, DAISY Ace and
  book-specific HTML/EPUB checks. Ace reports are retained under
  `build/a11y/`.
- **Kindle compatibility**: every build removes Quarto's unused inline CSS,
  embedded `data:` icons and flex-panel rules before validation. Regression
  tests fail if Amazon-rejected markup returns or if a chapter starts relying
  on CSS that cannot safely be stripped.
- **Print interiors unchanged**: the PT print/ebook PDFs remain 518/490 pages
  and the EN PDFs 505/478 pages; affected table pages are pixel-identical to
  the previous build.

## 1.0.0-preview.7

A homemade model, a leaner back matter, the hardcover covers.

- **New chapter 14, "Um modelo feito em casa"** / "A Homemade Model": the
  author trains a GPT from random weights on a gaming GPU, starting from
  Karpathy's 200-line microgpt (337 million parameters, 10 billion tokens,
  137 hours, about R$ 80 of electricity). The six stations of building a
  model, parameters as brain size and tokens as years of school, the
  stumbles, the gap between valid syntax and a working agent, and why it is
  difficult but not wizardry. Four new figures; technical detail in the
  appendix section "O microgpt por dentro". Checked by the five target
  readers (`reviews/microgpt/`).
- **Leaner back matter**: the projects catalogue (appendix "Os projetos do
  ano") and the technical sections on Frank Investigator and Frank Sherlock
  are parked (`book/parked/projetos-secundarios/`); ch04 and ch17 tell the
  Investigator and FBI experiments in about half the words; FrankClaw is
  described as a stopped experiment.
- **Afterword**: how the simulated readers rebalanced the book, and what
  the author maintains today.
- **Updates**: ai-memory 3.0 (new two-command install), ai-jail 2.9.0.
- **Typesetting**: fewer hyphenated line breaks (about two-thirds fewer),
  after a reader's request.
- **ISBN**: the Portuguese hardcover carries 9798162465683.
- **Hardcover covers**: `rake kdp_cover` builds the wraparound cover from
  KDP's template for each edition's page count.

## 1.0.0-preview.6

For the hardcover.

- **New appendix "Este livro foi escrito por IA?"** / "Was This Book Written
  by AI?": what the agents did and what the author did, why it wasn't two
  prompts, what separates it from slop, and why only an experienced
  professional gets a complete product out of AI agents, with this book as
  the example. Built from the author's making-of post (10/13); the afterword
  points to it.
- **ISBN**: the English edition's copyright page carries the hardcover ISBN
  (9798162395362, assigned by KDP); the Portuguese
  edition has none yet. ISBNs are set per edition in `book/outline.yml`.

## 1.0.0-preview.5

The narrator's history, both languages.

- **The author's longer story behind the first person**: short passages from
  24 Akitando episodes (2018-2023) where his experience backs a claim: the
  dot-com crash lived from inside, five years integrating SAP at large
  companies, the hiring-bubble warnings given on video in 2019, 2020 and 2022
  (and the 2023 call he got wrong), decades of method behind the 2026 agent
  practices, "Não terceirize suas decisões". Every factual claim taken from
  the episodes was checked (`reviews/akitando/factcheck.yml`).
- **Two new appendices**: "Três bolhas" (the dot-com bubble, the
  zero-interest hiring bubble and the AI wave, with verified numbers) and
  "Como estudar com a IA do lado" (learning with an agent, from "Aprendendo a
  aprender"). The mechanics appendix explains reading a "99% accurate"
  claim; the timeline gains the classic method books.
- **Corrections**: the hiring bubble dated from about 2010 (not 2014),
  Akitando 2018-2023, the dot-com crash 2000-2002, 2022 layoffs ~165k.
- **Four new figures** where readers got lost: the two curves in chapter 20
  (base intelligence flattening, task length rising), the three bubbles on
  one timeline, who is on which side in chapter 14, and the three judges in
  chapter 4 without the arithmetic.
- **Consistency**: a full read for the narrator's facts, repetition and tone,
  then a scoped check with the five target readers; new editorial rule R21
  (the narrator's history is evidence, not credentials).
- **Tooling**: background sources (older posts cited and tracked by drift and
  listed on the sources page); EN tracks posts without an English version by
  their PT text; the PDF check ignores titles ending in "???"; 168 tests.

## 1.0.0-preview.4

The edition revised with its target readers, both languages.

- **Read by the people it was written for**: five simulated readers from the
  preface's list (an accountant, a father, a manager, a junior developer, a
  curious retiree) read the whole book three times, between rounds of edits.
  Their reports, the comparison between rounds and every decision are in
  `reviews/1.0.0-preview.3/` (procedure: `docs/PERSONA-REVIEW.md`).
- **Arguments tightened**: the year's conclusion now leads with outside
  evidence and says what the author's saturated benchmark can't show; what
  rising task length (METR) means for jobs, with examples beyond programming;
  no more argument that blames every failure on the request; the worried
  side of the AI-risk debate stated at its strongest, Hinton included;
  generalisations marked as the author's view; the book's own "who profits?"
  test applied to the author's projects.
- **Easier to read**: chapters open by orienting the reader; "Como ler" sends
  each reader to the chapters that answer their question; the speed-up
  figures in one table; a practical "this week" list per reader in the
  epilogue; a paragraph on not pasting client data into a chatbot.
- **Lighter chapters, nothing lost**: programmer-only detail (debugging
  walkthroughs, hardware math, benchmark history, tool internals) moved to a
  new appendix, "Para quem programa: os bastidores"; the reading list moved
  to its own appendix; repetitions cut. Every moved paragraph keeps its link
  to the source post.
- **Chapter 12**: the Genesys PI section is out of the book while due
  diligence is pending (kept, not deleted, in `book/parked/`).
- **Chapter 19** is now "Por que a IA pode falhar na sua empresa", matching
  what the chapter argues.
- **Copyright page**: prints the book's revision and build date, with the
  releases link; the ISBN line is hidden until one is assigned.
- **Tooling**: editorial rules R1-R20 (`docs/EDITORIAL-RULES.md`) with checks
  for canonical figures, opening jargon, generalisations, name-dense prose
  and signature lines; drift also watches parked material;
  `persona_compare.rb`, `balance_report.rb`; 160 tests.

## 1.0.0-preview.3

First copyedit pass, both languages.

- **Copyedit**: a straight-through reader pass over every unit of both
  editions (preface to glossary), with the findings triaged and applied: typos
  and agreement, one spelling for model names, repeated anecdotes turned into
  callbacks, chapter endings that no longer pre-tell the next opening, jargon
  glossed for lay readers. Reports in `reviews/1.0.0-preview.2/`.
- **Facts checked against the sources**: commit counts now state their scope,
  totals recomputed (the skills post's "mais de mil" is 984), the Frank
  Investigator voting example matches the code (figure redrawn), contributor
  counts for ai-memory say what they count, Stack Overflow's founding year.
- **Chapter 14 sources**: the David Sacks, Pirate Wires, Musk/Altman and
  OpenAI Navier-Stokes claims verified against the originals (podcast, posts,
  archived pages); Sacks's wording corrected and the Pirate Wires context
  completed.
- **Photo**: Sam Altman's portrait in chapter 14 is now from 2025.
- **Copyright page** lists AI Lair among the author's names.
- **English edition**: re-synced with the corrected Portuguese, then its own
  reader pass: calques and Portuguese leftovers rewritten, glossary terms used
  consistently, American quotation punctuation throughout, image credits for
  the chapter 14 composite fixed.
- **Tooling**: copyedit procedure with fact-checking against the sources
  (`docs/COPYEDIT.md`, reader and apply briefs in `reviews/`), EN quotation
  check in `rake check`, composite photo credits in the generator, 127 tests.
- Releases: only the two newest are kept on GitHub.

## 1.0.0-preview.2

Second preview, now in two languages.

- **English edition**: *Competent Enough*, a full translation of the
  Portuguese edition in the author's English voice, using his own English
  wording wherever the book follows his posts. EPUB, ebook PDF and print PDF.
- **Cut-off moved to February 2026**: the January articles are out. Chapter 5
  now opens with FrankMD, chapter 3 explains agents and harnesses with later
  evidence, chapter 13 opens on the March mini-PC; callbacks, timeline and
  project appendices repaired across the book.
- **New appendix**: ai-memory, why agent memory matters and how to start
  (aimemory.sh); ai-jail points to aijail.io.
- **Cover**: the robot now wears Marvin's face (the newsletter's character),
  and an author sticker sits beside the name.
- **Quality tooling**: integrity checker (cross-references, citations,
  glossary, figures, provenance, cut-off, callbacks, translation parity),
  change-impact map, chart layout checker, and a regression test suite
  (122 tests) run in CI before every build.

## 1.0.0-preview

First public edition, in Brazilian Portuguese, built from Fabio Akita's 2026
articles on akitaonrails.com (blog commit b9c0292).

- 20 chapters in five parts, two interludes, preface, "Como ler", "Antes de
  começar" (what the book doesn't explain, with a reading list), epilogue and
  afterword.
- Appendices: the machine inside without math, timeline, minimal kit for
  using agents safely, ai-memory (why agent memory matters, quick start), how to read a benchmark or an announcement, the year's
  projects.
- Glossary of 144 terms, 292 references (ABNT), 50 figures with credits,
  list of the original articles behind each chapter.
- Editions: EPUB 3 (epubcheck clean), ebook PDF with cover, print PDF (6 × 9 in).
