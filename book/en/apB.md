---
id: apB
chapter: "A Minimum Kit for Using Agents Safely"
sources:
  - {post: 2026/03/01/ai-jail-sandbox-para-agentes-de-ia-de-shell-script-a-ferramenta-real, sha256: "7d63767d989884b817bbac1269c970c71952e6fad97fe6cbf93ae433d45d005f"}
  - {post: 2026/04/09/20-anos-de-blog-o-ano-em-que-a-ia-finalmente-me-deixou-traduzir-tudo, sha256: "c6451afc1d26d440a2364ebee3249330f54d9e0ddcb493aa7fdba4c9ff72d8c4"}
  - {post: 2026/05/18/como-memoria-de-agentes-funciona-e-como-melhorar, sha256: "d3fb07c726e86bd9b42611fb749b9d003e1cd59d30a9ee5ffa022457756b375d"}
  - {post: 2026/05/23/criei-sistema-memoria-agentes-codigo-ai-memory, sha256: "7affc35d61367bdb52052b9ae1183aa7b7bcfd9ef6fe0d41991ef93ae0ef1507"}
  - {post: 2026/05/24/criei-widget-waybar-omarchy-monitorar-uso-llms-ai-usagebar, sha256: "cd9100c31ab3aec128bed64a52b43fa6d8f985de0d7091c3700e1bbc98d407de"}
  - {post: 2026/05/24/dicas-e-toolkit-de-ia-do-akita-ai-jail-ai-memory-ai-usagebar, sha256: "26f0dcd680c364b932531c76f61a9c792036f032cf80933911fdf3cd39098a5f"}
  - {post: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas, sha256: "7721d4c6a1750ef667ba1007d1660cafe88fce35576e08524d37f24d0a2bdbf4"}
  - {post: 2026/07/25/ai-jail-update-seguranca-docker-opt-in, sha256: "14fe5e334e5e62c00c7e3dd2d27c2610fcf9a52845b6c86d2b033f5345a5b18e"}
  - {post: 2026/10/06/desastre-no-meu-nas-como-quase-perdi-90-tb-de-dados, sha256: "ce5b5f56096775bf4e37f8762fb0f48af0b4ab3ba7b3a4b46c14a887fc77073d"}
refs_projects:
  - "ai-jail/README.md"
  - "ai-jail/src/cli.rs"
  - "ai-jail/src/bootstrap.rs"
  - "ai-memory/README.md"
  - "ai-usagebar/README.md"
blog_commit: "b9c029231693369b8f895576b491c878aea3e8da"
translated_from: {file: book/pt/apB.md, sha256: "d44205997ddafe99c7c3efd5dc5b1d6fefef918e630a3dd73830f7c99f784ba9"}
---

# A Minimum Kit for Using Agents Safely {#sec-apB}

<!-- src: original -->
This appendix gathers the practical material I pulled out of the chapters so it wouldn't break the story. In @sec-ch15 you saw why an AI [agent]{.gls key=agente} deserves the treatment you'd give an intern holding the admin password. In @sec-ch02 you saw why it forgets what the two of you agreed on an hour earlier. Here is what to do about it, in the order I'd set up the house for someone just starting out.

Step-by-step installation guides were left out on purpose. Tools change versions, names and owners, and a walkthrough copied today would be wrong in six months. What lasts is the job of each piece: what it's for, what it has to guarantee and how to check that it's working. The few commands that do appear are there to show the size of the thing, and each one comes with an explanation.

<!-- src: original -->
The first part applies to any tool and any system. The second shows, as an example, the three open source tools I wrote in 2026 to solve these problems on my own computer. Any tool that does the same job will do.

## The Seven Pieces

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
Each piece covers the hole the previous one lets through. None of them, alone, solves everything:

