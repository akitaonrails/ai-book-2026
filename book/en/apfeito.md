---
id: apfeito
chapter: "Was This Book Written by AI?"
sources:
  - {post: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente, sha256: "a5d74995c975312731dcd96702e6f813f9e1148dbe315a92436c3c045346d70f", commit: "557350127df181c4b124a2c8759648a79e17e4d5"}
refs_projects: []
blog_commit: "956fc9ed1cc8e32f61deeef64518eece134fd510"
translated_from: {file: book/pt/apfeito.md, sha256: "7a17487b6eb3aed7455f7e8a36f12983dbb73519661666f0543db75e9736fc6b"}
---

# Was This Book Written by AI? {#sec-apfeito}

<!-- src: original -->
It's the most obvious question about a book like this one, and right behind it come two others: whether it was as easy as it looks, and whether the result is anything more than mass-produced text with nobody behind it.

The step-by-step of how the book was put together is in the afterword (@sec-posfacio), and I won't repeat it here. This appendix answers the three questions directly, and then says what I think this book shows about working with AI.

## Yes and No

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
Yes: a good part of the text you read came first from AI agents. They read the 131 posts I published on the blog in 2026, filled out a form for each one, wrote the drafts of the chapters, translated the book into English, checked facts and read the whole book playing the part of readers. The draft of this appendix also came from an agent, working from the post where I told on the blog how the book was made.

<!-- src: original -->
No: the raw material is mine. Every experience the book tells I lived, and every measurement I made, over eight months, with billions of tokens spent and hundreds of hours of work. The opinions are the ones I wrote during the year. None was invented to fill a chapter.

And the decisions are mine too: the structure in five parts, what goes in and what goes out, the rules the text has to obey, what to do when two of my posts disagree, and the final word on each chapter. The agents typed. I decided what they would type and what went in the trash.

## Two Prompts and Done?

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
No. Making a book with AI is a long way from a "write me a book" prompt. I had to invent the whole process and steer the agents to build every piece of it: the consolidation of the posts, the narrative strategy, what stays and what goes, the copyedit, the fact-checking, the release of each version.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
The first drafts of the chapters in the initial structure were done on the same day the book's repository was born, October 13. That's the fast part. To give you an idea of the rest, some numbers:

- almost half a million words of blog going in, 96 posts about AI, and every post left out with its reason recorded;
- a full copyedit in each language, on top of the fact-check;
- three rounds of reading with five simulated readers, each with a name, a job and the fear that brought them to the book, plus one more read, only of the chapters that gained my history from before 2026;
- more than 140 claims taken from my old videos checked before any of them went into the book;
- almost 170 automated tests just for the tools that build and check the book.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
The first result was often not good enough. In the first round, the simulated readers flagged 73 logic problems.

The conclusion of @sec-ch20 went beyond what my test could measure. One chapter argued in a way that can never lose, putting every agent failure on the request. Four of the five readers were sent to the wrong chapter by the reading guide.

In round two, an apology placed next to a contradiction made all five notice a contradiction that three had previously missed. Each of those flaws became a written rule, and the rounds only stopped when the problems flagged stopped coming back: 73 logic annotations in the first, 53 in the second, 51 in the third.

<!-- src: original -->
The drafts of October 13 are the first ten percent from @sec-ch05: impressive, and they say almost nothing about the rest. Everything that comes after is reading, cutting and correcting.

## Is It Just Slop?

<!-- src: original -->
Slop is the careless volume from @sec-ch10: text that takes up space and answers for nothing. The difference I can show lies in three things you can check.

The first is origin. Every paragraph in the book, in the file it comes from, carries a marker saying which post it came from or whether it was written for the book, and every outside reference is in the bibliography. The afterword explains how that works.

The second is checking. Every number, date and name was checked against my posts, against the projects the data came from and against primary sources. When an agent's summary and the post disagreed, the post won.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
The third is that the checking corrected me too. In June I wrote on the blog that one model cost ten times more than another; with the math redone, it was almost double, and the book tells the wrong number and the correction. In a February post I dated the hiring bubble to 2014; it started around 2010, with interest rates near zero. The afterword lists other corrections of this kind, and a good part of them are to my own blog.

<!-- src: original -->
And what can still be wrong? A good part of the checking was done by agents, and the book itself shows in @sec-ch04 and @sec-ch15 that machines invent facts and that AI audits let things slip. I read and approved every chapter, and there will still be mistakes.

The book is public, and anyone who finds one can open an issue on its repository on GitHub. The provenance marker exists so the correction reaches the right paragraph.

> "It was made with AI" tells you very little, as I argue in @sec-ch16. What tells you something is who checked, against what, and what they did when they found an error.

## What Only Experience Delivers

<!-- src: original -->
Now the part I wanted on record, and it's my opinion, resting on a single case: this book, added to the year's projects. AI helps a lot if you know exactly what you want. A complete product, the kind someone else can use and trust, I've only seen come from the hands of people who already knew how to make it without AI.

A book is a product, and this one was treated as one. It has a specification: the whole structure written in one place, with what each chapter answers and which posts it draws on. It has tests: automated checks that stop the book from being built when a reference points to nothing, when a number appears differently in two chapters or when a paragraph loses its origin. It has reviews, numbered versions and a public record of what changed in each one.

<!-- src: original -->
None of this is new, and that's the point. It's the same safety net from @sec-ch19, tests, continuous integration, suspicious review, rolling back fast, applied to text. It's what got the newsletter from @sec-ch06 live in under a week and kept it running. It's what got the editor from @sec-ch05 out in about 30 hours where I, alone, would have taken about 200: I knew what an editor needed and where it usually breaks.

<!-- src: original -->
The agents made none of the decisions below, and each one is on record in the repository.

A whole section, already written and reviewed, came out of the book and was set aside because its verification was still pending. When the simulated readers got lost in technical detail, about 8,000 words left the chapters for an appendix of their own, for programmers.

When two of my numbers disagreed, the rule was to find out why and state the scope of each, instead of picking the prettier one. Lines the readers took as showing off came out. And the easy version, publishing the drafts of October 13, was turned down.

<!-- src: original -->
Knowing what to decide didn't come from 2026. In 2019 I recorded a video called "Não terceirize suas decisões" (Don't outsource your decisions) [@akitando063]. In October 2022, a month before ChatGPT, I was arguing on the channel for tests, continuous integration and estimates as orders of magnitude [@akitando130].

I also got predictions wrong in that period, and @sec-ch18 tells one of them. What this book drew on were the practices, which I had tested for years before putting an agent to carry them out.

<!-- src: original -->
That's what @sec-ch18 calls seniority: deciding and owning the decision. The agents were competent enough to write, translate and check. Knowing what to ask for, what to accept and what to throw away remained the job of someone who had done it for decades.

<!-- src: original -->
And the question @sec-ch14 tells you to ask of any announcement applies here: who gains if you believe it? I do, because the book is mine. So don't take my word for it alone.

The sources are listed, every paragraph knows where it came from, and the repository is public. Open it, check it, and if you find where I got it wrong, tell me.
