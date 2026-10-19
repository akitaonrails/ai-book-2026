---
id: prefacio
chapter: "Prefácio"
sources:
  - {post: 2026/02/24/rant-o-akita-abriu-as-pernas-pra-ia, sha256: "eba7e0379feb2d062e312e755b44b31fbc056217040c9107cbae1848bf1e5623"}
  - {post: 2026/02/08/rant-ia-acabou-com-programadores, sha256: "09830f1d69488d527d241814a30269786cd7a5548e5d34fdf33b7fa21af0f417"}
  - {post: 2026/05/14/terminando-maratona-ia-sucesso-ou-fracasso, sha256: "23ccf942d2fcc8114fb4b373b17acce392e0711e3556436f6cfe3aab97cc3ac2"}
  - {post: 2026/06/11/llm-benchmark-fable-5-e-a-novela-da-anthropic, sha256: "ce3ac52806404b9410bbe7b38962bc96d1beaff182ad194e2dbc1f18630c5d30"}
  - {post: 2026/10/12/llms-agentes-competente-o-suficiente, sha256: "ee499fef89fe8fe35d652f193b51f1660cd08e8ed77adee74e036ca1444cc54b"}
  - {post: 2026/02/01/vibe-code-fiz-um-editor-de-markdown-do-zero-com-claude-code-frankmd-parte-2, sha256: "fe55c3fbbd2ecbd0b51b059c1f46bf9e308b8b6a25c5953ffac9ad43d23f6839"}
  - {post: 2023/02/14/akitando-138-meu-comeco-de-carreira-durante-a-bolha-1997-a-2002-bug-do-milenio-crash, sha256: "79a02c73df595ddf8952c7bfbbd8023f51a3297b259610afa65901112dfe4160"}
refs_projects: []
blog_commit: "cc8b467dd4d6d3b5c57fad6bb6fae70ec5839a01"
---

# Prefácio {#sec-prefacio .unnumbered}

<!-- src: original -->
Em 1939, quem visitou a Feira Mundial de Nova York, que tinha como tema "o mundo de amanhã", podia conhecer o Elektro. Era um robô da Westinghouse com uns dois metros de altura, que andava sob comando de voz, falava umas 700 palavras gravadas num disco, enchia balões e fumava cigarro [@wikipedia2026elektro]. No pavilhão da General Motors, uma maquete gigante mostrava os Estados Unidos de 1960, com estradas automatizadas e plataformas no alto dos prédios pra máquinas voadoras [@wikipedia2026futurama].

Doze anos depois, o cinema mostrou o outro lado da mesma moeda. Em *O dia em que a Terra parou*, de 1951, um disco voador pousa em Washington e dele desce um visitante, com um robô gigante a tiracolo, pra avisar que a humanidade, agora dona da bomba atômica, seria eliminada se levasse a própria agressividade pra fora do planeta [@wise1951day]. A década inteira encheu as telas de máquinas e invasores ameaçando a espécie.

A promessa e o medo saíam da mesma vitrine. A feira foi montada por empresas que vendiam eletrodoméstico e automóvel, e o cinema vendia ingresso. O futuro que chegou não trouxe robô mordomo, carro voador nem invasão. Foi mais estranho, mais modesto e bem mais útil do que as duas versões: um computador no bolso de quase todo mundo.

Em 2026 eu vivi a versão atual daquela feira, só que olhando ao mesmo tempo pros bastidores. Foi como viver em dois mundos.

<!-- src: 2026/02/24/rant-o-akita-abriu-as-pernas-pra-ia -->
Um era o da vitrine. Ali, a [inteligência artificial geral]{.gls key=agi}, uma máquina capaz de pensar sobre qualquer assunto como uma pessoa pensa, estava logo ali na esquina. Relatórios desenhavam o fim do mundo com data marcada, e empresário demitia a equipe de programação inteira achando que o código da IA ia sair melhor.

<!-- src: 2026/06/11/llm-benchmark-fable-5-e-a-novela-da-anthropic -->
Em junho, uma das maiores empresas do setor, com o pedido pra abrir capital na bolsa recém-protocolado, pôs à venda um modelo da família que ela mesma tinha apresentado como perigoso demais pro público. Na minha prova, ele empatou com o modelo anterior, custando quase o dobro.

<!-- src: 2026/05/14/terminando-maratona-ia-sucesso-ou-fracasso -->
O outro mundo era o do meu terminal. De fevereiro a maio, passei mais de 500 horas programando quase só com [agentes]{.gls key=agente} de IA, os programas que deixam o modelo ler arquivos, rodar comandos e trabalhar sozinho por horas. Foram 24 projetos, uns que deram certo, outros que viraram lixo.

