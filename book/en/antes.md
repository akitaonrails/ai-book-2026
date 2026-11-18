---
id: antes
chapter: "Before You Start: What This Book Doesn't Explain"
sources: []
refs_projects: []
blog_commit: "b9c029231693369b8f895576b491c878aea3e8da"
translated_from: {file: book/pt/antes.md, sha256: "e3caa7a3e37198e0bc1345afec4ca23867d2329effed07e0789ebb1097a7d2b2"}
---

# Before You Start: What This Book Doesn't Explain {#sec-antes .unnumbered}

<!-- src: original -->
This book gives you intuitions about how these machines work, and stops there. @sec-ch01 explains what a language model is, why it works with pieces of words, the difference between training a model and using it, and why it learns nothing from you once it's done. They're everyday images, with no math at all, and they're enough to follow the story.

What I left out on purpose is the mechanics inside:

- how a [neural network]{.gls key=rede-neural} learns, with [gradient descent]{.gls key=descida-do-gradiente} and [backpropagation]{.gls key=retropropagacao};
- what [embeddings]{.gls key=embedding} are, the lists of numbers that represent the meaning of a piece of text;
- how a [transformer]{.gls}, the architecture behind all of these models, and its [attention]{.gls key=atencao} mechanism work;
- how [pretraining]{.gls key=pre-treino} and [RLHF]{.gls} (reinforcement learning from human feedback) turn a heap of text into a polite assistant.

<!-- src: original -->
Each of these subjects calls for a whole book, and those books exist, written by people who research or build these things. A narrative book that tried to do the same would turn into a textbook by page ten.

## Why It's Worth Knowing

<!-- src: original -->
Even so, this book gets better if you understand those mechanisms first. Several claims in Parts I and III rest on them. When I say the model doesn't learn from your conversation, that it agrees with you because it was trained to please, or that each new generation costs much more and improves much less, I'm summing up consequences of how training works.

<!-- src: original -->
Readers who know the mechanics read those sentences as conclusions. Readers unfamiliar with the mechanics have to trust me, and the whole book is a plea not to trust anyone blindly, me included.

<!-- src: original -->
That said, nobody needs to do homework before turning the page. The book was written to be read without any of this, and the story stands on its own.

> You don't need to know how the engine works to understand why the car crashed. But if you ever want to pop the hood, the directions are here.

<!-- src: original -->
If you'd like a middle ground, there's an optional appendix, *The Machine Inside, Without the Math* (@sec-apmecanica). In a few pages and without a single formula, it shows the panel of knobs, the walk down a hill in the fog, the map of meanings and the highlighter of attention. And it ends by explaining where the nickname [stochastic parrot]{.gls key=papagaio-estocastico} came from, what it gets right and why I agree with it. You can read it now, halfway through or at the end.

## For Anyone Who Wants to Go Deeper

<!-- src: original -->
If you want the books and videos that explain the mechanics for real, I left a short list at the end, in @sec-apleituras. It runs from easiest to most technical, with what's free and what's available in Portuguese. For now, turn the page. The story starts in February 2026, with a line I never said making the rounds on the internet under my name.
