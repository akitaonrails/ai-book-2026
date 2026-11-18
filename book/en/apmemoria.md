---
id: apmemoria
chapter: "ai-memory: The Memory That's Yours"
sources:
  - {post: 2026/05/18/como-memoria-de-agentes-funciona-e-como-melhorar, sha256: "d3fb07c726e86bd9b42611fb749b9d003e1cd59d30a9ee5ffa022457756b375d"}
  - {post: 2026/05/23/criei-sistema-memoria-agentes-codigo-ai-memory, sha256: "7affc35d61367bdb52052b9ae1183aa7b7bcfd9ef6fe0d41991ef93ae0ef1507"}
  - {post: 2026/06/14/ai-memory-arquitetura-emergente-e-software-maleavel, sha256: "68cd4f9383ab76b6254ca44ae0534b14dc61232c168057662c74b927301cbaa5"}
  - {post: 2026/06/16/ai-memory-memoria-longo-prazo-karpathy-wiki-auto-aprendizado-hermes-projetos, sha256: "220f2aa87ca303b81e0243476a91d7ade254a523fef32dbc1ed5d022cd2ce586"}
  - {post: 2026/07/20/novidades-no-meu-ai-memory-cada-vez-melhor-pra-usar-com-suas-ias, sha256: "5625b6aad01f359e9449990267619c7689cade8f013ab44db52c674f6cdbf5b0"}
  - {post: 2026/09/02/ai-memory-2-0-melhor-sistema-memoria-agentes-e-times, sha256: "2472ba7ff40ae00a71cdc26106eb3c8b9d3353d85e42af2d1f5171f012640ec4"}
refs_projects:
  - "ai-memory/README.md"
  - "ai-memory/CHANGELOG.md"
  - "ai-memory/docs/install.md"
  - "ai-memory/docs/local-embeddings.md"
  - "ai-memory/docs/cross-project-profile.md"
blog_commit: "b9c029231693369b8f895576b491c878aea3e8da"
translated_from: {file: book/pt/apmemoria.md, sha256: "ec53e355db0ddf37501f1b0b408d4cf9cfa4e60a1ad570bf8502c96d7c3f16dc"}
---

# ai-memory: The Memory That's Yours {#sec-apmemoria}

<!-- src: 2026/05/23/criei-sistema-memoria-agentes-codigo-ai-memory -->
A scene that repeated itself all year on my computer: Claude Code gets stuck on a bug after an hour of conversation. I close it, open Codex in the same folder to look at the problem from another angle and, before it helps with anything at all, I spend a good while explaining the project all over again, what we've already tried and what went wrong.

<!-- src: 2026/06/16/ai-memory-memoria-longo-prazo-karpathy-wiki-auto-aprendizado-hermes-projetos -->
At that moment, the one holding the context is me. The programmer becomes the agent's cache, the fast memory it looks things up in because it has none of its own.

This appendix is about the tool I wrote to stop doing that, ai-memory [@akita2026aimemory; @aimemory2026site]. The safety kit in @sec-apB already showed the idea in a few lines, as the sixth piece. Here's the full version: why it's worth it, what it does, when you don't need it and how to get started.

## Why Memory Matters

<!-- src: 2026/06/16/ai-memory-memoria-longo-prazo-karpathy-wiki-auto-aprendizado-hermes-projetos -->
You already know the goldfish from @sec-ch02. The model remembers nothing from one conversation to the next, the desk starts empty every session, and when it fills up midway [compaction]{.gls key=compactacao} swaps the start of the conversation for a summary that loses detail. A huge [context window]{.gls key=janela-de-contexto} doesn't change that: it's big, but it belongs only to the current session.

What gets lost is precisely the expensive part of the work. The code shows what survived. The session holds the rest: the experiment that failed, the intermittent bug, the reason we changed our minds after three hours. Close the agent and it's gone.

<!-- src: 2026/05/18/como-memoria-de-agentes-funciona-e-como-melhorar -->
In @sec-ch02 I also showed the home remedy, which still works: agent memory is text, and you can write your own notes in a docs folder in the project. The remedy's flaw is discipline. To keep those notes up to date, I still have to remember to ask and check, every time, including on the days I'm tired.

### The Vendor's Padlock

<!-- src: ref:ai-memory/README.md -->
The big agents noticed the problem and keep gaining memory features. Claude Code takes its own notes, Cursor remembers some things, and every platform adds a little more with each version. They all run into the same limits: the notes live on one machine, belong to one agent and drop out of sight when you switch tools or hand the work to a colleague.

