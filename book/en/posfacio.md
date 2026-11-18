---
id: posfacio
chapter: "Afterword: How This Book Was Made"
sources:
  - {post: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente, sha256: "a5d74995c975312731dcd96702e6f813f9e1148dbe315a92436c3c045346d70f", commit: "557350127df181c4b124a2c8759648a79e17e4d5"}
  - {post: 2026/10/12/llms-agentes-competente-o-suficiente, sha256: "0178f4ea75a7f6b79e7ae1878ccf3ccfd7fe7c0c4edf57d4cfd3bac2dee3e921"}
  - {post: 2026/04/15/como-falar-com-o-claude-code-efetivamente, sha256: "cb59a9bf2d015a6660ea6fc2ade02b2447f0cc15172c8e0d47847c7a6e4dfc18"}
  - {post: 2026/04/09/20-anos-de-blog-o-ano-em-que-a-ia-finalmente-me-deixou-traduzir-tudo, sha256: "c6451afc1d26d440a2364ebee3249330f54d9e0ddcb493aa7fdba4c9ff72d8c4"}
refs_projects: []
blog_commit: "b9c029231693369b8f895576b491c878aea3e8da"
translated_from: {file: book/pt/posfacio.md, sha256: "bbdafcb9dc64899d74fbd1fae3798a87b939cb80cd29b83332319af9745fc781"}
---

# Afterword: How This Book Was Made {#sec-posfacio .unnumbered}

<!-- src: 2026/10/12/llms-agentes-competente-o-suficiente -->
On October 12, 2026, I published the year's synthesis on the blog, the piece that became @sec-ch20. The next day I started turning those months into a book. The first [commit]{.gls} in this book's repository is dated October 13.

<!-- src: original -->
I had written 131 posts on the blog in 2026, almost half a million words, on subjects ranging from model [benchmarks]{.gls key=benchmark} to bitcoin wallets. Reorganizing all that by hand, alone, would have taken months I didn't have. So I did what this whole book describes: I handed the grunt work to [agents]{.gls key=agente} and kept the deciding, the setting up of the process and the checking for myself.

It's worth telling how it went, for two reasons. You have the right to know how the text you just read was produced. And the process itself is the last example of the book's thesis. The most obvious question, whether this book was written by AI, gets a direct answer in @sec-apfeito.

## A Sealed Inventory

<!-- src: original -->
The first step was an inventory. A script read the 131 posts and stored, for each one, a code computed from the exact content of the file. If a comma changes in the post, the code changes with it. I also recorded the exact point in the blog's history from which everything was read.

Then an agent read each post and filled out a fixed form: the thesis in one or two sentences, the claims a book would need to check, which of them go stale quickly, which lay reader's fear the post answers, what to cut. Of the 131, 96 had AI as their central subject or gave it significant weight. The rest only made it in when they taught something specific, and every AI post left out has the reason written down. Halfway through I changed the cut-off: the January posts came out, and the book's story settled between February and October.

<!-- src: original -->
A lot of what I wrote in February no longer held in September. I reran my benchmark several times during the year, corrected costs, changed my mind about tools. That's why the process has a lineage map, which says which post superseded which and what can still be salvaged from the older one. The chapters tell the most recent state and, when the change teaches something, they tell the change.

From the analyses came a proposed structure: five parts, each answering a reader's fear, twenty chapters and two interludes. I read it, changed it and approved it. Some pieces went in at my request, like @sec-antes and the appendix on the machine's insides (@sec-apmecanica), because I wanted readers to know what the book leaves unexplained and where to learn it.

## The Contract

<!-- src: original -->
Before scaling up, a pilot chapter. The one chosen was @sec-ch05, and it served to calibrate the voice and uncover the questions an agent would have along the way. Every question resolved became a written rule. One of them: when the chapter summary and the post disagree on a detail, the post wins.

Those rules went into a document every agent read before writing, along with the voice guide, which inherits the rules of my blog, and a continuity file saying which chapter explains each concept and what each character is called. It's the [project instruction file]{.gls key=agents-md} from @sec-ch09, at the scale of a book.

