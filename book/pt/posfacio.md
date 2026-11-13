---
id: posfacio
chapter: "Posfácio: Como este livro foi feito"
sources:
  - {post: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente, sha256: "2cf74b842ce1800799bddb690bf839f846f5804b8aaa656a4e78ecd7b8465c51", commit: "557350127df181c4b124a2c8759648a79e17e4d5"}
  - {post: 2026/10/12/llms-agentes-competente-o-suficiente, sha256: "ee499fef89fe8fe35d652f193b51f1660cd08e8ed77adee74e036ca1444cc54b"}
  - {post: 2026/04/15/como-falar-com-o-claude-code-efetivamente, sha256: "1b8795f593d0bf02003614559d134daa34121962de303cf664aa5e7bc9a3eed0"}
  - {post: 2026/04/09/20-anos-de-blog-o-ano-em-que-a-ia-finalmente-me-deixou-traduzir-tudo, sha256: "247ad116f3c45c935f8a59156a72b8852733e259c70b65044f19fb56c6d32f3b"}
refs_projects: []
blog_commit: "cc8b467dd4d6d3b5c57fad6bb6fae70ec5839a01"
---

# Posfácio: Como este livro foi feito {#sec-posfacio .unnumbered}

<!-- src: 2026/10/12/llms-agentes-competente-o-suficiente -->
Em 12 de outubro de 2026 publiquei no blog a síntese do ano, o texto que virou @sec-ch20. No dia seguinte comecei a transformar aqueles meses num livro. O primeiro [commit]{.gls} do repositório deste livro é de 13 de outubro.

<!-- src: original -->
Eu tinha escrito 131 textos no blog em 2026, quase meio milhão de palavras, com assuntos que iam de [benchmark]{.gls} de modelo a carteira de bitcoin. Reorganizar aquilo à mão, sozinho, levaria meses que eu não tinha. Então fiz o que este livro inteiro descreve: entreguei o trabalho braçal a [agentes]{.gls key=agente} e fiquei com a parte de decidir, montar o processo e conferir.

Vale contar como foi, por dois motivos. Você tem o direito de saber como o texto que leu foi produzido. E o próprio processo é o último exemplo da tese do livro. A pergunta mais óbvia, se este livro foi escrito por IA, tem resposta direta no @sec-apfeito.

## Um inventário lacrado

<!-- src: original -->
O primeiro passo foi um inventário. Um script leu os 131 textos e guardou, pra cada um, um código calculado a partir do conteúdo exato do arquivo. Se uma vírgula muda no post, o código muda junto. Registrei também o ponto exato do histórico do blog de onde tudo foi lido.

Depois, um agente leu cada texto e preencheu um formulário fixo: a tese em uma ou duas frases, as afirmações que um livro precisaria conferir, quais delas envelhecem rápido, que medo de leitor leigo o texto responde, o que cortar. Dos 131, 96 tinham IA como assunto central ou com peso relevante. Os outros só entraram quando ensinavam alguma coisa específica, e cada texto sobre IA deixado de fora tem o motivo anotado. No meio do caminho eu mudei o corte: os textos de janeiro saíram, e a história do livro ficou entre fevereiro e outubro.

<!-- src: original -->
Muita coisa que eu escrevi em fevereiro não valia mais em setembro. Refiz o meu benchmark várias vezes no ano, corrigi custos, troquei de opinião sobre ferramentas. Por isso o processo tem um mapa de linhagem, que diz qual texto substituiu qual e o que ainda dá pra aproveitar do mais velho. Os capítulos contam o estado mais recente e, quando a mudança ensina alguma coisa, contam a mudança.

Das análises saiu uma proposta de estrutura: cinco partes, cada uma respondendo a um medo do leitor, vinte capítulos e dois interlúdios. Eu li, mexi e aprovei. Algumas peças entraram a meu pedido, como @sec-antes e o apêndice sobre a máquina por dentro (@sec-apmecanica), porque eu queria que o leitor soubesse o que o livro deixa de explicar e onde aprender.

## O contrato

<!-- src: original -->
Antes de escalar, um capítulo piloto. O escolhido foi @sec-ch05, e ele serviu pra calibrar a voz e descobrir as dúvidas que um agente teria no meio do caminho. Cada dúvida resolvida virou uma regra escrita. Uma delas: quando o resumo do capítulo e o post discordam num detalhe, vale o post.

Essas regras foram pra um documento que todo agente lia antes de escrever, junto com o guia de voz, que herda as regras do meu blog, e com um arquivo de continuidade dizendo qual capítulo explica cada conceito e como cada personagem se chama. É o [arquivo de instruções do projeto]{.gls key=agents-md} de @sec-ch09, na escala de um livro.

<!-- src: original -->
Com o contrato pronto, os capítulos foram rascunhados em paralelo, em levas, um agente por capítulo. Agentes trabalhando ao mesmo tempo se contradizem, e isso aconteceu.

