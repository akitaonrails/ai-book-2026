---
id: interlude2
chapter: "Interlude: From GNU Go to KataGo"
sources:
  - {post: 2026/07/06/frank-go-brincando-de-go-com-ia, sha256: "8d82673fdde8aec1be193186798439905655063b4cc1bfa5997c852a939bda0f"}
  - {post: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas, sha256: "7721d4c6a1750ef667ba1007d1660cafe88fce35576e08524d37f24d0a2bdbf4"}
refs_projects: []
blog_commit: "b9c029231693369b8f895576b491c878aea3e8da"
translated_from: {file: book/pt/interlude2.md, sha256: "05906c02ef6c05c18b6f74abfb60d1d4fa7ed5f5e33ed27b8c8c5b01876cc207"}
---

# Interlude: From GNU Go to KataGo {#sec-interlude2 .unnumbered}

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
I own a goban. That's the Go board, the grid of 19 by 19 lines where two players alternate black and white stones, each trying to surround more territory than the other. I never joined a club, a federation or a tournament, and I don't intend to. I like playing solo, solving tsumego, Go's life-and-death puzzles, and replaying famous games stone by stone.

Blame a manga. *Hikaru no Go*, written by Yumi Hotta and drawn by Takeshi Obata, the same artist as *Death Note*, ran in Shonen Jump magazine from 1998 to 2003 and set off a Go boom across all of Japan. Nearly every game drawn in it is a real historical game, recreated move by move.

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
In July 2026, in the middle of a whole year spent testing artificial intelligence, I decided to do something purely for fun: build the Go study app I had wanted my entire life. And, while I was at it, see up close how much Go AIs had matured since the first time I played against one.

That first time was in 2008.

## The Aimless Opponent

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
In July 2008 I wrote a post on my blog arguing that programmers should play Go. Back then, the only artificial opponent within anyone's reach was GNU Go, a free program that still exists today [@gnu2009gnugo]. Calling it an AI was generous. It was a pile of [heuristics]{.gls key=heuristica}, little handwritten rules along the lines of "if the stone is threatened, protect it," stacked one on top of another.

And it played badly. Even an amateur like me could see the lack of direction: loose stones that didn't talk to each other, no sense of where the game was going, no plan. It beat beginners on local tactics, move by move, and that was it.

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
In the years that followed, the programs improved with a technique called [Monte Carlo tree search]{.gls key=mcts}. Instead of following fixed rules, the program simulates thousands of random games from the current position and prefers the move that most often ended in a win. That raised the level considerably. Even so, the programs remained well below a real professional.

<!-- src: original -->
Go had a reputation as a game no computer would master anytime soon. The number of possible positions is too large for brute force, and good players talk about "shape" and "intuition" the way people talk about aesthetics.

## Five Games in Seoul

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
That reputation died between March 9 and 15, 2016, in a Seoul hotel. AlphaGo, a program from DeepMind, Google's lab, faced South Korea's Lee Sedol, one of the greatest players in history, in a five-game series, and won 4 to 1 [@deepmind2026alphago; @wikipedia2026alphagoleesedol].

The series became famous for two moves. In game 2, AlphaGo played stone 37 on a point a human professional would hardly consider, a "shoulder hit" against a white stone that commentators called creative and unique. Lee Sedol took an enormous amount of time to respond.

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
The human reply came in game 4, on March 13. With the series already lost, Lee Sedol played stone 78, a wedge in the middle of Black's area that no commentator had foreseen. AlphaGo didn't see the danger either: it went on thinking it was the favorite for several moves, only noticed the damage around move 87, and ended up resigning. Chinese professional Gu Li called the move divine, and it became known as the "hand of God."

