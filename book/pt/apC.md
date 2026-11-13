---
id: apC
chapter: "Como ler um benchmark ou um anúncio"
sources:
  - {post: 2026/07/19/llm-benchmark-devo-usar-o-que-tem-nota-maior, sha256: "0c064de942568d0b2b29ff979ee157d364b94817d2374aa5937bee377402daa5"}
  - {post: 2026/04/24/llm-benchmarks-parte-3-deepseek-kimi-mimo, sha256: "e81505f0acafb44f3a1df187f5e774f9cf01a3187c8c20d9535b28bbcbdf9f02"}
  - {post: 2026/07/09/llm-benchmark-grok-4-5-gpt-5-6-sol, sha256: "6f9b7da43d8479867207771f58cd20ea3ce569b5c764df3b18cc4cc64ac21c74"}
  - {post: 2026/07/30/novo-llm-benchmark-refiz-todos-os-testes, sha256: "d807e842d6f0ae2e9032e8e94b5feae78256e3400e4e9bac56c07e3571cbed99"}
  - {post: 2026/09/15/novo-llm-benchmark-v4-retestando-todos-llms-parte-1, sha256: "e6e28596d99d2ce9857a4ab24cba5d3b50e5e4d8fc6fd3d8e2b5132122cd7025"}
  - {post: 2026/09/15/novo-llm-benchmark-v4-retestando-todos-llms-parte-2, sha256: "f39a66e4bdcfecb3c852952a4dbe840c264ac81e72327d6ae4054aa591ba6163"}
  - {post: 2026/07/01/llm-benchmark-sonnet-5-gemini-3-5-flash-sakana-fugu-ultra, sha256: "7963a48cb5edda6211c8f8c37df67a62b97ca78cdd29dff37ba9b736a4a34672"}
  - {post: 2026/08/15/llm-benchmarks-qwen-3-8-glm-5-3-gemini-3-7, sha256: "8013f8c30e232cbecd9018f446ac08156f908ad04aeb7a952348d776186c7849"}
  - {post: 2026/06/15/controversia-llm-rio-3-5-plagio, sha256: "61a54d101f81b21d2fee42f753300b18d75271c745b8e681dec9418fdef38565"}
  - {post: 2026/06/11/llm-benchmark-fable-5-e-a-novela-da-anthropic, sha256: "ce3ac52806404b9410bbe7b38962bc96d1beaff182ad194e2dbc1f18630c5d30"}
  - {post: 2026/09/09/propagandas-enganosas-da-openai-anthropic-nvidia, sha256: "a84bedcd9978e6c7c3437da76c41f08c4a40648a92c50989949704cad2a80eb9"}
  - {post: 2026/08/18/hot-take-harness-loop-engineering-graph-engineering-sao-bullshit, sha256: "903caf191c73bee2866924e22860432a7b13b42e4c7a7a170f3fe4a9293b7e25"}
  - {post: 2026/09/16/por-que-coisas-como-typesafe-ia-nao-me-interessam, sha256: "320ec83b6a68fa8bca013192989c2e5a0613c1c54223b8c6441cef5e62a0d896"}
  - {post: 2026/10/03/entendendo-o-hype-do-jev-pra-que-serve, sha256: "003d104009e3c6bf7c342a51aca0fbe971432cbbc44fc9e591946e9b68b67c8b"}
refs_projects:
  - "llm-coding-benchmark/docs/success_report.v4.combined.md"
blog_commit: "cc8b467dd4d6d3b5c57fad6bb6fae70ec5839a01"
---

# Como ler um benchmark ou um anúncio {#sec-apC}

<!-- src: original -->
Em 2026 eu passei meses medindo modelos de IA e lendo anúncios sobre eles, e errei nas duas coisas mais de uma vez. Este apêndice junta as perguntas que sobraram desses erros, em duas listas de uma página cada: uma pra quando alguém te mostra uma tabela, outra pra quando alguém te conta uma novidade.

Os nomes dos modelos e as notas vão envelhecer rápido; as perguntas devem durar bem mais. Cada item traz a pergunta, o motivo dela em uma frase e o capítulo onde a história completa está contada, se você quiser ver o tropeço que a originou.

## Diante de uma tabela

<!-- src: 2026/07/19/llm-benchmark-devo-usar-o-que-tem-nota-maior -->
Vale pra qualquer [benchmark]{.gls}, ranking ou placar de modelos, inclusive o meu.