Um capítulo dizia que o FrankMD teve uns 130 commits em três dias; outro, que teve 212 em 19 dias. Os dois números vinham dos posts e estavam certos, só que eram janelas diferentes. Um registro de integração juntou esses conflitos, e a regra foi explicitar a janela em cada capítulo.

Por cima de tudo roda um verificador automático, o equivalente da [integração contínua]{.gls key=ci} de @sec-ch06. Ele reprova travessão, frases proibidas pelo guia de voz, link solto no meio do texto, citação que não existe na bibliografia e capítulo sem marca de origem. Capítulo com erro não passa.

## O que a conferência pegou

<!-- src: original -->
Cada número, data e nome foi conferido contra três coisas: os posts, os projetos de referência (o repositório do benchmark, o do ai-memory, o do ai-jail e as minhas anotações do servidor de casa, que ficam num repositório privado) e fontes primárias na internet. Alguns exemplos do que essa conferência pegou:

- no review de março do meu mini-PC com chip Strix Halo, eu tinha separado 96 GB de memória pra parte de vídeo. Em 8 de abril baixei pra 64 GB, e alguns textos posteriores ainda falavam em 96. O livro usa 64 pra tudo depois de abril (@sec-ch13);
- um defeito na contagem de uma das ferramentas do benchmark subestimou de 40 a 90 vezes o custo das execuções feitas nela antes de agosto (@sec-ch11). O livro não cita nenhum desses custos;
- no texto de junho sobre o Claude Fable 5, eu escrevi que ele custava dez vezes mais que o Opus 4.8 por execução. Em julho, refazendo as contas do benchmark, descobri que as estimativas antigas deixavam de fora os tokens lidos do cache: o Opus 4.8 saía por uns 6 dólares, não pouco mais de um, e o Fable custava quase o dobro, não dez vezes. O post de junho ainda diz dez vezes; o livro conta o número errado e a correção (@sec-ch14);
- no texto de março sobre o vazamento do código do Claude Code, eu escrevi que a Anthropic tinha comprado o Bun no fim de 2024. O anúncio do próprio Bun é de dezembro de 2025, e é essa a data que o livro usa (@sec-ch16) [@sumner2025anthropic];
- o resumo de um capítulo, escrito por agente, dizia que a trava de assinatura do Claude Code tinha caído em menos de um dia depois do vazamento do código (@sec-ch16). O anúncio original saiu umas 30 horas depois, e o livro diz "no dia seguinte" [@guthrie2026drm];
- o estudo da METR sobre produtividade, que eu tinha descrito como feito em código privado, usou projetos grandes de código aberto [@becker2025measuring].

<!-- src: original -->
Repare que boa parte dessas correções é do meu próprio blog. Em alguns pontos, o livro ficou mais preciso que os textos de onde saiu. E uma delas corrigiu um resumo escrito por agente, porque a fonte vence o resumo, inclusive quando o resumo vem da máquina.

> Os rascunhos saíram rápido. A confiança no texto veio da conferência.

## Um rastro por parágrafo

<!-- src: original -->
Cada parágrafo deste livro, no arquivo de origem, carrega uma marca invisível dizendo de onde veio: de qual post, de qual projeto de referência, ou se é texto novo escrito pro livro. A marca some na hora de montar o livro, então você nunca a vê.

Ela serve pra manutenção. Se amanhã eu corrigir um post, um script refaz o código de cada texto, vê qual mudou e aponta os capítulos que dependem dele. A marca leva direto aos parágrafos que saíram daquele post, e só eles precisam ser revistos. A bibliografia faz o mesmo papel pras fontes de fora: cada referência anota qual post a citou.

<!-- src: original -->
As imagens seguem a mesma lógica. Os diagramas e gráficos foram escritos como código, e cada gráfico traz no próprio código a indicação do capítulo de onde vieram os dados. As ilustrações geradas por IA estão marcadas como tais, e o pedido, o modelo e a data de cada uma ficam registrados.

Pessoas reais aparecem em fotografias, com a origem e o crédito disponível na legenda e nos @sec-creditos. A situação de licença ou permissão de cada foto fica registrada individualmente, inclusive quando a autorização de reprodução ainda não foi verificada. Nenhuma imagem de pessoa real foi gerada por IA.

