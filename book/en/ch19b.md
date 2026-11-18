---
id: ch19b
chapter: "The World Won't Wait"
sources:
  - {post: 2026/10/16/estamos-no-futuro-carros-voam-e-nao-temos-mais-que-fazer-html-css, sha256: "f613b05ef48e2e87059d8aff68466ed58548dfb61f27cb387e2b6520897c4178", commit: "760caa8f77017b84661ed95fcca0f0d61b222594"}
  - {post: 2020/04/01/akitando-76-guia-definitivo-de-aprendendo-a-aprender-a-maior-bronca-da-sua-vida-rated-r, sha256: "4c8343cf9487f3e389341a2e5654a423cb2ff2cced3ecbbddb5aed5385b544c1"}
  - {post: 2021/01/06/akitando-90-o-que-os-cursos-nao-te-ensinam-sobre-mercados, sha256: "5a6b08a8fdebc6eac5511e470883960e1f763187351f8df54e684349eee446c1"}
refs_projects: []
blog_commit: "79bca4b5ce7a7bc72f950b923318e9ca2c04b01d"
translated_from: {file: book/pt/ch19b.md, sha256: "9c6bc63860b7cbc5d6dc682f4c16bfdfe63a14501d915918c95eef2b2e2d10fb"}
---

# The World Won't Wait {#sec-ch19b}

<!-- src: 2026/10/16/estamos-no-futuro-carros-voam-e-nao-temos-mais-que-fazer-html-css -->
It was past two in the morning on October 16, 2026. I was in my office, still awake after a day fiddling with my websites, watching the unveiling of the new **Tesla Roadster**. I saw the prototype climb a ramp, hang upside down and, on another run, spin in midair and land. It was a controlled demonstration, a long way from anyone being able to fly around town.

Even with that distance between demonstration and product, I was happy as hell. This was the kind of future I wanted to see. Something less cinematic had happened on my computer: in about a day, I had redesigned six existing sites with agents, without writing most of the HTML and CSS by hand.

