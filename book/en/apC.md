---
id: apC
chapter: "How to Read a Benchmark or an Announcement"
sources:
  - {post: 2026/07/19/llm-benchmark-devo-usar-o-que-tem-nota-maior, sha256: "8560b2c684a6bfd9a8def203ba00d507b77c2b8e0164b4f7168ca68bbcba3dc4"}
  - {post: 2026/04/24/llm-benchmarks-parte-3-deepseek-kimi-mimo, sha256: "bbf1702a8938981cc7ea57b20996419e915e3256ac20f1bcc2f36008aa3e6f50"}
  - {post: 2026/07/09/llm-benchmark-grok-4-5-gpt-5-6-sol, sha256: "0c2e0daa9866ca774e34cd547680dd8ac8ad12725009f1d9719c8c80d3291448"}
  - {post: 2026/07/30/novo-llm-benchmark-refiz-todos-os-testes, sha256: "84853087d3257ff5d5b72a739da214710c2e8e66fc1396c8b5eb78d84bec88f4"}
  - {post: 2026/09/15/novo-llm-benchmark-v4-retestando-todos-llms-parte-1, sha256: "60935f87e7058e5cf219cfeada4447c2d57863d944f7a23116e28c5332ccaa65"}
  - {post: 2026/09/15/novo-llm-benchmark-v4-retestando-todos-llms-parte-2, sha256: "02a4bc4b2b167ed99b89a57a0eb0a19a2fab33dae4155d06c9b115f6e36c2ca7"}
  - {post: 2026/07/01/llm-benchmark-sonnet-5-gemini-3-5-flash-sakana-fugu-ultra, sha256: "a926f716d937e2430d033fde217b69d41f1e9c4e91242875e32661a1e56bc359"}
  - {post: 2026/08/15/llm-benchmarks-qwen-3-8-glm-5-3-gemini-3-7, sha256: "c35b99008474fce51b2d259fcdbdc4346f1aa8e2ca9d022a99de036c8ac15c51"}
  - {post: 2026/06/15/controversia-llm-rio-3-5-plagio, sha256: "5934610a4f205cdeb84932f2107a81b4a0002115945d7293c8130298ed42a18c"}
  - {post: 2026/06/11/llm-benchmark-fable-5-e-a-novela-da-anthropic, sha256: "ab900c522b1e3798b82f918c636213aa8290807a14ce39300a21f4fda68ef9a8"}
  - {post: 2026/09/09/propagandas-enganosas-da-openai-anthropic-nvidia, sha256: "d77ce29923394a3f39a6ab0acf0a00200c35df3b6f443bf6396d3a055611f09f"}
  - {post: 2026/08/18/hot-take-harness-loop-engineering-graph-engineering-sao-bullshit, sha256: "3bf57210a84a838886736656f0a1991e08a8b59900b6109cb5b0b78dcd02c6ce"}
  - {post: 2026/09/16/por-que-coisas-como-typesafe-ia-nao-me-interessam, sha256: "e610a94c82a2a37d39293ef2f8225e84e4d26dd08633122d4d1791519593af48"}
  - {post: 2026/10/03/entendendo-o-hype-do-jev-pra-que-serve, sha256: "1d9faa7afda48528a20bec2bd8d3441384946aa5eb98bf4204936a8f7ffcd5df"}
refs_projects:
  - "llm-coding-benchmark/docs/success_report.v4.combined.md"
blog_commit: "b9c029231693369b8f895576b491c878aea3e8da"
translated_from: {file: book/pt/apC.md, sha256: "1ecfda6820b0b3697b5127def7b9a060ae8457b562f670e3143d73b2118716c7"}
---

# How to Read a Benchmark or an Announcement {#sec-apC}

<!-- src: original -->
In 2026 I spent months measuring AI models and reading announcements about them, and I got both wrong more than once. This appendix gathers the questions those mistakes left behind, in two lists of one page each: one for when someone shows you a table, another for when someone tells you about something new.

The model names and the scores will age fast; the questions should last a lot longer. Each item gives the question, the reason for it in one sentence and the chapter where the full story is told, if you want to see the stumble that gave rise to it.

## Facing a Table

<!-- src: 2026/07/19/llm-benchmark-devo-usar-o-que-tem-nota-maior -->
This applies to any [benchmark]{.gls}, ranking or model leaderboard, mine included.