1. a jail, which limits what the agent sees and changes;
2. snapshots, the undo button for the mistake from minutes ago;
3. an external backup, the copy that survives a dead disk;
4. a permission list, which separates what the agent does on its own from what it has to ask for;
5. the rule that agents don't touch production;
6. memory notes, so the work doesn't evaporate when the session ends;
7. an eye on usage limits, so you don't run out of agent in the middle of a big task.

The first five protect your stuff. The last two protect your work.

## 1. The Jail

<!-- src: 2026/03/01/ai-jail-sandbox-para-agentes-de-ia-de-shell-script-a-ferramenta-real -->
A [sandbox]{.gls} is an isolated environment in which a program only sees and changes what you allowed (@sec-ch15 walks through the idea). For a coding agent, the minimum jail has to guarantee four things:

- the project folder is writable; the rest of your home folder appears empty or does not appear at all, with declared exceptions for areas such as the agent's own credentials;
- sensitive folders stay out: server access keys, cloud credentials, browser profiles with saved passwords;
- the network is cut off or filtered, letting through only what the agent needs to talk to the model and download libraries;
- no shortcut to programs that run as [root]{.gls}, the system administrator.

<!-- src: 2026/07/25/ai-jail-update-seguranca-docker-opt-in -->
That last item looks like a detail, and it was the hole that taught me the most all year. Docker, the [container]{.gls key=conteiner} tool every agent loves to use, handles requests through a program that runs as root, outside the jail. Giving access to it is the same as handing over the house keys (the story is in @sec-ch15). If you need it inside the jail, turn it on for that session only, knowing what you're letting in.

### How to Set It Up, on Each System

<!-- src: 2026/03/01/ai-jail-sandbox-para-agentes-de-ia-de-shell-script-a-ferramenta-real -->
On Linux, the basic building block is bubblewrap, the same isolation tool Flatpak uses for the apps it installs. It builds a fake view of the system for the program, with the folders you choose. On top of it you can write your own script, which is how I started, or use a ready-made tool.

On macOS, the system has a built-in isolation mechanism, `sandbox-exec`, which Apple marks as deprecated but still works. It's less flexible than the Linux one, and some protections only half work.

<!-- src: ref:ai-jail/README.md -->
On Windows, the simplest path is to run the agent inside WSL2, the Linux Microsoft ships inside the system, and use the Linux tools in there. That's what the documentation for ai-jail, my jail, tells you to do [@akita2026aijail; @aijail2026site].

<!-- src: 2026/03/01/ai-jail-sandbox-para-agentes-de-ia-de-shell-script-a-ferramenta-real -->
The big agents also come with their own sandbox, configurable in each one's settings. Worth turning on. Just remember it only protects that one agent, and on the day you switch tools, the protection doesn't come along.

<!-- src: ref:ai-jail/README.md -->
And there's a line none of these jails crosses. They exist to contain the mistakes of a program that you trust but that is fallible. To run code of dubious origin, which may be trying to escape on purpose, the answer is a disposable [virtual machine]{.gls key=maquina-virtual}, a whole simulated computer you throw away afterward.

### Git as a Safety Net

<!-- src: 2026/03/01/ai-jail-sandbox-para-agentes-de-ia-de-shell-script-a-ferramenta-real -->
If you program, you already have a safety net and maybe don't use it properly. With the project in a remote repository and the agent barred from pushing anything there without your approval, the worst it can do is wreck the local copy. Then you go back to the last [commit]{.gls} or delete the folder and clone it again.

The practical rule is simple: make small, frequent commits, keep a remote copy and keep pushing to the remote always in your own hands.

## 2. The Undo Button

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
A [snapshot]{.gls} freezes the state of the disk at an instant. On filesystems with [copy-on-write]{.gls key=copy-on-write}, it's instant and nearly free, because only what changes from then on takes up new space (@sec-ch15 tells how this saved eleven of my albums). You can open the two o'clock snapshot like any folder and copy back the project the agent deleted at three.