![The Roadster at the October 2026 demonstration: a prototype, a long way from being available to fly around town.](assets/figures/ch19b-roadster.jpg){#fig-ch19b-roadster width=3.4in fig-alt="Silver sports car suspended above a dark track, with visible jets beneath its body." fig-desc="The car appears with all four wheels off the ground. Several bright jets emerge from underneath toward the track, where an illuminated cloud spreads. The isolated image does not establish the maneuver's duration, speed or safety conditions."}

<!-- src: original -->
I once made money doing some of that manual work. Taking a designed screen, turning it into a page and adjusting it until it worked in the browser paid my bills. Now I was celebrating being able to delegate it.

That happiness may seem strange in a book that welcomed readers worried about their jobs. But it would be dishonest to spend chapters explaining how much agents already do and then, when discussing careers, promise that no jobs will disappear. I expect many to disappear, including jobs held by competent people.

I also expect work to appear that I can barely describe today. I don't know how much, how soon or for whom. What I refuse to wish for is a world frozen at the stage when I learned to make a living.

## The work I was happy to lose

<!-- src: 2026/10/16/estamos-no-futuro-carros-voam-e-nao-temos-mais-que-fazer-html-css -->
The six sites were AI Lair, the ai-memory and ai-jail sites, The M.Akita Chronicles newsletter, its archive and my blog. They all already existed. I was rebuilding their interfaces, across five repositories, with the knowledge I already had of the products.

That distinction matters. I didn't build six companies in a day or discover six market needs. The content, the programs and many of the earlier decisions were already there. The experience shows how much I managed to accelerate a renovation with a known scope; it doesn't measure how long any team would take to create any product.

The previous versions had that look I had started to recognize before reading the title: dark background, purple gradient, huge type and rounded cards. Asking Claude for a different design produced variations of the same thing. I accepted it because it worked, until I got tired of it.

I used Google's **Stitch** to explore visual proposals, and Claude Code and Codex to bring those proposals to the real sites. ai-memory got the idea of a memory archive. The newsletter got a late-night broadcast. For AI Lair, I drew on the 1950s and 1960s world's fair already on this book's cover.

Bad versions followed. Some had one usable piece; others I told the agents to throw away entirely. Choosing a metaphor helped; I also had to notice when it got in the way of reading, when the page became overblown or when a pretty image competed with what the visitor needed to understand.

### What the prototype hides

The work continued on internal pages and mobile. A visual direction had to survive the long article, the form, the error state and the email. The agents implemented, checked and corrected; I decided what to preserve and what to try again.

I also requested simulated readings by visitors with different profiles. On ai-jail, they helped uncover a false promise about the network being off by default. On ai-memory, they flagged contradictory explanations of permissions and basic information buried under advanced features.

These visitors were model-generated simulations. Their observations were hypotheses to check. I still had to compare each claim with the product and, afterward, hear from actual people.

I didn't end the day thinking I had become an award-winning designer. A professional designer would find plenty to improve. I ended it with sites better than the previous ones, adequate for what I needed at that moment, and the ability to keep working on them without treating every attempt as an unrecoverable investment of weeks.

<!-- src: original -->
That's the work I was happy to lose: the obligation to manually carry out every transformation between a decision and a working interface. I'm still interested in finding out whether the decision is any good. The cheaper execution gets, the more versions I can compare before committing to one.

> Software engineering exists to solve problems using computers. Code is one of the available means of getting there.

If you write less code and solve the problem better, you did a better job. If you write a mountain of code and nobody can use the result, the effort doesn't rescue the delivery. That standard already applied when a person typed every line.

## Yes, jobs disappear too

<!-- src: original -->
The distinction between task and job helps explain the change, but it doesn't protect an employment contract. Imagine a company with stable demand whose team spends much of the week implementing variations of familiar screens. If fewer people can deliver the same result at sufficient quality, the company may shrink the team.

It may also use that capacity to address a backlog of problems that kept getting postponed. It may create another product. These possibilities compete for budgets, customers and priorities; none happens automatically to compensate for every job eliminated.

The problem with saying "AI only replaces people who type" is that it seems to offer immunity to anyone who considers themselves a real programmer. A professional can understand the business, work well and lose their job because the company needs fewer people. They may be hit by a bad management decision, a competitor or the disappearance of the entire product.

Studying doesn't guarantee that the market will reward each person in proportion to their effort. Education and experience expand what you can do. The market can still stop buying precisely the thing that was paying your bills.

<!-- src: 2026/10/16/estamos-no-futuro-carros-voam-e-nao-temos-mais-que-fazer-html-css -->
When I moved from websites and agencies to enterprise systems integration, I had to learn a different world. Other changes followed, including video, education and AI projects. The part of my career that carried across those phases was the ability to learn the next problem; no particular interface would have served all of them.

<!-- src: original -->
In @sec-ch18 I told the story of the shift from punch cards to agents. Here is the consequence I still needed to spell out: each automated layer allows some of the work that supported the previous layer to be dispensed with. Innovation that replaces an activity makes that activity less necessary, even when good people still earn their living from it.

### The bills don't wait for the economy

A society that needs less effort to obtain the same result can use that capacity for other needs. That's why I consider automating repetitive work desirable. Preserving every existing task would mean giving up precisely that gain.

But the person who lost their job pays rent before the economy figures out where to use the freed capacity. Finding another job, training and support during the transition are concrete problems. Recognizing that cost doesn't require arguing that technology should stop; it requires us to stop selling the transition as painless.

Calling every novelty progress doesn't help either. A system that became cheap because it started billing incorrectly, excluding users or shifting work onto the customer made the service worse. The comparison must include the result delivered to whoever depends on it, as we discussed in @sec-ch19.

> The fact that an activity paid your bills for years doesn't oblige the world to keep needing it.

I understand the attachment. Learning a profession takes time, and finding out that part of it has lost value can feel like a devaluation of the entire effort. But trying to preserve the old difficulty doesn't restore the usefulness it once had.

I'd rather carry what I learned into another problem. Knowing browsers still helps me spot a broken page, even when I let the tool write the code. And if tomorrow the tool also checks some of that better, I need to keep looking for where my knowledge makes a difference.

## A film by Christopher Nolan

<!-- src: original -->
In its presentation of *The Odyssey*, Universal highlights "a film by Christopher Nolan": a film by **Christopher Nolan** [@universal2026odyssey]. We understand that attribution without imagining he single-handedly made everything that appears on screen.

The directing credit exists alongside the credits of the other professionals, who also make creative decisions:

![Nolan and the crew filming The Odyssey. Direction brings together specialized work, with authorship and credits of its own.](assets/figures/ch19b-nolan.png){#fig-ch19b-nolan width=3.65in fig-alt="Nolan on the left, crew and a camera on tracks in the center, two performers in costume on the right, at an outdoor location." fig-desc="Nolan raises one hand on the left of the composition. In the center, professionals work beside an IMAX camera mounted on tracks, with a microphone suspended above. On the right are two performers in period clothing. The frame brings together direction, camera operation, sound and acting at the same location; it does not reveal the instructions given at that moment."}

- The cast plays the characters, developing the performances with the director.
- The costume designer conceives the clothing; the costume team organizes its production, procurement and use on set.
- The director of photography develops the image with the director, coordinating lighting and camera choices with specialized crews.
- Visual effects artists work on images and composites that require that treatment.
- The composer writes the music, while sound professionals handle other parts of the sonic experience, from effects to editing and mixing.
- The editor works on selecting and organizing the filmed material, in collaboration with the director.

Nolan participates in camera and editing choices without performing every craft by himself. The composer discusses the music with the director; departments propose solutions and need to coordinate them [@screenskillsdirector; @screenskillscostume; @screenskillsdop; @screenskillscomposer; @screenskillseditor; @screenskillssound].

### The biggest name doesn't erase the others

*Oppenheimer* provides a verifiable example of this division. At the 2024 Oscars, Nolan won for directing, **Jennifer Lame** for film editing, **Hoyte van Hoytema** for cinematography and **Ludwig Göransson** for original score. They were distinct awards for contributions to the same film [@academy2024oscars].

Imagine gaining access to the same team and saying: "Make a good film." Having excellent specialists expands your possibilities, but leaves enormous questions unanswered.

What story deserves to be told, and from whose point of view? How long does the viewer need to spend in a scene before understanding what's at stake?

Consider a small decision, like extending a silence. It changes which performance to use, the cut, the entrance of the music and the information the audience receives. Evaluating each department in isolation can produce excellent parts that, together, ruin the scene.

It's similar to a system where every screen looks good, every service passes its own tests and the customer's complete journey remains impossible. Someone has to understand the whole, notice the incompatibility and decide what changes. In software, that responsibility can be distributed among several people; there doesn't have to be a lone director.

### Giving the order is the beginning

I can ask an agent to "solve the problem." If it's a small defect with a clear test, it may investigate and fix it without my following every step. That autonomy is already useful and part of what I'm celebrating.

Now imagine the request: "Solve the company's billing problem." That sentence alone doesn't tell the program whether the discrepancy comes from a discount rule, a commercial negotiation or two departments using different definitions of an overdue payment. It can look for clues, ask questions and propose hypotheses. We still need to find out what's happening and how to recognize an acceptable solution.

If I ask only for a new screen, I may get an impeccable interface that calculates the wrong debt. If I understand the conflict, the best solution may require less software: clarify the rule, change the approval flow and only then automate the calculation. Efficient execution of a bad decision leaves it a bad decision.

> Directing work requires knowing how to judge the result, including when it comes back different from what you asked for.

That's where knowledge, experience and attention come in. Knowing what to ask, noticing the detail that compromises the delivery and rejecting a plausible answer takes learning. A request containing the word "excellent" doesn't supply that judgment.

The analogy stops short of equating a film crew with a model. People have intentions, their own experience and professional responsibility; an agent can produce a convincing justification for a mistake. I use the comparison to discuss the relationship between direction and execution, respecting the difference between the collaborators you have in each case.

## "Made by AI" doesn't settle the evaluation

<!-- src: original -->
If someone shows me a website and says "it was made by AI," I still know very little about the site. I need to open it, try using it and find out what it delivers. The origin of the code doesn't tell me whether signup works, whether the text explains the product or whether someone can navigate with a keyboard.

I may find a generic page full of text that seems written to fill space. I may find a useful, carefully made solution. In either case, I can identify faults and merits more concrete than the tool involved in production.

The same applies to a program written entirely by hand. Manual work doesn't make an exposed password more secure. The number of hours spent producing the mistake doesn't reduce the harm to whoever suffered from it.

That doesn't oblige anyone to ignore the process. If a customer bought handcrafted work, that characteristic is part of the request. If there's a licensing, confidentiality or attribution problem, we have a specific objection that deserves an answer; hiding the origin to get around a requirement also compromises the delivery.

What I reject is using "made by AI" as a substitute for technical evaluation. In @sec-ch16 we saw generated code accumulating real risks. You can criticize the vulnerability, the inadequate test and the person who published without checking, without inventing the idea that the same defect would be acceptable if it had been typed slowly.

### Your signature comes with work

The reasoning also applies to whoever delivers. You don't become a competent author by writing a command and putting your name on the result. You need to decide what you accept, recognize what you don't know how to evaluate and seek help where that limitation matters.

When I say I made the sites, I'm describing work in which I chose directions, had them implemented and checked results, with explicit help from the tools. I'm not saying I drew every image or typed every style rule. The description can be accurate without diminishing the result or erasing the process.

<!-- src: 2026/10/16/estamos-no-futuro-carros-voam-e-nao-temos-mais-que-fazer-html-css -->
The most useful part of that day was being able to reject cheap work. A bad prototype stopped being something I had to defend because it had already cost so much effort. I could preserve an idea, abandon the rest and try another direction.

<!-- src: original -->
That freedom requires some developed taste, some sense of how things are used and a willingness to compare. If I accept everything that comes out first, I only accelerate the production of similar pages. The tool expands the number of attempts; I still need to learn from them.

## The recipe doesn't earn three stars

<!-- src: original -->
Now picture **Gordon Ramsay** with a recipe and someone who has never cooked preparing the same dish. The text may be identical. The experience to notice that something isn't cooked properly, adjust the preparation and organize the service doesn't come printed with it.

And the wording matters: the Michelin Guide awards stars to restaurants, not to individual chefs. Its criteria include mastery of techniques and consistency across visits [@michelindistinctions; @michelinstar]. Copying a recipe doesn't, by itself, deliver an operation capable of repeatedly serving meals at that level.

A beginner can make an excellent dish by following the recipe. What's missing is the ability to repeat and adapt when the ingredient or situation changes.

That's the path so much course advertising tried to sell as unnecessary. Memorize the names, reproduce the demonstration, finish the guided project and receive a professional identity. You learn some useful operations, but you still need to face the problem that didn't come with the next step written on screen.

<!-- src: 2021/01/06/akitando-90-o-que-os-cursos-nao-te-ensinam-sobre-mercados -->
In Akitando episode 90, *What Courses Don't Teach You About Markets*, published in January 2021, I was already distinguishing the guided path of a course from the world of work. Outside class, you need to formulate questions nobody prepared for you. And a period of easy hiring can hide that difference long enough to make it seem nonexistent [@akitando090].

<!-- src: original -->
The bubble's history is in @sec-ch18. What matters here is the wrong lesson it could leave behind: "I got hired, so my education is finished." Hiring shows that someone needed you in that situation; it isn't a lifetime certificate that your knowledge will remain adequate.

### Practicing what you haven't mastered

<!-- src: 2020/04/01/akitando-76-guia-definitivo-de-aprendendo-a-aprender-a-maior-bronca-da-sua-vida-rated-r -->
In the *Definitive Guide to Learning How to Learn*, from April 2020, I insisted on deliberate practice: identify a weak area, work on it, evaluate and correct. Courses and books can help enormously with that process. The mistake is confusing watching someone solve a problem with having developed the ability to solve it [@akitando076].

<!-- src: original -->
AI makes that confusion easier because it delivers an answer that looks like completed work. You can read the explanation, find everything familiar and remain unable to recognize the same problem when it appears in a different form. The useful exercise is finding out how far you can justify the solution and what happens when a condition changes.

Imagine that, during an ordinary review of your work, you need to check a discount on a purchase. Before consulting the agent, write down the expected result; then change the condition: part of the purchase was returned. Predict what should happen to the discount, compare it with the tool's answer and take the discrepancy to a colleague who knows the rule. You can practice this in an accounting spreadsheet or on a programming task assigned by your boss, without having to choose the entire project.

If you can only repeat the tool's explanation, you've found something concrete to study. Suggestions by profession for getting started this week are in the epilogue (@sec-epilogo).

The study plan is in @sec-apestudar; I won't repeat it here. What changes with agents is the amount of help available to explore a question. You can request examples, compare alternatives and prepare exercises, provided you check the answers and don't use the tool to hide from yourself what you haven't understood yet.

This applies to people with decades of experience too. Knowing a great deal about one domain doesn't make me an expert in the next. If I start evaluating design, I need to learn to see design problems; my programming history doesn't turn every preference of mine into a good decision.

> Use the ease of producing things to improve the quality of practice, without confusing the number of answers with learning.

The mirror that appeared in @sec-ch06 and @sec-ch07 returns here: the way you choose, check and correct becomes visible in the result. People who approve anything tend to publish more of anything. People with judgment can use the attempts to improve, and beginners can develop that judgment.

That doesn't mean every agent error is the user's fault, or that an expert can overcome every limitation of the model. There's no guarantee of an Oscar or a Michelin star either. Experience helps you recognize where the tool is useful and where insisting on it will only produce more bad work.

## After the task is gone

<!-- src: original -->
If you enjoy programming, keep programming. The pleasure of understanding a machine and building something remains. Just don't count on the market paying indefinitely for a difficulty you prefer to preserve.

I'm not proposing chasing every tool that comes out either. That can become another form of repetition, a collection of tutorials without a single problem solved. I'd rather choose real work, understand its constraints and experiment with what allows me to do it better.

If automation frees up some of your time, there's an opportunity to study the part you always avoided. It may be the business rule behind a calculation or the reason the customer abandons a process. You may discover that you were perfecting a step that didn't even need to exist.

Asking the same questions for years, expecting ready-made answers and repeating procedures without understanding their limits is a bet on a static world. With agents, that bet has become even worse. A growing share of that execution can already be bought as a service.

<!-- src: 2026/10/16/estamos-no-futuro-carros-voam-e-nao-temos-mais-que-fazer-html-css -->
That night, the car spinning in midair entertained me. The change to the sites was already changing my work. I wanted to test more ideas, discard the bad ones and use my time to discover what was worth building next.

<!-- src: original -->
For that, I didn't have to wait for a conscious machine or a model that had learned everything still missing in the world. I used the tools that were available. That's why the question about AI's limits, postponed at the end of @sec-ch19, still matters: how much of the change is already possible with what we have, even if the next version makes no leap at all?
