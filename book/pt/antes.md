---
id: antes
chapter: "Antes de começar: o que este livro não explica"
sources: []
refs_projects: []
blog_commit: "cc8b467dd4d6d3b5c57fad6bb6fae70ec5839a01"
---

# Antes de começar: o que este livro não explica {#sec-antes .unnumbered}

<!-- src: original -->
Este livro dá intuições sobre como essas máquinas funcionam, e para por aí. O @sec-ch01 explica o que é um modelo de linguagem, por que ele trabalha com pedaços de palavras, a diferença entre treinar um modelo e usá-lo, e por que ele não aprende nada com você depois de pronto. São imagens do dia a dia, sem conta nenhuma, e bastam pra acompanhar a história.

O que eu deixei de fora de propósito é a mecânica por dentro:

- como uma [rede neural]{.gls key=rede-neural} aprende, com [descida do gradiente]{.gls key=descida-do-gradiente} e [retropropagação]{.gls key=retropropagacao};
- o que são [embeddings]{.gls key=embedding}, as listas de números que representam o sentido de um texto;
- como um [transformer]{.gls}, a arquitetura por trás de todos esses modelos, e o seu mecanismo de [atenção]{.gls key=atencao} funcionam;
- como o [pré-treino]{.gls key=pre-treino} e o [RLHF]{.gls} (aprendizado por reforço com feedback humano) transformam um amontoado de texto num assistente educado.

<!-- src: original -->
Cada um desses assuntos pede um livro inteiro, e esses livros existem, escritos por gente que pesquisa ou constrói essas coisas. Um livro de narrativa que tentasse fazer o mesmo viraria apostila na página dez.

## Por que vale a pena saber

<!-- src: original -->
Ainda assim, este livro fica melhor se você entender esses mecanismos antes. Várias afirmações das Partes I e III se apoiam neles. Quando eu digo que o modelo não aprende com a sua conversa, que ele concorda com você porque foi treinado pra agradar, ou que cada geração nova custa muito mais pra melhorar muito menos, estou resumindo consequências de como o treino funciona.

<!-- src: original -->
Quem conhece a mecânica lê essas frases como conclusão. Quem não conhece precisa confiar em mim, e o livro inteiro é um pedido pra você não confiar cegamente em ninguém, inclusive em mim.

<!-- src: original -->
Dito isso, ninguém precisa fazer lição de casa antes de virar a página. O livro foi escrito pra ser lido sem nada disso, e a história se sustenta sozinha.

> Você não precisa saber como o motor funciona pra entender por que o carro bateu. Mas, se um dia quiser abrir o capô, as indicações estão aqui.

<!-- src: original -->
Se quiser um meio-termo, existe um apêndice opcional, *A máquina por dentro, sem matemática* (@sec-apmecanica). Em poucas páginas e sem nenhuma fórmula, ele mostra o painel de botões, a descida do morro na neblina, o mapa de sentidos e o marca-texto da atenção. E termina explicando de onde veio o apelido [papagaio estocástico]{.gls key=papagaio-estocastico}, o que ele captura bem e por que eu concordo com ele. Dá pra ler agora, no meio do caminho ou no fim.

## Pra quem quiser ir mais fundo

<!-- src: original -->
Pra quem quiser os livros e vídeos que explicam a mecânica de verdade, deixei uma lista curta no fim, no @sec-apleituras. Vai do mais fácil ao mais técnico, com o que é gratuito e o que tem em português. Por ora, vire a página. A história começa em fevereiro de 2026, com uma frase que eu nunca disse circulando pela internet com o meu nome.