<!-- src: original -->
With the contract ready, the chapters were drafted in parallel, in waves, one agent per chapter. Agents working at the same time contradict each other, and that happened.

One chapter said FrankMD had about 130 commits in three days; another, that it had 212 in 19 days. Both numbers came from the posts and were right, they just covered different windows. An integration log collected these conflicts, and the rule became to make the window explicit in each chapter.

On top of everything runs an automatic checker, the equivalent of the [continuous integration]{.gls key=ci} from @sec-ch06. It rejects dashes, phrases banned by the voice guide, stray links in the middle of the text, citations that don't exist in the bibliography and chapters without provenance markers. A chapter with errors doesn't pass.

## What the Checking Caught

<!-- src: original -->
Every number, date and name was checked against three things: the posts, the reference projects (the benchmark repository, the ai-memory one, the ai-jail one and my notes on the home server, which live in a private repository) and primary sources on the internet. A few examples of what that checking caught:

- in the March review of my mini PC with a Strix Halo chip, I had set aside 96 GB of memory for the graphics side. On April 8 I lowered it to 64 GB, and some later posts still said 96. The book uses 64 for everything after April (@sec-ch13);
- a counting bug in one of the benchmark's tools underestimated by 40 to 90 times the cost of the runs done with it before August (@sec-ch11). The book doesn't cite any of those costs;
- in the June post about Claude Fable 5, I wrote that it cost ten times more than Opus 4.8 per run. In July, redoing the benchmark's math, I found that the old estimates left out the tokens read from cache: Opus 4.8 came to about $6, not a little over one, and Fable cost almost double, not ten times. The June post still says ten times; the book reports both the wrong number and the correction (@sec-ch14);
- in the March post about the Claude Code source leak, I wrote that Anthropic had bought Bun at the end of 2024. Bun's own announcement is from December 2025, and that's the date the book uses (@sec-ch16) [@sumner2025anthropic];
- a chapter summary, written by an agent, said that the block on third-party tools (the request signature inside Claude Code) had been broken in less than a day after the code leak (@sec-ch16). The original announcement came out about 30 hours later, and the book says "the next day" [@guthrie2026drm];
- METR's productivity study, which I had described as done on private code, used large open source projects [@becker2025measuring].

<!-- src: original -->
Notice that many of these are corrections to my own blog. In some places, the book ended up more accurate than the posts it came from. And one of them corrected a summary written by an agent, because the source beats the summary, including when the summary comes from the machine.

> The drafts came out fast. Trust in the text came from the checking.

## A Trail for Every Paragraph

<!-- src: original -->
Every paragraph in this book, in the source file, carries an invisible marker saying where it came from: which post, which reference project, or whether it's new text written for the book. The marker disappears when the book is built, so you never see it.

It's there for maintenance. If tomorrow I correct a post, a script recomputes the code for each post, sees which one changed and points to the chapters that depend on it. The marker leads straight to the paragraphs that came from that post, and only those need revisiting. The bibliography plays the same role for outside sources: each reference notes which post cited it.

<!-- src: original -->
The images follow the same logic. The diagrams and charts were written as code, and each chart carries in its own code a note of the chapter its data came from. The AI-generated illustrations are labeled as such, and the prompt, the model and the date of each one are on record.

Real people appear in photographs, with the source and available credit in the caption and in @sec-creditos. Each photo's licensing or permission status is recorded individually, including when permission to reproduce it has not yet been verified. No image of a real person was generated by AI.