1. **What was the task, in which tool, graded by which criteria?** The score describes one job, done in a specific [harness]{.gls} and assessed by a specific [rubric]{.gls key=rubrica}, and swapping only the program around the model has already taken a model from "unmeasurable" to the top of the table (@sec-ch03, @sec-ch11).
2. **How many times did they run it?** A single round is a sample of one: in my test, in September 2026, the same model, repeated with nothing changed, dropped nine points, and that has a name, [run-to-run noise]{.gls key=ruido-entre-execucoes} (@sec-ch11).
3. **Is the difference bigger than the noise?** At the top, the models form a group, and fighting over the exact position inside it is made-up precision; pick the [tier]{.gls} first, then decide by price, time and the tool you already use (@sec-ch11).
4. **Who did the grading, and are the corrections published?** The judge gets it wrong too, and I got it wrong several times. A serious benchmark shows the prompt, the generated code, the logs and the errata; whoever shows only the chart leaves no one able to challenge it (@sec-ch11).
5. **How was cost counted?** I've seen cost underestimated by forgetting cache rereads and by a program that only added up the last step, so trust the order of magnitude and be wary of "for pennies" (@sec-ch11).
6. **Does the test still separate anyone?** When almost everyone scores between 95 and 100, the test is saturated, and the order comes down to details that say next to nothing about capability (@sec-ch11).
7. **Could the answers have leaked into training?** A famous, old test runs the risk of [contamination]{.gls key=contaminacao}, and passing the automatic grader is different from having the work accepted by the people who actually maintain the project (@sec-ch11).
8. **Who wrote the check?** A green test written by the same model that wrote the code can agree with its own mistake, like a [mock]{.gls} tailor-made to accept a command that doesn't exist (@sec-ch12).
9. **Did the model have the answer key within reach?** An agent uses everything in the folder, including the rubric and the competitors' work, so a suspiciously good score calls for reading the run's log (@sec-ch12).
10. **What does the test prove about the model's origin?** With the weights in hand you can do the math and get close to proof; from the outside, through the API alone, a [black-box test]{.gls key=caixa-preta} helps investigate hypotheses and rumors, but doesn't certify origin (@sec-ch12).
11. **Have you run your own?** If the choice carries money or risk, take a task similar to yours, run the candidates more than once, compare without knowing who did what and measure how much human work was left at the end (@sec-ch11).

<!-- src: 2026/07/19/llm-benchmark-devo-usar-o-que-tem-nota-maior -->
> A table tells you what happened on one test, in one round. What that's worth in your work, only your own test can answer.

## Facing an Announcement

<!-- src: original -->
Before the questions, a habit I brought back from the model-origin tests (@sec-ch12):

> Split the announcement into three columns: what someone outside measured, what is only the seller's word and what nobody knows. Almost all the noise lives in the middle one.

<!-- src: 2026/09/09/propagandas-enganosas-da-openai-anthropic-nvidia -->
The full list I use, with the 2026 cases, is in @sec-como-ler-anuncio. This is the pocket version.

1. **Who makes money if you believe it?** Behind the sentence there's usually an [IPO]{.gls key=ipo}, a graphics card to sell or a course, and a financial interest doesn't make anything false; it just calls for stronger proof (@sec-ch14).
2. **Can someone outside test it?** "Too dangerous to release," a closed consortium and a waiting list are claims until someone independent measures them, and the "too dangerous to release" line was already used with GPT-2 in 2019 (@sec-ch01, @sec-ch14).
3. **What's the definition of the big word?** When the people selling the hardware declare that [AGI]{.gls key=agi} has arrived, ask what they mean by it, because in the contract between OpenAI and Microsoft the word became a profit target [@zeff2024agi] (@sec-ch14).
4. **Compared against whom, and with which yardstick?** "Hundreds of times cheaper" always has a hand-picked opponent, and "zero hallucination" can be zero by definition, so find the sentence that explains how the number was measured (@sec-ch14).
5. **What is this product, minus the name?** The revolutionary launch of September 2026 was a [classifier]{.gls key=classificador}, a decades-old technique, and plenty of "new paradigms" are old practice with a new name to sell consulting (@sec-ch14).
6. **Did it happen, or could it happen?** Read the verbs: "could," "within a few months," "if it were more capable" carry a different weight from a documented fact, and the apocalypse in announcements usually lives entirely in the conditional (@sec-ch14).
7. **Who profits from your fear?** The catastrophe warning and the miracle announcement serve the same seller, and a call for regulation written to fit the leaders locks out the small competitor (@sec-ch14).
8. **What did the feat cost?** A result obtained with millions of dollars of compute shows brute force and money, and says much less about the machine's intelligence (@sec-ch14).
9. **Are the voices that agree independent?** Ten influencers repeating the same press release count as one voice, and two AIs agreeing with the hypothesis you wrote into the question are an echo (@sec-ch04, @sec-ch14).
10. **Do the credentials match the dates?** The paper's title, year and author list are one search away, and the announced credential is sometimes bigger than the real one (@sec-ch14).
11. **Do you need this today?** Nearly every big headline of 2026 changed shape within a few weeks, and I only adopt a new tool when I notice that its absence hurts (@sec-ch14).

<!-- src: original -->
If you're going to use a chatbot to investigate the announcement, add the list from @sec-ch04 to this one: asking without handing over your own opinion, opening the source and climbing up to the [primary source]{.gls key=fonte-primaria} count as much as the questions above.
