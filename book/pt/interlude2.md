---
id: interlude2
chapter: "Interlúdio: Do GNU Go ao KataGo"
sources:
  - {post: 2026/07/06/frank-go-brincando-de-go-com-ia, sha256: "65dd71345fc6229a22d1c40ea2f7ff20e2e79213cf41323d7864c1fd6ca7b5e5"}
  - {post: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas, sha256: "c1c7d372d1654932a63455ef8c205e83209a4d5e9a2d6cf037ce6dae97aee041"}
refs_projects: []
blog_commit: "cc8b467dd4d6d3b5c57fad6bb6fae70ec5839a01"
---

# Interlúdio: Do GNU Go ao KataGo {#sec-interlude2 .unnumbered}

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
Eu tenho um goban em casa. É o tabuleiro de Go, a grade de 19 por 19 linhas onde dois jogadores alternam pedras pretas e brancas tentando cercar mais território que o outro. Nunca entrei em clube, federação ou torneio, e nem pretendo. Gosto de jogar sozinho, resolver uns tsumego, os quebra-cabeças de vida e morte do Go, e reproduzir partidas famosas pedra por pedra.

A culpa é de um mangá. *Hikaru no Go*, com roteiro de Yumi Hotta e arte de Takeshi Obata, o mesmo de *Death Note*, saiu na revista Shonen Jump entre 1998 e 2003 e provocou uma onda de interesse por Go no Japão inteiro. Quase todas as partidas desenhadas ali são jogos históricos de verdade, recriados lance a lance.

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
Em julho de 2026, no meio de um ano inteiro testando inteligência artificial, resolvi fazer uma coisa por puro prazer: montar o aplicativo de estudo de Go que eu queria ter tido a vida inteira. E, de quebra, ver de perto o quanto as IAs de Go tinham amadurecido desde a primeira vez que joguei contra uma.

Essa primeira vez foi em 2008.

## O adversário sem rumo

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
Em julho de 2008 eu escrevi no blog um texto defendendo que programador devia jogar Go. Na época, o único adversário artificial ao alcance de qualquer um era o GNU Go, um programa livre que existe até hoje [@gnu2009gnugo]. Chamar aquilo de IA era generosidade. Era uma pilha de [heurísticas]{.gls key=heuristica}, regrinhas escritas à mão do tipo "se a pedra está ameaçada, proteja", empilhadas umas sobre as outras.

E jogava mal. Até um amador como eu enxergava a falta de rumo: pedras soltas que não conversavam entre si, nenhum senso de direção, nenhum plano. Ganhava de iniciante na tática local, lance a lance, e parava por aí.

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
Nos anos seguintes os programas melhoraram com uma técnica chamada [busca em árvore de Monte Carlo]{.gls key=mcts}. Em vez de seguir regras fixas, o programa simula milhares de partidas aleatórias a partir da posição atual e prefere o lance que mais vezes terminou em vitória. Subiu bastante o nível. Mesmo assim, os programas continuavam bem abaixo de um profissional de verdade.

<!-- src: original -->
Go tinha fama de ser um jogo que computador nenhum ia dominar tão cedo. O número de posições possíveis é grande demais pra força bruta, e os bons jogadores falam de "forma" e "intuição" como quem fala de estética.

## Cinco partidas em Seul

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
Essa fama acabou entre 9 e 15 de março de 2016, num hotel de Seul. O AlphaGo, programa do DeepMind, laboratório do Google, enfrentou o sul-coreano Lee Sedol, um dos maiores jogadores da história, numa série de cinco partidas, e venceu por 4 a 1 [@deepmind2026alphago; @wikipedia2026alphagoleesedol].

A série ficou famosa por dois lances. Na partida 2, o AlphaGo jogou a pedra 37 num ponto que um profissional humano dificilmente consideraria, um "ombro" encostado numa pedra branca que os comentaristas chamaram de criativo e único. Lee Sedol levou um tempo enorme pra responder.

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
A resposta humana veio na partida 4, em 13 de março. Já com a série perdida, Lee Sedol jogou a pedra 78, uma cunha no meio da área preta que nenhum comentarista tinha previsto. O AlphaGo também não viu o perigo: continuou se achando favorito por vários lances, só percebeu o estrago perto do lance 87 e acabou abandonando a partida. O profissional chinês Gu Li chamou a jogada de divina, e ela ficou conhecida como a "mão de Deus".