## Fake Readers

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
Copyediting checks the text. It lets through the question that matters in a book for lay readers: can the person I wrote it for read it to the end, understand it, and come out convinced? To answer that, the book went through simulated readers. Five came out of the preface's "Who I wrote this for": Marina, an accountant afraid of losing her job; Roberto, a shop owner whose son asked about superintelligence; Carla, a manager who was sold an "AI transformation"; Lucas, a junior developer afraid he chose the wrong career; and Helena, a retired teacher who came for the stories.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
Each one was a read-only agent, reading the whole book in order the way that person would, told to be a reader and not an editor. Each returned a score per chapter, what made them get lost or bored, and the logic flaws they found. An editor consolidated it all. A logic flaw, checked against the text and the posts, was fixed regardless of votes; a clarity issue only went in if more than one reader raised it; a single reader's taste was dropped.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
The first read gave the imbalance a measure. Stories and practical tools worked for everyone, and the measurement-heavy middle, the chapters from @sec-ch11 to @sec-ch13, lost the non-programmers. All five caught the same argument flaws: a conclusion bigger than its evidence in @sec-ch20, reasoning that can never lose in @sec-ch09, a reading guide that sent four of the five to the wrong chapter. Each pattern became a written rule, which the agents read before editing.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
The rebalancing came from there. About 8,000 words of lab notebook left the chapters for @sec-aptecnico, each paragraph carrying its provenance marker; the reading list became an appendix; a whole section was kept outside the book while its verification was pending; every chapter started orienting the reader before the first technical term; and the epilogue got a list of what to do this week, per type of reader. There were three rounds, read, edit and read again, because edits fix the old problem and create the new one: the logic flaws fell from 73 to 53 and 51, and the review stopped when the problems stopped coming back.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
The same five readers later checked the chapters that got my history from before 2026. The verdict became a rule: the narrator's history convinces when it's evidence the reader can check, like the dated warning next to the admitted mistake, and gets in the way when it turns into a résumé. The lines that three or four of them flagged as showing off were cut from the book.

## What I Maintain Today

<!-- src: original -->
The book cites many programs of mine, and a good part of them were experiments of a few days, built to measure something and left in the state where they stopped. In October 2026, what I actually maintained was not much.

On one side, the tools for working with agents: ai-memory (@sec-apmemoria), ai-jail (@sec-apB), ai-usagebar, which shows how much of each AI plan you've used, and ghpending, which gathers the pending issues of my repositories. On the other, the benchmarks: the programming one from @sec-ch11, the classifier one from @sec-ch13 and the languages one from @sec-ch18. The Frank series stays published, each project at the point where I left it. The full list is on GitHub, at github.com/akitaonrails.

## What's Still Mine

<!-- src: 2026/04/15/como-falar-com-o-claude-code-efetivamente -->
In @sec-ch09 I told you how the blog post about talking to Claude Code was written by Claude itself, from a request of mine, and corrected by me while it wrote. This book was made the same way, on a larger scale. This afterword too: the draft came from Claude, running in Claude Code, from a request of mine.

<!-- src: 2026/04/09/20-anos-de-blog-o-ano-em-que-a-ia-finalmente-me-deixou-traduzir-tudo -->
It wasn't the first time that year. In April, Claude Code translated twenty years of blog posts in a little over a day and a half (@sec-interlude1). Ninety percent went smoothly, and the other ten only got sorted because someone read the list of what had failed and went looking for another way.

<!-- src: 2026/10/12/llms-agentes-competente-o-suficiente -->
That's the point of @sec-ch20 applied to the book itself. Any of the good models of October 2026 would have written similar drafts, because the model became a commodity, a nearly interchangeable good. What made the process work was what surrounds it: the inventory, the written contract, the automatic checker, the sources as [oracle]{.gls key=oraculo}, the trail for every paragraph. It's the same old engineering I defended in every chapter, applied to text.

<!-- src: original -->
The repository records the first commit and the drafts of the chapters in the initial structure on the same day. That's the first ten percent from @sec-ch05: impressive, and it says almost nothing about the rest. The other ninety percent is reading, cutting and correcting.

And that part is mine. The experiences in the book are the ones I lived, and the opinions are the ones I wrote over the year, none invented to fill a chapter. I approved the structure. No chapter goes into the book without me reading and approving it, and whatever I send back for rework goes through the same process again.

<!-- src: original -->
The machine wrote fast. I answer for every sentence in this book, including the errors that slipped past the checking. When one turns up, the trail exists precisely so the correction reaches the right paragraph.

> The agents were competent enough to write the draft. Deciding what it said remained my job.