What you need to guarantee is short. Automatic snapshots, at least hourly during the day, and a rule for how many to keep per hour, per day, per week and per month. And knowing where to click to recover a file before you need to.

### Linux

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
The filesystem, the way the disk organizes data, has to support snapshots. The one most Linux desktop distributions offer for this is Btrfs, and several offer it at install time. For scheduling, the two classic tools are Timeshift, with a graphical interface and a panel where you check off how many snapshots to keep, and snapper, more detailed, which takes a snapshot before and after every package install.

I use Timeshift on a schedule and, before a session that makes me nervous, I take one by hand:

```bash
sudo timeshift --create --comments "before releasing the agent"
```

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
There's an add-on worth its weight in gold on the day the system won't even boot: grub-btrfs, which lists each snapshot in the boot menu [@antynea2026grubbtrfs]. You pick the snapshot from the day before, boot into it and tell it to restore. The same idea, applied to a whole operating system, saved me a reinstall in the middle of the NAS crisis (@sec-ch15).

### macOS

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
The Mac's default filesystem, APFS, is also copy-on-write and also has lightweight snapshots. With Time Machine on, macOS itself takes local snapshots every hour and keeps the last 24 hours on the internal disk, even with no external disk plugged in. To take one by hand before a risky session, a single command in Terminal does it:

```bash
tmutil localsnapshot
```

Recovery goes through Time Machine itself, which browses the local snapshots and restores the file you choose.

### Windows

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
Here the story is weaker. Windows has shadow copies, which feed the restore points and the "Previous Versions" tab on folders, but they were designed for system files and rarely cover your data at the moment you need it. If you use agents on Windows, treat the next piece as mandatory.

The snapshot solves the accident from minutes ago, in seconds. It lives on the same disk as your data and dies along with it.

## 3. The Copy That Lives Somewhere Else

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
An external [backup]{.gls} is a copy on a separate device: an external drive, a NAS (the network storage box in your home), a cloud service. It covers what the snapshot doesn't, from the dead disk to the stolen computer. A good backup has four properties:

- it runs on its own, on a schedule, without depending on you to remember;
- it keeps several versions, with a retention policy that says how many to keep;
- it's encrypted, so losing the drive doesn't mean handing over your data;
- it gets tested now and then, by actually opening restored files.

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
On my desktop, the job is done by restic, an open source backup program that runs on Linux, macOS and Windows [@restic2026]. It stores only what changed since the previous copy, encrypts everything and restores with one command. A scheduler fires off the copy every night, at three in the morning, to my NAS.

The retention policy is the part almost everyone forgets. Mine keeps seven daily copies, four weekly, six monthly and one yearly, and it fits on one line:

```bash
restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --keep-yearly 1 --prune
```

In plain English: keep the last copy from each of the seven most recent days with backups, the four most recent weeks with backups, the six most recent months with backups and the most recent year with backups, and delete the rest to free up space.

<!-- src: 2026/10/06/desastre-no-meu-nas-como-quase-perdi-90-tb-de-dados -->
In October 2026 I learned that this layer has layers too. A NAS that survives losing one disk protects you against a dead disk, but not against losing the whole device (@sec-ch15). For what's truly critical, keep a third copy outside the house, in the cloud or on a drive kept at another address.

### Without Programming Anything

<!-- src: original -->
If you don't program, the short version of this piece goes like this. On a Mac, turn on Time Machine pointed at an external drive. On Windows, use the backup program that comes with the system or a third-party one, pointed at an external drive or the cloud. And, in both cases, once a month open three or four files from the copy to see that they open.

> The proof that the backup works is the restored file, compared against the original. The "backup complete" message is just the program talking about itself.

## 4. What It Can Do, What It Asks, What It Never Does

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
By default, coding agents ask permission before each command. It's safe and it's exhausting: after the hundredth confirmation of a harmless command, you start hitting "yes" without reading, and the lock stops meaning anything. The other extreme is [YOLO mode]{.gls key=modo-yolo}, in which the agent runs everything without asking anything.