<!-- src: 2026/07/20/novidades-no-meu-ai-memory-cada-vez-melhor-pra-usar-com-suas-ias -->
In @sec-ch20 I explained why that bothers me: if the project's memory lives inside one company's tool, switching tools turns into moving house, and the longer you stay, the heavier the move gets.

<!-- src: 2026/05/18/como-memoria-de-agentes-funciona-e-como-melhorar -->
These tools' notes are text, as @sec-ch02 showed, so in theory you can take them with you. In practice, each one keeps them in a different place, format and machine, and nobody does the moving for you.

> An agent's session is the most expensive part of the work, and it belongs to whoever did the work, whatever tool recorded it.

## What ai-memory Is

<!-- src: ref:ai-memory/README.md -->
ai-memory is long-term memory for coding agents, [open source]{.gls key=codigo-aberto}, distributed as a single [binary]{.gls key=binario}, one program that doesn't depend on other services to run. The promise is that the next session, in any compatible agent, picks up where the previous one stopped, without you re-explaining the architecture, the failed approaches or the open questions.

<!-- src: 2026/06/14/ai-memory-arquitetura-emergente-e-software-maleavel -->
The origin of the project, in May 2026, is told in @sec-ch20. It started as a version for one user, on one machine, on one operating system, and grew with outside people using it and sending fixes. On October 13, 2026, version 3.0 came out.

### How It Works

<!-- src: ref:ai-memory/README.md -->
The cycle has four beats:

- **capture**: [hooks]{.gls key=hook}, small triggers the agent itself fires on every event, quietly record what happens in the session (requests, commands used, start and end), and a filter strips out sensitive data before anything is stored;
- **consolidation**: at the end of the session, that record becomes readable pages in a project wiki, in the spirit of Karpathy's LLM Wiki that showed up in @sec-ch02;
- **lookup**: the next session, in any compatible agent and on any machine, starts with a short summary and can search the rest;
- **handoff**: one agent leaves the next a formal note saying what was done, what failed and what was left open.

<!-- src: 2026/06/16/ai-memory-memoria-longo-prazo-karpathy-wiki-auto-aprendizado-hermes-projetos -->
The agent talks to the memory through [MCP]{.gls}, the standard plug that connects tools to agents. In practice, you ask "have we discussed this?" and it goes and looks, without you needing to know where the page is.

### What It Does as of October 2026

<!-- src: ref:ai-memory/README.md -->
The feature list has grown a lot since May. The ones that matter most for newcomers:

- **it follows you across agents**: more than twenty [harnesses]{.gls key=harness}, from Claude Code, Codex, Cursor, Gemini CLI and OpenCode to lesser-known ones, feed the same memory;
- **it follows you across machines**: the memory lives on a server that's yours, on your own computer or on a machine at home, so the project you left on the desktop is the same one you pick up on the laptop;
- **it works for a team**: everyone points at the same server, what one person's session learns the other's agent finds, and every write records who made it;
- **it keeps everything in [Markdown]{.gls key=markdown}**: the memory is a folder of plain text files, versioned with Git, and the database is just an index that rebuilds itself from them;
- **it carries your habits from one project to the next**: a short profile of how you work, like your package manager and how you organize tests, reaches each new repository as a default suggestion, below the project's own rules.

<!-- src: 2026/09/02/ai-memory-2-0-melhor-sistema-memoria-agentes-e-times -->
Since 2.0, every page follows the Open Knowledge Format, an open format that other tools can read. You can open the folder in Obsidian, search it with [grep]{.gls}, edit it by hand or hand the bundle to a colleague who uses something else. That was the 2.0 change I liked most, because it puts the project's thesis in writing: the memory isn't held hostage, not even by my program.

<!-- src: ref:ai-memory/docs/local-embeddings.md -->
Search combines the literal word with the meaning. Since 2.0, the program downloads on its own, the first time it runs, a small [embeddings]{.gls key=embedding} model that runs on your own computer, with no API key and without sending anything out. That way a question about "how do we publish" finds the page that talks about "release procedure," even with no word in common.

### What It Does Without Asking Anyone for Anything

<!-- src: ref:ai-memory/README.md -->
The default path doesn't call any language model. Capture, search and handoff work with no API key and no per-use cost. With a model configured, session summaries get better, but that's optional.

Memory also ages, and what you use ages more slowly: opening a page, finding it in a search or reaching it through a link counts as use. That reinforcement is always on, because all it does is hold on to memory longer. And nothing is deleted for good: the old version stays in the Git history and can be brought back.