![Game 4 of Lee Sedol (White) against AlphaGo (Black), on March 13, 2016: the only human win in the series, turned around by move 78. Diagram: Wesalius, CC BY-SA 4.0, via Wikimedia Commons.](assets/figures/interlude2-partida-4.png){#fig-interlude2-partida-4 fig-alt="Board records game 4 between Lee Sedol and AlphaGo, the only human win in the series." fig-desc="Diagram of a 19 by 19 Go board, covered with black and white stones numbered in the order they were played, recording game 4 between Lee Sedol and AlphaGo, which ended with AlphaGo resigning."}

It was the only game AlphaGo lost to a human being in that series. Anyone who wants to feel the mood of that week, without knowing anything about Go, has a documentary, *AlphaGo*, from 2017, that follows the series closely [@kohs2017alphago].

<!-- src: original -->
The rest of the story is less cinematic. In November 2019, Lee Sedol retired from professional Go. In an interview with the South Korean news agency Yonhap, he explained that even if he became number one again, there was an entity that could not be defeated [@vice2019leesedol].

> Lee Sedol lost the series, but the move the machine didn't see coming is his. A superhuman AI can still be caught by surprise.

## A Champion for Free on Your Computer

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
After DeepMind published its papers, the [open source]{.gls key=codigo-aberto} community chased it down. First came Leela Zero, a volunteer project that reimplemented the recipe. Then KataGo, by programmer David Wu, who in 2019 published a paper showing how to reach the top with fewer than 30 graphics cards, where earlier projects had used thousands of processors [@wu2019katago].

In 2026, anyone can download KataGo, for free, and have at home an opponent stronger than any human professional [@wang2023adversarial]. It runs even without a graphics card, on the processor alone, just more slowly [@lightvector2026katago].

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
That's what I used to build Frank GO, one more in the family of projects I name in honor of Frank Rosenblatt (@sec-ch05). I asked Claude Code to research the most widely used open source Go programs and picked a foundation: Sabaki, by Yichuan Shen, a beautiful, well-kept game editor. Frank GO is a [fork]{.gls} of it, a copy that goes its own way, wired up to KataGo.

I brought together in one place material that was scattered all over the internet:

- more than 4,700 tsumego from classic collections, organized into ten difficulty levels;
- historical games, from the nineteenth century to AlphaGo's games against Lee Sedol;
- 15 games from *Hikaru no Go*, with the manga chapter where each one appears.

Every collection comes with its origin and license documented, because you use other people's archives by giving them credit.

### Territory Instead of Percentages

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
What I changed most was the screen. Almost every Go program is built by strong players for strong players, and shows the analysis as a "win rate," something like 63% for Black. To someone who's learning, that number says nothing. It doesn't explain what's wrong, where, or by how much.

KataGo has an advantage that mattered a great deal in my case. Beyond the chance of winning, it estimates the score and works out, point by point, who owns each part of the board. It always knew how to do that math; someone just had to put the result on screen in a way a beginner understands.

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
So Frank GO paints the board. Each player's influence shows up as a soft gradient, settled territory in solid color, and groups that are already dead go dark. A live score shows how many points you're behind, already counting the komi, the compensation points White gets for playing second.

"You're 12 points behind and the lower left corner just died" teaches more than any percentage.

> The same kind of AI that drove a champion into retirement became, on my desk, a patient teacher. All it took was showing on screen the math it was already doing: who controls what, and by how many points.

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
Everything runs on the computer, no account, no server, no internet. It's deliberately a solo study app. For years I had wanted to play at my own pace against an AI that plays beautifully, instead of spitting out senseless stones like the GNU Go of 2008. Eighteen years later, I pulled it off.

## The Blind Spot

<!-- src: original -->
The story has a footnote. Between 2022 and 2023, a group of researchers trained a program with a single mission: find a way to beat KataGo. The program they created plays Go badly and loses to amateurs, but it discovered a trap: slowly encircling a group of KataGo's stones with an enormous loop while distracting the machine with moves in another corner of the board. KataGo, superhuman as it is, didn't notice the encirclement until it was too late [@wang2023adversarial].

The trap was simple enough for a human to learn. One of the study's authors, Kellin Pelrine, a strong amateur, began beating KataGo regularly, with no computer help during the games. And the flaw was still there even in versions of KataGo trained specifically to defend against it.

<!-- src: original -->
KataGo still plays better than any professional in a normal game. The episode shows something that holds for any AI: a system can be better than everyone at almost everything and, at the same time, have a blind spot none of its creators saw, one that only shows up when someone goes looking for it on purpose.

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
In Go, the price of a blind spot is losing a game. The same week I published Frank GO, social media was talking about something else: a coding agent, running on its own on a well-known user's computer, had deleted almost all of his files.

I had been letting agents run commands on my own computer without asking permission for two months, and it had never happened to me. Then again, I never trusted them blindly either.

The next question is how much of your computer, your files and your data you hand over to a machine that might have a blind spot the size of your hard drive.