<!-- src: ref:ai-jail/src/bootstrap.rs -->
The middle ground is a permission list in three columns, which nearly every agent accepts in a configuration file:

- **allowed without asking**: commands that only read or that are easy to undo, like checking the repository status, listing files, searching text, running the tests, making a local commit;
- **asks first**: commands that leave your machine or delete things, like pushing to the remote repository, deleting files, spinning up containers;
- **never**: becoming administrator, opening a file's permissions to everyone, throwing away local changes for good, force-rewriting the remote repository's history.

<!-- src: ref:ai-jail/src/bootstrap.rs -->
In Claude Code, this list lives in a JSON configuration file. A chunk of the one my jail generates, as of October 2026, shows the format:

```json
"deny": ["Bash(sudo *)", "Bash(chmod 777 *)", "Bash(git push --force *)"],
"ask":  ["Bash(git push *)", "Bash(rm *)", "Bash(docker run *)"],
"allow": ["Bash(git status *)", "Bash(git diff *)", "Bash(git log *)"]
```

Each entry is a command pattern. The asterisk means "anything from here on." Other agents use other names and other files, but the idea is the same.

<!-- src: 2026/03/01/ai-jail-sandbox-para-agentes-de-ia-de-shell-script-a-ferramenta-real -->
Notice where pushing to the remote sits: in the middle column. The agent can make commits to its heart's content, create branches, reorganize the local history. When it's time to publish, it stops and you review. The force push, which overwrites the remote's history, goes in the "never" column.

### YOLO Mode, Only Inside the Jail

<!-- src: 2026/05/24/dicas-e-toolkit-de-ia-do-akita-ai-jail-ai-memory-ai-usagebar -->
Since May 2026, I've run my agents in YOLO mode nearly all the time (@sec-ch15). That looks like it contradicts everything above, and it would, except for one detail: I remove the lock inside the agent and put a fence at the operating-system level. The agent works fast inside the project, and data I haven't shared stays out of its reach.

The rule I follow is that combination. YOLO mode without a jail means trusting that no wrong command, from any source, will ever show up. With a jail, a remote Git and manual pushes, the realistic worst case is redoing an afternoon of local work.

### Secrets

<!-- src: 2026/05/24/dicas-e-toolkit-de-ia-do-akita-ai-jail-ai-memory-ai-usagebar -->
The most common accident I saw all year was a secret leaking into the repository: a file with passwords that goes into the commit along with everything else and ends up on the remote. It happened to me more than once.

Three habits fix almost all of it:

- before committing, inspect what is staged (`git status` and `git diff --cached`); before pushing, also review every local commit that has not been sent yet, including files removed by a later commit;
- keep passwords and keys in a password manager, so losing the project folder doesn't mean losing the keys to the kingdom;
- if a key leaks, rotate the key; cleaning up the history helps, but whoever copied it before still has it.

## 5. Agents Stay Out of Production

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
This piece is short because @sec-ch15 has already made the whole argument. No agent should have direct access to [production]{.gls key=producao}, the system that serves real customers: no database password, no admin key to the servers.

In a test environment, the agent can work freely, as long as it writes recipes instead of issuing one-off commands. A recipe is a file that describes the desired configuration, is kept in the history and can be reviewed and run again. It writes the recipe, applies it to the test environment, checks and adjusts. A human reviews and promotes it to production.

The production rule, with the story behind it, is in @sec-ch15.

## 6. Notes That Outlive the Session

<!-- src: 2026/05/18/como-memoria-de-agentes-funciona-e-como-melhorar -->
The model doesn't remember you. On every question it rereads whatever fits on the desk you saw in @sec-ch02, and when the desk fills up, [compaction]{.gls key=compactacao} summarizes the start of the conversation and loses detail. Close the session and that's the end of it. The memory that counts is the one you write to a file.

I sort what to keep into three drawers:

- **project rules**: how the project is organized, which commands run the tests, what never to do; they go in the [project instructions file]{.gls key=agents-md} the agent reads when it starts (@sec-ch09);
- **decisions and research**: why we picked this library, the result of that comparison test, the release procedure; they become documents in a docs folder inside the project, versioned along with the code;
- **the work in progress**: the weird bug that showed up, the hypothesis that failed, where the task stopped; it's what gets lost most easily and what's missed most in the next session.

<!-- src: 2026/05/24/dicas-e-toolkit-de-ia-do-akita-ai-jail-ai-memory-ai-usagebar -->
The first two drawers are easy: ask the agent to write and review those files, and check what it wrote. The third is the most tedious, and it's the one I wrote a tool for (@sec-apmemoria). With no tool at all, you can handle it with discipline: at the end of each session, ask the agent for a summary of where it stopped, what failed and what's left, saved in a handoff file that the next agent reads when it starts.

### For Chat Users

<!-- src: original -->
If you only talk to a chatbot, you have the equivalents. The permanent instructions field in most chatbots plays the role of the rules file (@sec-ch09). And a text file of your own, with a summary of what you've already settled with the machine, plays the role of the other two drawers: you paste the summary at the start of a new conversation and don't have to explain everything again.

The summary is yours. It works in Claude, in ChatGPT, in Gemini and in whatever comes next.

## 7. Knowing When to Change Horses

<!-- src: 2026/05/24/dicas-e-toolkit-de-ia-do-akita-ai-jail-ai-memory-ai-usagebar -->
In May 2026, my math went like this: paying for the model per [token]{.gls}, the little piece of text that's the billing unit, came out much more expensive than the companies' own monthly plans, which were subsidized. The price of the subsidy is the limits: per session of a few hours, per week, sometimes per model. And those limits change without much warning.

<!-- src: 2026/04/09/20-anos-de-blog-o-ano-em-que-a-ia-finalmente-me-deixou-traduzir-tudo -->
Hitting the limit in the middle of a big task is the dumbest way to lose an afternoon. That's what almost happened during the blog translation (@sec-interlude1), when I blew past the ceiling of my Max plan for the first time and paid for extra usage on top of the monthly fee.

<!-- src: 2026/05/24/criei-widget-waybar-omarchy-monitorar-uso-llms-ai-usagebar -->
The piece here is a gauge in plain sight. The services themselves usually show your consumption somewhere in the settings, but nobody opens that page in the middle of work. What works is having the number always on screen and an alert before the ceiling. With it, you can decide to:

- start the big refactor only with a fresh quota;
- hand the task to another agent, from another company, when one of them is close to the limit (this is where the notes from the previous piece pay off);
- top up credit before getting stuck, on services that charge by usage.

## My Tools, as an Example

<!-- src: original -->
What follows are the three tools I wrote in 2026 to cover pieces 1, 6 and 7 on my computer. They're open source projects, built largely with the agents themselves, and each one is just one of the possible ways to solve the problem. The versions and behavior described are those of October 2026; check each one's documentation before using it.

### ai-jail, the Jail

<!-- src: ref:ai-jail/README.md -->
ai-jail runs a coding agent inside a sandbox: on Linux, with bubblewrap plus a few protections from the system's own kernel; on macOS, with `sandbox-exec` [@akita2026aijail; @aijail2026site]. On Windows, it only works inside WSL2. In October 2026 it was at version 2.9.0.

The documentation says what it promises: protection against accidents, the limit we saw in piece 1. Against an attacker trying to escape on purpose, it tells you to use a disposable virtual machine (@sec-ch15).

<!-- src: ref:ai-jail/README.md -->
You use it by putting `ai-jail` in front of the agent's command, from inside the project folder:

```bash
ai-jail claude              # runs Claude Code inside the jail
ai-jail --dry-run claude    # shows what would be mounted, without running anything
ai-jail --lockdown claude   # strictest mode: project read-only, almost everything off
```