The features that rewrite or discard content come switched off. The most curious one is a "dream," similar to the Claude Code one @sec-ch02 described: with a model configured, while you're not working, a process rewrites groups of old notes into a single page and stops as soon as you come back.

<!-- src: 2026/06/16/ai-memory-memoria-longo-prazo-karpathy-wiki-auto-aprendizado-hermes-projetos -->
There's a reason for the caution. Bad memory is worse than no memory, because an agent with no memory asks, and an agent with wrong memory acts with false certainty.

### For Agent Hoppers, and for Teams

<!-- src: 2026/07/20/novidades-no-meu-ai-memory-cada-vez-melhor-pra-usar-com-suas-ias -->
A handoff is a summary, and every summary loses something. For people who switch agents all the time, like me, there's a managed mode: instead of opening the agent directly, you open it through an ai-memory command. It ties each agent's sessions to a shared line of work, and when you go back to Claude Code after an hour in Codex, Claude resumes its own session and gets only what happened in the others in the meantime.

<!-- src: 2026/09/02/ai-memory-2-0-melhor-sistema-memoria-agentes-e-times -->
And the handoff has an owner. On a shared server, the pages belong to everyone, but the pending note you left is yours: exactly one session picks up the baton, and a colleague's agent doesn't consume yours by mistake.

## When It's Worth It, and When It Isn't

<!-- src: 2026/05/23/criei-sistema-memoria-agentes-codigo-ai-memory -->
If you use a single agent, on a single computer, and stick with it, you may not need any of this. The agent's own compaction plus a well-kept docs folder, as in @sec-ch02 and piece 6 of @sec-apB, cover the essentials.

<!-- src: ref:ai-memory/README.md -->
ai-memory starts paying for itself in four situations:

- you switch agents in the middle of a project, because of quota, price or because one of them got stuck;
- you work on the same project on more than one machine;
- you come back to a project after weeks and don't remember where you left off;
- you work on a team and want what one person learned to reach the other's agent.

<!-- src: 2026/07/20/novidades-no-meu-ai-memory-cada-vez-melhor-pra-usar-com-suas-ias -->
It also doesn't replace the project's documents. Automatic memory keeps what might matter later; decisions, rules and procedures that need to last for months still deserve a document you reviewed, inside the repository. A raw session is evidence. A document is organized knowledge.

<!-- src: ref:ai-memory/README.md -->
And it has a cost. It's one more program running on your computer, with a server that has to be up when the agent starts. It records what happens in your sessions, filtered, but it records, so it's worth knowing where the data folder lives and backing it up like anything important. In the initial configuration, the server only accepts connections from the computer itself and already comes with a password; before opening it to a network or a team, read the authentication part of the documentation.

> Automatic memory saves you the repeated explanation. The important decision still deserves a document you reviewed.

## Getting Started

<!-- src: ref:ai-memory/README.md -->
The shortest path, with version 3.0 from October 2026, is two commands in a Linux or macOS terminal:

```bash
curl -fsSL https://github.com/akitaonrails/ai-memory/releases/latest/download/install.sh | sh
ai-memory setup
```

<!-- src: ref:ai-memory/README.md -->
The first downloads the right program for your system, checks that the file arrived intact against the published checksum, and only installs it if they match. The second creates the data folder with a password kept in a file only you can read, leaves the server running as a service of your user and connects ai-memory to every agent it finds on the computer. It shows the plan and asks before touching anything. Afterwards, restart your agents.

Claude Code and Codex users can also connect the memory to the agent through a plugin, using each one's own extension system; the program is still installed the same way.

<!-- src: ref:ai-memory/README.md -->
From then on, you talk to the agent as usual. Ask "where did we leave off?" to resume a handoff, "have we discussed this?" to have it search the memory, or "catch me up" for a summary of what happened in the project. On an old project, with months of history, the `ai-memory bootstrap` command, run once, makes use of what's already there.

<!-- src: original -->
Those two commands are a snapshot of October 2026. There are paths for Docker, packages for Arch Linux and Fedora, a menu bar app for macOS and a mode for Windows, and all of them change from version to version. The up-to-date instructions, in English and Portuguese, live on the project's site, aimemory.sh [@aimemory2026site]. Start there.

<!-- src: 2026/09/02/ai-memory-2-0-melhor-sistema-memoria-agentes-e-times -->
You don't need my program to follow the principle. The tool can be this one, another one, or a folder of text files kept by hand. What matters is that the project's memory lives somewhere that's yours, in a format you can read, and that it survives a change of agent, of machine and of company. It's the same math as in @sec-ch20: you rent the model from whoever is best that month, and the memory stays with you.