## Leitores de mentira

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
Copidesque confere o texto. Ele deixa passar a pergunta que importa num livro pra leigo: a pessoa pra quem eu escrevi consegue ler até o fim, entende e sai convencida? Pra responder, o livro passou por leitores simulados. Da seção "Pra quem eu escrevi", no prefácio, saíram cinco: a Marina, contadora com medo de perder o emprego; o Roberto, dono de loja cujo filho perguntou sobre superinteligência; a Carla, gerente a quem venderam uma "transformação por IA"; o Lucas, programador júnior com medo de ter escolhido a carreira errada; e a Helena, professora aposentada que veio pelas histórias.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
Cada um foi um agente só de leitura, lendo o livro inteiro em ordem, como aquela pessoa leria, com a instrução de ser leitor e não editor. Cada um devolveu uma nota por capítulo, o que o fez se perder ou se entediar e as falhas de lógica que encontrou. Um editor juntou tudo. Falha de lógica, conferida contra o texto e os posts, era corrigida independentemente de voto; questão de clareza só entrava se mais de um leitor levantasse; gosto de um leitor só ficava de fora.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
A primeira leitura deu a medida do desequilíbrio. Histórias e ferramentas práticas funcionavam pra todo mundo, e o miolo cheio de medição, os capítulos de @sec-ch11 a @sec-ch13, perdia quem não programa. Os cinco pegaram as mesmas falhas de argumento: uma conclusão maior que a evidência no @sec-ch20, um raciocínio que nunca perde no @sec-ch09, um guia de leitura que mandava quatro dos cinco pro capítulo errado. Cada padrão virou uma regra escrita, que os agentes passaram a ler antes de editar.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
Daí veio o rebalanceamento. Umas 8 mil palavras de caderno de laboratório saíram dos capítulos pra @sec-aptecnico, cada parágrafo com a sua marca de origem; a lista de leituras virou apêndice; uma seção inteira foi guardada fora do livro enquanto a verificação estava pendente; cada capítulo passou a orientar o leitor antes do primeiro jargão; e o epílogo ganhou uma lista do que fazer nesta semana, por tipo de leitor. Foram três rodadas, ler, editar e ler de novo, porque a edição conserta o problema velho e cria o novo: as falhas de lógica caíram de 73 pra 53 e 51, e a revisão parou quando os problemas deixaram de voltar.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
Os mesmos cinco leitores conferiram depois os capítulos que ganharam a minha história de antes de 2026. O veredito virou regra: a história do narrador convence quando é evidência que o leitor consegue checar, como o aviso com data ao lado do erro admitido, e atrapalha quando vira currículo. As linhas que três ou quatro deles marcaram como exibição saíram do livro.

## O que eu mantenho hoje

<!-- src: original -->
O livro cita muitos programas meus, e boa parte foi experimento de poucos dias, feito pra medir alguma coisa e deixado no estado em que parou. Em outubro de 2026, o que eu mantinha de fato era pouca coisa.

De um lado, as ferramentas pra trabalhar com agentes: o ai-memory (@sec-apmemoria), o ai-jail (@sec-apB), o ai-usagebar, que mostra o consumo dos planos de IA, e o ghpending, que junta as pendências dos meus repositórios. Do outro, os benchmarks: o de programação de @sec-ch11, o dos classificadores de @sec-ch13 e o das linguagens de @sec-ch18. A série Frank continua publicada, cada projeto no ponto em que eu o deixei. A lista completa está no GitHub, em github.com/akitaonrails.

## O que continua sendo meu

<!-- src: 2026/04/15/como-falar-com-o-claude-code-efetivamente -->
No @sec-ch09 eu contei que o texto do blog sobre como falar com o Claude Code foi escrito pelo próprio Claude, a partir de um pedido meu, e corrigido por mim enquanto ele escrevia. Este livro foi feito do mesmo jeito, em escala maior. Este posfácio também: o rascunho saiu do Claude, rodando no Claude Code, a partir de um pedido meu.

<!-- src: 2026/04/09/20-anos-de-blog-o-ano-em-que-a-ia-finalmente-me-deixou-traduzir-tudo -->
Não foi a primeira vez no ano. Em abril, o Claude Code traduziu vinte anos de blog em pouco mais de um dia e meio (@sec-interlude1). Noventa por cento correu liso, e os outros dez só se resolveram porque alguém leu a lista do que tinha falhado e foi atrás de outro caminho.

<!-- src: 2026/10/12/llms-agentes-competente-o-suficiente -->
Esse é o ponto de @sec-ch20 aplicado ao próprio livro. Qualquer um dos bons modelos de outubro de 2026 teria escrito rascunhos parecidos, porque o modelo virou commodity, uma mercadoria quase intercambiável. O que fez o processo funcionar foi o que está em volta dele: o inventário, o contrato escrito, o verificador automático, as fontes como [oráculo]{.gls key=oraculo}, o rastro por parágrafo. É a mesma engenharia velha que eu defendi em cada capítulo, aplicada a texto.

<!-- src: original -->
O repositório registra o primeiro commit e os rascunhos dos capítulos da estrutura inicial no mesmo dia. São os primeiros dez por cento de @sec-ch05: impressionam e quase não dizem nada sobre o resto. Os outros noventa por cento são leitura, corte e correção.

E essa parte é minha. As experiências do livro são as que eu vivi, e as opiniões são as que eu escrevi ao longo do ano, nenhuma inventada pra preencher capítulo. A estrutura foi aprovada por mim. Nenhum capítulo entra no livro sem que eu leia e aprove, e o que eu mando refazer volta pro mesmo processo.

<!-- src: original -->
A máquina escreveu rápido. Quem responde por cada frase deste livro sou eu, inclusive pelos erros que passaram pela conferência. Quando aparecer um, o rastro existe justamente pra que a correção chegue ao parágrafo certo.

> Os agentes foram competentes o suficiente pra escrever o rascunho. Decidir o que ele dizia continuou sendo trabalho meu.