<!-- src: 2026/10/12/llms-agentes-competente-o-suficiente -->
Depois vieram meses colocando dezenas de modelos numa prova de programação que eu mesmo montei, conferindo o resultado um por um, mês a mês. Quando juntei tudo, em outubro, fui procurar a curva que a propaganda desenhava subindo pro céu nas medições que não dependem de quem vende o modelo. Os relatos de quem treina os modelos e as medições independentes apontavam pro mesmo lado, e, somando isso aos meus testes, a minha leitura é que a inteligência de base parou de dar saltos; o que continuou crescendo foi o que ela consegue fazer com ferramentas na mão (@sec-ch20).

<!-- src: original -->
A distância entre os dois mundos ia nos dois sentidos. Em vários pontos a ferramenta era melhor do que os céticos admitiam: dá pra construir software de verdade com ela, e eu construí. Em outros, era bem pior do que os anúncios vendiam. Ela erra com a maior confiança, concorda com qualquer coisa que você já pensava, esquece o que foi combinado uma hora antes e precisa de alguém experiente conferindo o que sai.

Este livro nasceu dessa distância. É o relato de oito meses colocando a inteligência artificial à prova, de fevereiro a outubro de 2026, contado por quem estava com as mãos no teclado.

## Pra quem eu escrevi

<!-- src: original -->
Enquanto escrevia, eu pensava em algumas pessoas:

- a profissional que leu que o trabalho dela vai acabar em dois anos e não sabe se já devia procurar outro;
- o pai que viu um vídeo sobre uma inteligência superior prestes a chegar e não soube o que responder quando o filho perguntou se era verdade;
- a gerente a quem estão vendendo uma "transformação com IA" que ninguém consegue explicar direito;
- o programador júnior que se pergunta se escolheu a carreira errada.

Se você se reconheceu em alguma delas, comece sabendo que a confusão tem origem conhecida, e ela está longe de você. Faz anos que você é exposto à propaganda feita por gente que ganha com a sua ansiedade: empresas a caminho da bolsa, fabricantes de chip, vendedores de curso com nome novo pra coisa velha. Quem acreditou num anúncio fez exatamente o que o anúncio foi desenhado pra provocar.

E se você chegou aqui só por curiosidade, sem medo nenhum, ótimo. Você vai se divertir com algumas histórias deste ano.

Você não precisa saber programar. Eu sou programador, e muito do que eu conto envolve código, mas cada termo técnico é explicado na primeira vez que aparece e fica no glossário, no fim do livro. Quando eu conto uma história de programação, é porque ela responde a uma pergunta que vale pra qualquer pessoa que usa essas ferramentas.

## De que lado eu estou

<!-- src: 2023/02/14/akitando-138-meu-comeco-de-carreira-durante-a-bolha-1997-a-2002-bug-do-milenio-crash -->
Eu programo desde 1990 e comecei a trabalhar em 1996, em agências e empresas pontocom que não sobreviveram ao estouro da bolha da internet, e depois passei cinco anos integrando sistemas SAP em empresas grandes. Em 2007 fui pro Ruby on Rails, organizei a RubyConf Brasil de 2008 a 2016, fundei a Codeminer 42 em 2011 e, de 2018 a 2023, mantive o Akitando, um canal de vídeo que fiz pra ensinar o conhecimento que sobrevive às bolhas.

<!-- src: 2026/02/08/rant-ia-acabou-com-programadores -->
Também escrevo num blog desde 2006. Vi a internet continuar existindo depois do estouro, e vi profissões inteiras aparecerem e sumirem. Essa memória ajuda a ouvir um anúncio de "revolução" com alguma calma, e é dela que vem o ceticismo que você vai encontrar neste livro.

<!-- src: 2026/02/24/rant-o-akita-abriu-as-pernas-pra-ia -->
Muita gente me conhece por uma frase sobre empolgação e conhecimento, que você vai encontrar logo no primeiro capítulo. Por causa dela, uma turma acha que eu odeio IA. Por causa do que eu fiz em 2026, outra turma acha que eu me rendi a ela. As duas erram pelo mesmo motivo: imaginam que só existem esses dois lados.

Eu uso IA pra programar desde o começo de 2023. Gosto da ferramenta, uso todo dia, e ela participou de quase tudo que você vai ler aqui. Ao mesmo tempo, passei esses meses todos documentando os limites dela, porque é essa parte que some da conversa pública.

<!-- src: original -->
O empolgado demais e o que odeia demais têm uma coisa em comum: os dois costumam falar sem ter medido nada. Por isso o método deste livro é medir. Quando eu digo que um modelo foi bem, é porque ele passou numa prova que você vai ver como foi montada. Quando eu digo que errou, você vai ver o erro.