![A partida 4 de Lee Sedol (brancas) contra o AlphaGo (pretas), em 13 de março de 2016: a única vitória humana na série, virada pela jogada 78. Diagrama: Wesalius, CC BY-SA 4.0, via Wikimedia Commons.](assets/figures/interlude2-partida-4.png){#fig-interlude2-partida-4 fig-alt="Tabuleiro registra a partida 4 entre Lee Sedol e AlphaGo, única vitória humana da série." fig-desc="Diagrama de um tabuleiro de Go de 19 por 19 linhas, coberto de pedras pretas e brancas numeradas pela ordem em que foram jogadas, registrando a partida 4 entre Lee Sedol e o AlphaGo, que terminou com o AlphaGo abandonando."}

Foi a única partida que o AlphaGo perdeu pra um ser humano naquela série. Quem quiser sentir o clima daquela semana, sem saber nada de Go, tem um documentário, *AlphaGo*, de 2017, que acompanha a série de perto [@kohs2017alphago].

<!-- src: original -->
O resto da história é menos cinematográfico. Em novembro de 2019, Lee Sedol se aposentou do Go profissional. Numa entrevista à agência sul-coreana Yonhap, explicou que, mesmo que voltasse a ser o número um, existia uma entidade que não podia ser derrotada [@vice2019leesedol].

> Lee Sedol perdeu a série, mas o lance que a máquina não previu é dele. Uma IA sobre-humana ainda pode ser pega de surpresa.

## Um campeão de graça no seu computador

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
Depois que o DeepMind publicou os artigos científicos, a comunidade de [código aberto]{.gls key=codigo-aberto} foi atrás. Primeiro veio o Leela Zero, um projeto voluntário que reimplementou a receita. Depois o KataGo, do programador David Wu, que em 2019 publicou um artigo mostrando como chegar ao topo com menos de 30 placas de vídeo, onde os projetos anteriores tinham usado milhares de processadores [@wu2019katago].

Em 2026, qualquer um baixa o KataGo, de graça, e tem em casa um adversário mais forte que qualquer profissional humano [@wang2023adversarial]. Roda até sem placa de vídeo, só no processador, mais devagar [@lightvector2026katago].

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
Foi com ele que eu montei o Frank GO, mais um da família de projetos que batizo em homenagem a Frank Rosenblatt (@sec-ch05). Pedi pro Claude Code pesquisar os programas de Go de código aberto mais usados e escolhi uma base: o Sabaki, de Yichuan Shen, um editor de partidas bonito e bem cuidado. O Frank GO é um [fork]{.gls} dele, uma cópia que segue caminho próprio, amarrada ao KataGo.

Juntei num lugar só o material que vivia espalhado pela internet:

- mais de 4.700 tsumego de coleções clássicas, organizados em dez níveis de dificuldade;
- partidas históricas, do século XIX até as do AlphaGo contra Lee Sedol;
- 15 partidas do *Hikaru no Go*, com o capítulo do mangá em que cada uma aparece.

Cada coleção vem com a origem e a licença documentadas, porque acervo dos outros se usa dando crédito.

### Território em vez de porcentagem

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
O que eu mais mexi foi na tela. Quase todo programa de Go é feito por jogador forte pra jogador forte, e mostra a análise como "taxa de vitória", algo como 63% pras pretas. Pra quem está aprendendo, esse número não diz nada. Ele não explica o que está errado, onde, nem quanto.

O KataGo tem uma vantagem que importava muito pro meu caso. Além da chance de vitória, ele estima o placar e calcula, ponto a ponto, a quem pertence cada pedaço do tabuleiro. Ele sempre soube fazer essa conta; faltava alguém colocar o resultado na tela de um jeito que iniciante entendesse.

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
Então o Frank GO pinta o tabuleiro. A influência de cada jogador aparece como um degradê suave, o território garantido em cor sólida, e os grupos já mortos ficam escuros. Um placar ao vivo mostra quantos pontos você está atrás, já contando a compensação que as brancas recebem por jogar em segundo.

"Você está 12 pontos atrás e o canto inferior esquerdo morreu" ensina mais que qualquer porcentagem.

> O mesmo tipo de IA que fez um campeão se aposentar virou, na minha mesa, um professor paciente. Bastou mostrar na tela a conta que ela já fazia: quem domina o quê, e por quantos pontos.

<!-- src: 2026/07/06/frank-go-brincando-de-go-com-ia -->
Tudo roda no computador, sem conta, sem servidor, sem internet. É deliberadamente um aplicativo de estudo solo. Eu queria, havia anos, jogar no meu ritmo contra uma IA que joga bonito, em vez de cuspir pedras sem sentido como o GNU Go de 2008. Dezoito anos depois, consegui.

## O ponto cego

<!-- src: original -->
A história tem uma nota de rodapé. Entre 2022 e 2023, um grupo de pesquisadores treinou um programa com uma única missão: achar um jeito de ganhar do KataGo. O programa que eles criaram joga Go mal, perde pra amadores, mas descobriu uma armadilha: cercar devagar um grupo de pedras do KataGo com um laço enorme enquanto distrai a máquina com lances em outro canto do tabuleiro. O KataGo, sobre-humano, não percebia o cerco até ser tarde demais [@wang2023adversarial].

A armadilha era simples o bastante pra um ser humano aprender. Um dos autores do estudo, Kellin Pelrine, um amador forte, passou a vencer o KataGo com regularidade, sem ajuda de computador durante as partidas. E o defeito continuou lá mesmo em versões do KataGo treinadas especificamente pra se defender dele.

<!-- src: original -->
O KataGo continua jogando melhor que qualquer profissional numa partida normal. O episódio mostra uma coisa que vale pra qualquer IA: um sistema pode ser melhor que todo mundo em quase tudo e, ao mesmo tempo, ter um ponto cego que nenhum de seus criadores enxergou, e que só aparece quando alguém procura de propósito.

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
No Go, o preço de um ponto cego é perder uma partida. Na mesma semana em que eu publiquei o Frank GO, o assunto nas redes era outro: um agente de programação, rodando sozinho no computador de um usuário conhecido, tinha apagado quase todos os arquivos dele.

Eu, que vinha deixando agentes rodarem comandos no meu próprio computador sem pedir permissão fazia dois meses, nunca tinha passado por isso. E também nunca confiei neles de olhos fechados.

A pergunta seguinte é quanto do seu computador, dos seus arquivos e dos seus dados você entrega pra uma máquina que pode ter um ponto cego do tamanho do seu disco.