The first shows everyday use. The second is for auditing before you trust it: it prints the jail's configuration and doesn't execute. The third is the full lockdown mode, which, the documentation warns, is still no substitute for a virtual machine.

<!-- src: ref:ai-jail/README.md -->
By default, the project folder is writable and the home folder is an empty temporary area that disappears at the end of the session. The agent's own credentials get in, so it starts logged in; the documentation calls that a conscious trade-off, and anyone who doesn't accept it runs with `--no-agent-state`. Broad network access, GPU, audio, Docker, SSH keys and cloud credentials are off by default, each with an option to turn it on.

<!-- src: ref:ai-jail/README.md -->
Two usage details that hold for any jail. Secret files inside the project itself, like `.env`, are visible to the agent unless you tell it to hide them with `--mask .env`. And the first run creates an `.ai-jail` file in the folder, with that project's policy, which can go into the repository along with the code. Since that file comes from inside the project, the tool distrusts it: unless you mark that folder as trusted in your personal configuration, it can only tighten the jail, never loosen it.

<!-- src: ref:ai-jail/src/bootstrap.rs -->
Finally, the `--bootstrap` option writes permission settings for five agents, among them Claude Code, Codex, OpenCode and Gemini CLI. The Claude Code one is the three-column list from piece 4, with pushing to the remote under "asks first" and force pushing under "never." Before overwriting any file, it saves a copy of the old one.

### ai-memory, the Notes

<!-- src: ref:ai-memory/README.md -->
ai-memory is the long-term memory I promised in @sec-ch02 and told the story of in @sec-ch20 [@akita2026aimemory; @aimemory2026site]. The idea: a new session, in any compatible agent, starts where the previous one stopped. Hooks installed in the agent quietly record the session, and the server turns the record into plain text pages. The full description, with when it's worth it and how to start, is in @sec-apmemoria.

<!-- src: 2026/05/24/dicas-e-toolkit-de-ia-do-akita-ai-jail-ai-memory-ai-usagebar -->
It covers the third drawer of piece 6, the work in progress. A decision that has to survive for sure still goes into a document inside the project, reviewed and versioned. Automatic memory keeps what might matter later; the document keeps what definitely matters.

### ai-usagebar, the Gauge

<!-- src: 2026/05/24/criei-widget-waybar-omarchy-monitorar-uso-llms-ai-usagebar -->
ai-usagebar was born in May 2026 out of a small irritation: I wanted to see my usage of the Anthropic and OpenAI plans in one place, without opening any page [@akita2026aiusagebar]. It started as a Rust rewrite of a similar tool that only covered Claude [@mryll2026claudebar].

<!-- src: ref:ai-usagebar/README.md -->
In October 2026 it showed, in the system bar or in a terminal window, how much of each limit has been used and when it resets, for a long list of services, from Claude and Codex to resellers that charge by usage. For the Anthropic and OpenAI plans, it reads the credentials the official programs have already stored on the computer. By default, it warns you when a limit passes 97%.

<!-- src: ref:ai-usagebar/README.md -->
The bar version was made for the Linux I use, but the terminal one runs anywhere, and the documentation describes integrations with other Linux desktops and a tray icon for macOS and Windows. On my screen, it answers a single question: do I keep going with this agent, hand the task to the other one or wait for the quota to reset?

## The Pocket Version

<!-- src: original -->
If you take only one list from this appendix, take this one:

- run the agent in a jail that limits access to your data to the project and the exceptions you have checked;
- have automatic snapshots and know how to recover a file from them;
- have an automatic, encrypted backup on another device, and test the restore;
- let the agent do on its own only what's easy to undo, and publish, delete or leave the machine only with your approval;
- keep the agent away from production;
- keep the rules, the decisions and the work in progress in files that are yours;
- put the usage gauge in plain sight.

No item depends on which model is the best of the month. All of them still hold when that changes.