1. **Qual era a tarefa, em que ferramenta, corrigida por qual critério?** A nota descreve um trabalho, feito num [harness]{.gls} específico e avaliado por uma [rubrica]{.gls key=rubrica} específica, e trocar só o programa em volta do modelo já levou um deles do "impossível de medir" ao topo da tabela (@sec-ch03, @sec-ch11).
2. **Quantas vezes rodaram?** Uma rodada só é amostra de um: no meu teste, em setembro de 2026, o mesmo modelo, repetido sem mudar nada, caiu nove pontos, e isso tem nome, [ruído entre execuções]{.gls key=ruido-entre-execucoes} (@sec-ch11).
3. **A diferença é maior do que o ruído?** No topo, os modelos formam um grupo, e brigar pela posição exata lá dentro é precisão inventada; escolha primeiro o [tier]{.gls}, depois decida por preço, tempo e a ferramenta que você já usa (@sec-ch11).
4. **Quem corrigiu, e as correções estão publicadas?** O juiz também erra, eu errei várias vezes, e um benchmark sério mostra o pedido, o código gerado, os registros e as erratas, enquanto quem mostra só o gráfico não deixa ninguém contestar (@sec-ch11).
5. **Como o custo foi contado?** Já vi custo subestimado por esquecer releituras do cache e por um programa que só somava o último passo, então confie na ordem de grandeza e desconfie de "por centavos" (@sec-ch11).
6. **A prova ainda separa alguém?** Quando quase todo mundo tira entre 95 e 100, a prova está saturada, e a ordem passa a ser decidida por detalhe, sem dizer quase nada sobre capacidade (@sec-ch11).
7. **A resposta pode ter vazado pro treino?** Prova famosa e antiga corre o risco de [contaminação]{.gls key=contaminacao}, e passar no corretor automático é diferente de ter o trabalho aceito por quem mantém o projeto de verdade (@sec-ch11).
8. **Quem escreveu a verificação?** Teste verde escrito pelo mesmo modelo que escreveu o código pode concordar com o próprio erro, como um [mock]{.gls} feito sob medida pra aceitar um comando que não existe (@sec-ch12).
9. **O modelo tinha o gabarito ao alcance?** Agente usa tudo que estiver na pasta, inclusive a rubrica e o trabalho dos concorrentes, então nota boa demais pede leitura do registro da execução (@sec-ch12).
10. **O que o teste prova sobre a origem do modelo?** Com os pesos na mão dá pra fazer conta e chegar perto de uma prova; por fora, só pela API, um [teste de caixa-preta]{.gls key=caixa-preta} ajuda a investigar hipóteses e boatos, mas não certifica a origem (@sec-ch12).
11. **Você já rodou o seu?** Se a escolha vale dinheiro ou risco, pegue uma tarefa parecida com a sua, rode os candidatos mais de uma vez, compare sem saber quem fez o quê e meça quanto trabalho humano faltou no fim (@sec-ch11).

<!-- src: 2026/07/19/llm-benchmark-devo-usar-o-que-tem-nota-maior -->
> Uma tabela diz o que aconteceu numa prova, numa rodada. O que isso vale no seu trabalho, só o seu teste responde.

## Diante de um anúncio

<!-- src: original -->
Antes das perguntas, um hábito que eu trouxe dos testes de origem de modelos (@sec-ch12):

> Separe o anúncio em três colunas: o que alguém de fora mediu, o que é só a palavra de quem vende e o que ninguém sabe. Quase todo o barulho mora na do meio.

<!-- src: 2026/09/09/propagandas-enganosas-da-openai-anthropic-nvidia -->
A lista completa que eu uso, com os casos de 2026, está na @sec-como-ler-anuncio. Esta é a versão de bolso.

1. **Quem ganha dinheiro se você acreditar?** Atrás da frase costuma ter um [IPO]{.gls key=ipo}, uma placa de vídeo pra vender ou um curso, e interesse financeiro não torna nada falso, só pede prova mais forte (@sec-ch14).
2. **Alguém de fora consegue testar?** "Perigoso demais pra lançar", consórcio fechado e lista de espera são alegações até um independente medir, e esse roteiro já tinha sido usado em 2019 (@sec-ch01, @sec-ch14).
3. **Qual é a definição da palavra grande?** Quando quem vende o equipamento declara que a [AGI]{.gls key=agi} chegou, pergunte o que ela quer dizer, porque no contrato entre OpenAI e Microsoft a palavra virou meta de lucro [@zeff2024agi] (@sec-ch14).
4. **Contra quem é a comparação, e com qual régua?** "Centenas de vezes mais barato" sempre tem um adversário escolhido a dedo, e "zero alucinação" pode ser zero por definição, então ache a frase que explica como o número foi medido (@sec-ch14).
5. **O que esse produto é, tirando o nome?** O lançamento revolucionário de setembro de 2026 era um [classificador]{.gls key=classificador}, técnica de décadas, e muito "novo paradigma" é prática velha com nome novo pra vender consultoria (@sec-ch14).
6. **Isso aconteceu ou poderia acontecer?** Leia os verbos: "poderia", "em poucos meses", "se fosse mais capaz" têm um peso diferente do de um fato documentado, e o apocalipse dos anúncios costuma morar inteiro no condicional (@sec-ch14).
7. **Quem ganha com o seu medo?** O aviso de catástrofe e o anúncio do milagre empurram o mesmo carrinho, e um pedido de regulação escrito sob medida pros líderes trava o concorrente pequeno (@sec-ch14).
8. **Quanto custou o feito?** Um resultado obtido com milhões de dólares de computação mostra força bruta e dinheiro, e diz bem menos sobre a inteligência da máquina (@sec-ch14).
9. **As vozes que concordam são independentes?** Dez influenciadores repetindo o mesmo comunicado contam como uma voz, e duas IAs concordando com a hipótese que você escreveu na pergunta são um eco (@sec-ch04, @sec-ch14).
10. **A credencial confere com as datas?** Nome do artigo, ano e lista de autores estão a uma busca de distância, e a credencial anunciada às vezes é maior do que a real (@sec-ch14).
11. **Você precisa disso hoje?** Quase toda manchete grande de 2026 mudou de forma em poucas semanas, e eu só adoto uma ferramenta nova quando sinto a falta dela doer (@sec-ch14).

<!-- src: original -->
Se você vai usar um chatbot pra investigar o anúncio, junte a esta a lista de @sec-ch04: perguntar sem entregar a própria opinião, abrir a fonte e subir até a [fonte primária]{.gls key=fonte-primaria} valem tanto quanto as perguntas acima.