E quando o erro foi meu, o livro conta também. Teve ranking que eu publiquei, descobri que estava errado e marquei como obsoleto, com o aviso no topo, pra quem quisesse ver.

> Diante de qualquer promessa sobre IA, vale perguntar: boa pra quê, conferida por quem, a que custo?

## Os medos que você trouxe

<!-- src: 2026/02/01/vibe-code-fiz-um-editor-de-markdown-do-zero-com-claude-code-frankmd-parte-2 -->
O livro segue o meu ano, mais ou menos na ordem em que as coisas aconteceram. Cada uma das cinco partes responde a um medo que eu ouvi muitas e muitas vezes.

O primeiro é o mais antigo: tem alguém ali dentro? A primeira parte abre a caixa, sem matemática. Mostra por que o texto que sai de um chatbot parece vir de alguém, por que ele esquece o que vocês combinaram, o que muda quando ele ganha ferramentas pra mexer no seu computador, e por que tende a concordar com você e inventar fontes pra isso. Só entender esse mecanismo já protege bastante.

O segundo medo é o oposto do primeiro: e se for tudo só demonstração? Na segunda parte eu conto a maratona. Tem o editor de texto que parecia pronto em uma hora e meia e precisou de umas trinta horas pra funcionar de verdade, o produto que foi do zero ao ar em menos de uma semana, e o projeto que fracassou mesmo com a máquina fazendo tudo o que eu pedia. Funciona, só que de um jeito bem diferente do que aparece nos vídeos de "fiz um app em dez minutos".

O terceiro vem em forma de pergunta: qual é a melhor? Ela está ficando exponencialmente mais inteligente? Devo acreditar nos anúncios? A terceira parte é a briga com os números: como se mede uma IA, os modelos que eu peguei colando na prova, o que dá pra rodar no computador de casa e como funciona a fábrica de propaganda em volta de tudo isso.

O quarto é sobre confiança: é perigoso deixar essa coisa mexer nas minhas coisas? Ela está me espionando? A quarta parte tem o dia em que um agente apagou arquivos meus (e como eles voltaram), o software que entra no ar sem que ninguém tenha lido, e o que os aplicativos do seu celular sabem de você.

O último é o que mais tira gente do sono: e o meu emprego? A quinta parte fala de trabalho e de carreira, explica por que tantas empresas gastam fortunas em IA sem ver resultado e termina com o balanço do ano: onde essa tecnologia estava de verdade em outubro de 2026, e o que isso quer dizer pra você.

Entre as partes há dois interlúdios mais leves, pra respirar. E, pra quem quiser ir mais fundo no funcionamento da máquina, há um apêndice que explica o mecanismo sem fórmula nenhuma (@sec-apmecanica) e uma lista de leituras no fim do livro (@sec-apleituras).

## Como este livro foi feito

<!-- src: original -->
Tudo que está aqui começou como texto no meu blog, escrito ao longo de 2026, quase sempre no calor do experimento: dezenas de textos em que a IA era o assunto principal ou boa parte dele. Pra virar livro, fiz o que o livro inteiro recomenda. Agentes de IA fizeram o trabalho braçal de reorganizar e reescrever, seguindo regras escritas sobre a minha voz e conferindo cada afirmação contra a fonte. A palavra final é minha: nenhum capítulo entra no livro sem que eu leia e aprove, do mesmo jeito que faço com o código que um agente escreve pra mim.

> A máquina faz o trabalho braçal, alguma coisa de fora confere, e alguém que entende do assunto decide.

Esse é o método que você vai ver funcionar, e falhar quando falta uma das três partes, ao longo de todo o livro. Fazer o próprio livro desse jeito foi o último experimento do meu ano, e o posfácio conta como ele correu, inclusive o que a conferência pegou (@sec-posfacio).

## Por onde começar

<!-- src: original -->
Os nomes de modelo que aparecem aqui vão envelhecer rápido, como envelhecem os modelos de carro num romance antigo. Por isso eu deixo a data do lado de cada número. O que não envelhece tão rápido é o jeito como essas coisas funcionam e o jeito como elas são vendidas, e é isso que eu queria deixar com você.

O Elektro nunca virou mordomo de ninguém, e o robô do cinema nunca pousou. A IA que chegou em 2026 também é menor que a vitrine e menor que o filme de terror. E é bem mais útil do que os dois, pra quem sabe o que ela é.

Comece pelo começo. No início de fevereiro de 2026, trechos de um podcast que eu tinha gravado meses antes começaram a circular com uma frase que eu nunca disse, e duas turmas passaram a brigar com um Akita que não existia. Pra explicar o que eu tinha dito de verdade, precisei abrir a caixa e mostrar como essa coisa funciona por dentro.

É por aí que o primeiro capítulo começa.

*Outubro de 2026*
