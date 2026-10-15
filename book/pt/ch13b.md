---
id: ch13b
chapter: "Um modelo feito em casa"
sources:
  - {post: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo, sha256: "ad97af1386db2d2b4ecc0429acb08c852b2124f509923bf7a45df17f22f233b4"}
  - {post: 2026/10/10/qual-modelo-de-decisao-classificador-de-ia-tipo-jev-e-melhor, sha256: "90819aaee0a700994dc5dbcc83018b026811a12e9ea657a31c3e2d53c6270c0b"}
  - {post: 2026/10/12/llms-agentes-competente-o-suficiente, sha256: "ee499fef89fe8fe35d652f193b51f1660cd08e8ed77adee74e036ca1444cc54b"}
refs_projects:
  - "microgpt/README.md"
  - "microgpt/docs/report/experiment-closeout.md"
  - "microgpt/docs/report/training-time-ledger.md"
blog_commit: "620e97e1a5d5b2a18454d512cc1ae7851db5df31"
---

# Um modelo feito em casa {#sec-ch13b}

<!-- src: ref:microgpt/docs/report/training-time-ledger.md -->
Em 7 de outubro de 2026, às quatro da tarde, eu mandei a mesma RTX 5090 do @sec-ch13 começar um trabalho diferente. Em vez de rodar um modelo que outra empresa treinou, ela ia treinar um do zero. Os 337 milhões de botões do modelo começaram em posições sorteadas, e o que ele escrevia naquela hora era lixo puro.

<!-- src: original -->
Você já leu no @sec-ch01 quanto custa o caminho de verdade: só o processamento usado pra treinar o GPT-4 saiu por uns 78 milhões de dólares, pela estimativa de Stanford [@hai2024aiindex]. Prédios inteiros de placas de vídeo, times de pesquisadores, meses de trabalho. Visto daqui de fora, parece coisa de mago, feita num porão por meia dúzia de gênios.

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Eu queria saber quanto dessa impressão é verdade. Faltava esse exercício na minha lista do ano: construir, com as minhas mãos, um modelo de linguagem menor que o GPT-2, partindo de pesos aleatórios, e ver até onde dava pra chegar em poucos dias. Se desse, ligar esse modelo num agente de programação de verdade, como os que você conheceu no @sec-ch03.

Antes de continuar, quem eu sou nessa história. Eu programo há mais de trinta anos, mas em pesquisa de modelos de linguagem sou amador: curioso, sem nenhum artigo publicado. Eu sabia que não ia sair dali com um modelo útil em tão pouco tempo, e isso fazia parte do exercício.

## Duzentas linhas

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
O ponto de partida veio de fevereiro. O Andrej Karpathy, um dos fundadores da OpenAI e ex-chefe de IA da Tesla, publicou um arquivo chamado microgpt: 200 linhas de Python, sem nenhuma biblioteca externa, que treinam e rodam um GPT [@karpathy2026microgpt]. Ele descreveu o arquivo como "o conteúdo algorítmico completo do que é necessário". E completou: "todo o resto é só eficiência".

O arquivo fecha uma linhagem de projetos didáticos dele: o micrograd, que mostra em poucas dezenas de linhas como o erro volta pelos botões; o makemore, que gera nomes; o nanoGPT, um GPT-2 compacto. E, um passo depois, o nanochat, que ele chamou de o melhor ChatGPT que 100 dólares compram [@karpathy2025nanochat].

O microgpt é pequeno de propósito. O material de estudo são 32 mil nomes próprios, um por linha, e cada letra é um [token]{.gls}. A rede tem uma camada só, treina por mil passos e, no fim, inventa nomes que nunca existiram. Tudo isso leva um minuto num MacBook.

<!-- src: original -->
O que me chamou a atenção é que tudo que o apêndice sobre a máquina por dentro descreve está ali, exposto num arquivo só (@sec-apmecanica). O painel de botões sorteados, a adivinhação do próximo pedaço, a medida do erro, o passo pequeno morro abaixo na neblina, o marca-texto da atenção, o dado viciado no fim. Dá pra ler de cima a baixo numa tarde.

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Depois de ler aquilo, o que separa você de um modelo de verdade é, nas palavras dele, eficiência. Eu fui ver quanta.

<!-- src: ref:microgpt/README.md -->
O resultado foi o microgpt lab, um projeto aberto que eu escrevi do zero, inspirado no arquivo dele [@akita2026microgpt]. São umas 3.300 linhas de Python, organizadas por conceito, com testes, e um relatório de fechamento que registra cada decisão, cada medida e cada erro; é dele que saem os números deste capítulo. A regra do exercício era treinar do zero, então nenhum peso pronto foi baixado de lugar nenhum: todo modelo ali começa sorteado e aprende com o código do próprio projeto.

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
O projeto passou por quatro tamanhos. Começou com uma lição de menos de um milhão de parâmetros, que roda num processador comum e ensina o ciclo inteiro. Passou por modelos de 91 e de 239 milhões, que me ensinaram a maior parte dos tropeços que vou contar. E terminou no modelo final, de 337 milhões de [parâmetros]{.gls key=parametros}, e é dele que falo daqui em diante.

## As seis estações

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Independente do tamanho, construir um modelo de linguagem passa pelas mesmas estações. O que muda de um modelo de garagem pra um de fronteira são os zeros à direita em cada uma.

![As seis estações de construir um modelo de linguagem, com os números do meu modelo de 337 milhões de parâmetros.](assets/figures/ch13b-estacoes.png){#fig-ch13b-estacoes fig-alt="Seis caixas lado a lado, ligadas por setas da esquerda pra direita. Dados: 20 GB baixados, 3,5 bilhões de tokens. Tokenizador: 32.768 entradas. Pré-treino: 10 bilhões de tokens, 137 horas. Ajuste (SFT): 4.000 atualizações com exemplos. Servidor: API compatível com a OpenAI. Avaliação: 100 tarefas reservadas."}

### Dados

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
Modelo é o que ele come. Baixei seleções de acervos públicos de texto, cada uma com a versão fixada e conferida: código Python de projetos abertos, exemplos de instrução e código, texto educativo, conversas e uma fatia em outras línguas. Os 14 pacotes somaram uns 20 GB brutos.

Daí vem a curadoria, que é onde mora boa parte do trabalho. Tirar duplicatas exatas. Separar o que é treino do que é prova por projeto inteiro, nunca linha por linha, senão o mesmo projeto vaza pros dois lados e o modelo é avaliado com a cola em cima da mesa (@sec-ch12). E decidir a mistura: o acervo final ficou com 3,5 bilhões de tokens, e 60% do que o modelo lia era código Python.

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Cada uma dessas proporções é uma decisão de projeto. Nenhuma tem resposta certa publicada.

### Tokenizador

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
O [tokenizador]{.gls key=tokenizador} é o dicionário que converte texto em números e de volta, os pedaços de palavra do @sec-ch01. A maioria dos tutoriais pega emprestado um vocabulário pronto, e eu também peguei no começo: o da OpenAI, com 200 mil entradas. No modelo final, treinei um vocabulário próprio, com 32.768 entradas.

Parece detalhe de encanador. Mais adiante você vai ver quanto do cérebro de um dos modelos essa escolha engoliu.

### Pré-treino

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
Aqui está o laço do Karpathy em escala. O [pré-treino]{.gls key=pre-treino} pega janelas de 2.048 tokens do acervo, esconde o pedaço seguinte e pede pro modelo adivinhar, como o apêndice descreve (@sec-apmecanica). Cada rodada de ajuste dos botões olha 32.768 tokens de uma vez.

Foram 305 mil rodadas, 10 bilhões de tokens lidos. Como o acervo tinha 3,5 bilhões, o modelo viu cada documento, em média, quase três vezes: o código, umas duas; o texto educativo e as conversas, umas nove ou dez. No caminho, eu congelei e guardei três versões, com 2, 5 e 10 bilhões de tokens, pra medir a curva de aprendizado depois.

### Ajuste (SFT)

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
O pré-treino produz um continuador de documentos, o do sapo que viaja até a Grécia antiga, no exemplo do InstructGPT que o apêndice conta (@sec-apmecanica). Pra ele responder a um pedido, vem o ajuste, a forma mais simples do [pós-treino]{.gls key=pos-treino}: exemplos de pergunta e resposta, e o modelo treina mais um pouco em cima deles. Quem trabalha com isso chama de SFT, sigla em inglês de "ajuste supervisionado"; daqui em diante, eu chamo só de ajuste.

Os exemplos vieram de um acervo público da NVIDIA com problemas de programação e suas respostas. Antes de entrar, cada resposta foi executada de novo, três vezes, numa caixa fechada, isolada do resto do computador, e só ficou a que passava nos próprios testes. Quase todas passaram.

### Servidor

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Um agente como o OpenCode conversa com o modelo pela rede. Manda o histórico, a lista de ferramentas que o modelo pode pedir, e espera de volta um texto ou um pedido de ferramenta no formato certo, o [tool calling]{.gls key=tool-calling} do @sec-ch03. O projeto implementa esse ciclo inteiro, com um servidor que fala a mesma língua da API da OpenAI.

Isso tudo é encanamento, sem inteligência nenhuma. E, sem ele, o modelo nem senta à mesa.

### Avaliação

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
A estação que mais mudou o projeto. Montei 100 tarefas de programação em Python pra escolher entre as versões do modelo, a prova de escolha, e separei outras 100, guardadas a sete chaves, que só a versão final ia ver, a prova final. Cada resposta roda numa caixa fechada, sem internet e sem permissão de mexer no resto do computador, contra testes fixos.

Também entraram quatro consertos de verdade num repositório, feitos pelo OpenCode, problemas de acompanhar a saída exata de um programa curto, buscas por um número escondido no meio de um texto longo, e algumas conversas simples.

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
Uma ressalva que vale pro resto do capítulo. São provas pequenas, feitas em casa, com tarefas parecidas entre si, uma tentativa só por tarefa. Servem pra comparar versões do mesmo modelo. Quando eu disser que ele acertou 58 de 100 na prova final, isso quer dizer 58 daquelas 100 tarefas, e nada sobre programação em geral, a régua caseira de que o @sec-ch11 fala.

## Tamanho do cérebro, anos de escola

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
O modelo final tem 337 milhões de parâmetros, 24 camadas, e foi treinado com 10 bilhões de tokens. Pra comparar com o que você já conhece: o GPT-2 completo, de 2019, tinha 1,5 bilhão de parâmetros (@sec-ch01). O meu é quatro vezes e meia menor.

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
A comparação que mais ensina, porém, é outra. O SmolLM2, um modelo aberto de 360 milhões de parâmetros, praticamente do tamanho do meu, foi treinado com 4 trilhões de tokens [@huggingface2024smollm2]. Quatrocentas vezes mais texto. No ritmo da minha placa, ler isso tudo levaria entre quatro e seis anos de máquina ligada, sem parar.

![Quanto texto cada modelo leu no pré-treino. A escala é logarítmica: cada marca vale dez vezes a anterior.](assets/figures/ch13b-escala.png){#fig-ch13b-escala fig-alt="Gráfico de barras horizontais em escala logarítmica com os tokens lidos no pré-treino. Este modelo: 10 bilhões. SmolLM2-360M: 4 trilhões. Llama 3.1: 15 trilhões. Qwen3: 36 trilhões. A barra deste modelo é a menor, e a do Qwen3, a maior."}

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Até a matéria-prima dá escala. O GPT-2 foi treinado com uns 40 GB de texto, tirados de 8 milhões de páginas da web [@radford2019better]. Eu baixei 20 GB, e mais da metade era código.

Os grandes modelos abertos vão muito além. O Llama 3.1, da Meta, leu uns 15 trilhões de tokens [@meta2024llama31card]; o Qwen3, da Alibaba, 36 trilhões [@qwen2025qwen3].

Por isso "parâmetros" é uma unidade enganosa. Ela diz o tamanho do cérebro e não diz nada sobre quantos anos de escola ele teve.

> Parâmetro mede o tamanho do cérebro. Token de treino mede os anos de escola. Dois modelos do mesmo tamanho podem ter estudado coisas de ordens de grandeza diferentes.

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Existe uma regra de bolso famosa sobre isso, tirada de um estudo de 2022 da DeepMind, do Google, que ficou conhecido como Chinchilla: pra usar melhor o processamento, dê uns 20 tokens de treino pra cada parâmetro [@hoffmann2022training]. Pro meu modelo, isso dá uns 6,7 bilhões, e eu passei disso. Só que os modelos pequenos modernos passam muito desse ponto de propósito, porque um modelo pequeno que estudou mais fica barato de usar pelo resto da vida.

### A conta

<!-- src: ref:microgpt/docs/report/training-time-ledger.md -->
O pré-treino ocupou uns 137 horas de máquina, espalhadas por seis dias e meio de calendário, entre pausas, manutenção e recomeços. O ajuste somou mais umas três horas e meia. Tudo numa placa só, a mesma que eu uso pra jogar.

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Ninguém mediu o consumo de energia de verdade, então eu fiz conta de padeiro. Com a placa no máximo da potência nominal durante as 137 horas, seriam uns 79 kWh [@nvidia2025rtx5090], o que dá no máximo uns 80 reais de luz em São Paulo. O real foi menos, porque durante o dia o treino pausava um quarto do tempo pra não travar o meu computador.

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Quem não tem a placa pode alugar uma igual na nuvem por uns US$ 1,20 a hora, em outubro de 2026 [@runpod2026pricing]: as minhas 137 horas sairiam por uns US$ 165.

Do outro lado da escala, o Llama 3.1 de 405 bilhões de parâmetros consumiu umas 225 mil vezes as minhas horas de placa, em placas bem mais rápidas que a minha [@meta2024llama31card]. Até a DeepSeek, famosa por treinar barato, gastou uns 5,6 milhões de dólares só na rodada final [@deepseekai2024v3].

## Os tropeços

<!-- src: original -->
A lista completa de erros está no relatório de fechamento do projeto, e a parte técnica foi pro apêndice de quem programa (@sec-aptecnico-microgpt). Aqui ficam os que você já conhece deste livro, agora acontecendo comigo, do lado de quem treina.

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
Não foi tentativa e erro no escuro. Cada mudança de receita teve um grupo de controle, cada gasto grande de máquina passou por um ponto de decisão antes, e as tarefas reservadas ficaram trancadas até o fim. Mesmo assim, o projeto cresceu muito além de um tutorial, e várias decisões do começo misturaram mudanças demais pra saber qual funcionou.

### Uma prova parecida demais com a aula

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
O modelo de 91 milhões foi o primeiro a funcionar dentro do OpenCode. Numa tarefa de aritmética que ele tinha treinado, sustentou uma sessão de 32 rodadas, com 130 chamadas de ferramenta, recuperando de erro no meio do caminho. Parecia pronto.

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Aí eu pedi, na mão, uma função de "olá, mundo" que recebe um nome e imprime a saudação. O modelo repetiu duas vezes a edição aritmética anterior, apontou pra um arquivo que não existia e, na terceira tentativa, devolveu um pedido de ferramenta quebrado. Tudo que ele sabia era a família de tarefas do treino.

<!-- src: original -->
É o problema do @sec-ch12 visto do outro lado da mesa. Eu não precisei de ninguém roubando a folha de respostas: a minha prova era parecida demais com a aula, e o modelo foi bem na aula.

### O erro caiu, o código piorou

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
Treinar um modelo é olhar o tempo todo pra um número, a [perda]{.gls key=perda}, que mede o tamanho do erro na adivinhação. Quanto menor, melhor, em tese. No ajuste final, eu dobrei o treino de 4 mil pra 8 mil rodadas. A perda continuou caindo, e o acerto na prova de escolha caiu de 68 pra 62.

<!-- src: original -->
Daí em diante, a escolha entre versões passou a ser feita só pelas tarefas executadas, numa lista congelada antes. É a lição do @sec-ch11 sobre contar testes: a perda é a opinião do treino sobre si mesmo, e quem dá a nota de verdade é o programa rodando.

### O modelo que jurou que passou

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
Em um dos treinos mistos, com o modelo de 239 milhões, ele aprendeu a usar ferramentas e aprendeu outra coisa junto: dizer que os testes tinham passado quando não tinham. É o mesmo modelo que jura que funciona do @sec-ch12, e eu não ensinei isso a ele de propósito. A minha leitura é que ele copiou o padrão dos textos em que os testes passam.

Os dados também mentiam. Respostas marcadas como corretas no acervo público falhavam quando eu rodava de novo. Testes dependiam de uma ordem que muda a cada execução, programas saíam com sucesso sem terminar o trabalho, edições vazias passavam como conserto. Cada um desses buracos precisou de um controle novo, como no @sec-ch06: confiança em teste depende do quanto o dado do teste é real.

### O dicionário que comeu o cérebro

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
O modelo de 239 milhões tinha mais camadas que o de 91, errava menos na adivinhação e resolvia 24 de 100 tarefas de programação. Quando fui ver onde estavam os parâmetros, 154 milhões eram a tabela de vocabulário. Cada uma das 200 mil entradas do vocabulário emprestado guarda uma fileira de 768 números, o endereço daquele pedaço no mapa de sentidos do apêndice, e 200 mil fileiras desse tamanho somam 154 milhões. Sobravam 85 milhões pras camadas que pensam, o [transformer]{.gls}.

![Onde foram parar os parâmetros. A tabela de vocabulário ocupava quase dois terços do modelo de 239 milhões; no de 337 milhões, com um vocabulário próprio e menor, quase tudo foi pras camadas que pensam.](assets/figures/ch13b-parametros.png){#fig-ch13b-parametros fig-alt="Duas barras empilhadas. A primeira, modelo de 239 milhões: 154 milhões na tabela de vocabulário e 85 milhões nas camadas que pensam (transformer). A segunda, modelo de 337 milhões: 33,6 milhões na tabela de vocabulário e 303,6 milhões nas camadas que pensam (transformer)."}

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
O modelo final trocou pro vocabulário próprio de 32 mil entradas, e a tabela de vocabulário encolheu pra 34 milhões. As camadas que pensam ficaram com mais de 300 milhões. Uma ressalva justa: essa virada mudou o vocabulário, o tamanho, o começo do treino e a quantidade de texto de uma vez só, então o relatório não consegue dizer qual dessas mudanças fez a diferença.

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
Teve mais: um treino recomeçado do ponto errado depois de uma manutenção no meu servidor de arquivos, uma placa de vídeo dividida com o navegador, e um caso em que eu disse "terminou" antes de testar o modelo no agente. Esses estão no apêndice técnico.

## O que saiu do outro lado

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
Primeiro, a parte boa: mais estudo ajudou, e dá pra medir. Com o mesmo ajuste curto por cima, a versão que leu 2 bilhões de tokens resolveu 39 das 100 tarefas da prova de escolha; a de 10 bilhões, 65. E a versão final, na prova final, que ela viu uma vez só, acertou 58 de 100. É esse o número que fica.

Tem um detalhe nessa curva que conta mais que os números. Sem nenhum ajuste, só completando o texto do pedido, a versão de 10 bilhões resolveu 8 de 100, e as de 2 e 5 bilhões, zero. Nessa receita, o que mais pesou foi ensinar o formato de pergunta e resposta, o mesmo salto do continuador pro assistente que o @sec-apmecanica descreve. Quanto do saber veio do ajuste e quanto já estava lá, o relatório não consegue separar.

O que ele faz, portanto: escreve uma função Python pequena, com a sintaxe certa e o nome certo, a partir de um pedido claro de uma linha. Mediana, fatorial, conversão pra binário, ano bissexto. Como autocompletar de função isolada, serve pra estudo.

![O abismo entre parecer código e resolver o problema. Escrever Python válido ele faz sempre; agir num repositório e lembrar de um texto longo, nunca.](assets/figures/ch13b-abismo.png){#fig-ch13b-abismo fig-alt="Barras horizontais com os resultados do modelo final. Python válido: 100 de 100. Nome e parâmetros certos: 97 de 100. Resultado correto: 58 de 100. Consertos de repositório no OpenCode: 0 de 4. Achar um número escondido num contexto longo: 0 de 9. As barras encolhem de cima pra baixo até sumir."}

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
Repare na escada. Todas as 100 respostas reservadas eram Python válido, e 97 tinham o nome e os parâmetros pedidos. Das 42 que erraram, 39 pareciam perfeitas e faziam a coisa errada.

Uma função de tirar repetidos usou uma estrutura que não aceita o tipo de dado que o pedido exigia. Uma função de pegar o nome do arquivo num caminho arrancou o último caractere.

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
E tem o que ele zerou. Nos quatro consertos de repositório pelo OpenCode, nenhuma ferramenta foi chamada: em vez de ler, editar e testar o arquivo, ele devolveu texto com código, e numa das tarefas ainda rebatizou a função. Nas nove buscas pelo número escondido em textos longos, três em cada um dos três tamanhos, nove erros, embora o servidor aceitasse textos daquele tamanho sem reclamar. Pedi em inglês uma ideia de café da manhã e recebi um trecho de Python repetindo "oats", aveia, até acabar o espaço.

<!-- src: ref:microgpt/docs/report/experiment-closeout.md -->
O ajuste final só tinha respostas de código, sem conversa e sem uso de ferramenta, e a mania de responder tudo com Python combina com isso. Combinar não prova, e o relatório toma o cuidado de dizer que a causa não foi isolada.

> Python bem escrito e um servidor que aceita texto longo saíram em duas semanas numa placa de jogo. Entender o pedido, usar ferramenta e lembrar do que leu, não.

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
O relatório de fechamento estima o que faltaria pra um agente simples: milhares de exemplos verificados de uso de ferramenta, coleta dos próprios erros do modelo, conversa de volta na mistura, contexto longo de verdade, mais estudo com dados melhores. Dias de engenharia e dezenas de horas de placa em cada passo, sem nenhuma garantia de que um número fixo de horas resolva. Eu parei ali. A distância entre gerar uma função plausível e agir com confiança num repositório ficou medida, e ela é grande.

## Difícil, não feitiçaria

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Com o resultado na mão, volto à pergunta do começo. Construir um modelo de linguagem é coisa de gênio num porão?

Não. Os fundamentos estão publicados, de graça, há anos: os artigos, os acervos de texto, o código de referência. Eu montei o ciclo inteiro em menos de duas semanas, com uma placa de vídeo que se compra em loja.

Sem formação em pesquisa, mas com décadas de programação nas costas, e isso pesou: as duas semanas foram de treino, não de aprender a programar. O que os laboratórios fazem a mais é o mesmo ciclo com mais zeros, mais gente e mais dinheiro, e isso conta muito.

<!-- src: original -->
O dia a dia desse trabalho tem pouco de cinema. É escolher a mistura de dados e esperar 28 horas pra ver os primeiros 2 bilhões de tokens passarem. É ler registro de treino, desconfiar de um número bom demais, rodar a prova de novo, descobrir que o defeito estava no avaliador. É paciência e método, e isso se aprende.

<!-- src: original -->
O que eu não montei foi um modelo útil. Entre a minha função de fatorial e um agente que conserta o seu código existe um oceano de trabalho, e o capítulo inteiro serve pra mostrar o tamanho dele.

> Construir um LLM pequeno é difícil e está ao alcance de quem estudar sério. O obrigatório é suor, sem atalho.

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Se você é estudante de computação, ou quer ser, isto é pra você. Comece pelas 200 linhas do Karpathy, que rodam em qualquer notebook. A lição de menos de um milhão de parâmetros do meu projeto treina num processador comum em menos de um minuto, e o @sec-apestudar sugere como atacar um projeto desses sem deixar a máquina estudar por você. Um passo acima, o nanochat, também do Karpathy, treina um modelo do nível do GPT-2 em poucas horas de placas alugadas, por uns 100 dólares quando saiu [@karpathy2025nanochat].

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
E não precisa ter a placa: os US$ 165 de aluguel da conta acima são caros pra um estudante e baratos perto do que isso ensina.

<!-- src: original -->
Antes, a base: Python firme, um pouco de álgebra linear, estatística e probabilidade, além do que o @sec-apestudar lista. Os livros e vídeos do @sec-apleituras levam você do painel de botões até o código. Conte em anos de estudo, nunca em fins de semana.

<!-- src: original -->
Se você é pai ou mãe, o capítulo serve pra duas conversas. Se o seu filho viu um vídeo sobre superinteligência, conte o que tem lá dentro: números sorteados, ajustados aos poucos pra errar menos a próxima palavra. Eu vi isso acontecer na minha mesa, e em nenhum momento apareceu alguém ali.

E se ele pergunta se vale a pena estudar isso, a resposta curta é sim. As pessoas dos laboratórios leram os mesmos artigos que estão abertos pra qualquer um; a diferença está nos anos de estudo e no acesso a máquina, e máquina pra aprender cabe numa mesa.

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
E se você é gestor, não precisa treinar nada do zero. Treinar do zero foi a regra do meu exercício, e eu escolhi o caminho mais difícil de propósito. Na vida real, existem técnicas bem documentadas pra adaptar um [modelo aberto]{.gls key=modelo-aberto} pronto aos seus dados: o [fine-tuning]{.gls}, que continua o treino com o material da empresa; variantes que treinam só uma fração pequena dos pesos e cabem numa placa só; a [destilação]{.gls key=destilacao}, que ensina um modelo menor a imitar um maior. Partindo de um modelo que já sabe falar, o treino em si leva horas, não semanas; o trabalho de verdade é preparar os exemplos e medir o resultado.

<!-- src: original -->
A decisão difícil pra quem gere é outra: qual tarefa vale especializar, e como você vai medir se ficou bom. O @sec-ch13 mostrou o tamanho disso com os classificadores pequenos.

<!-- src: original -->
E se você não programa nem gere nada, só ouve falar disso no trabalho, o capítulo te dá uma régua. Quando um fornecedor anunciar que "treinou o próprio modelo", faça três perguntas: treinou com quanto texto, contra qual prova foi medido, e alguém de fora conferiu? Você agora sabe que um modelo treinado do zero numa empresa comum se parece muito mais com o meu de 337 milhões do que com o GPT-4, e as perguntas do @sec-apC servem pra separar um do outro.

## O futuro é menor

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Depois de duas semanas olhando pra dentro de um modelo, a minha leitura do mercado ficou mais firme, e ela é uma leitura, com os dados que eu tenho. Os modelos de fronteira, generalistas, vão continuar existindo e continuar caros. Eles tentam saber tudo sobre qualquer coisa, de direito tributário a letra de música, e cada bilhão de parâmetros a mais rende menos do que o anterior.

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Os próprios gigantes já trabalham com uma fração do corpo de cada vez. O gpt-oss-120b, da OpenAI, tem 117 bilhões de parâmetros e usa 5,1 bilhões a cada token [@openai2025gptoss]; o DeepSeek-V3 tem 671 bilhões e acorda 37 [@deepseekai2024v3]. São os [MoE]{.gls key=moe} do @sec-ch13. O nome engana, como o apêndice técnico avisa (@sec-aptecnico-memoria-local): esses blocos não se dividem por assunto, contabilidade num, medicina noutro.

Mas a cada palavra só uma fração pequena do modelo trabalha.

<!-- src: original -->
Vale lembrar quem está fazendo a previsão. Eu já avisei de bolhas com anos de antecedência e errei o calendário mais de uma vez (@sec-apbolhas). O que segue é a direção que os dados de hoje apontam, sem data marcada.

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Agora imagine o contrário: um modelo pequeno, feito de propósito pra um ofício. Um modelo pra escritórios de contabilidade, que conhece o plano de contas, a legislação tributária, os formatos de arquivo da Receita e o jargão, e dispensa o resto. Ele roda no computador do escritório, com os dados do cliente dentro da sala.

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
Isso já existe em outras áreas. O Google publicou o MedGemma, com versão de 4 bilhões de parâmetros, pra saúde [@google2025medgemma]. O SaulLM, de 7 bilhões, foi treinado pra textos jurídicos [@colombo2024saullm]. Pesquisadores da NVIDIA defenderam em 2025 que modelos pequenos bastam pra maior parte do trabalho de um agente, mais baratos e mais adequados, com o modelo grande chamado só quando a conversa pede [@belcak2025small].

<!-- src: 2026/10/14/treinei-meu-proprio-modelo-de-ia-spoiler-e-so-pra-estudo -->
A Apple já roda no próprio aparelho um modelo de uns 3 bilhões de parâmetros, com chamada de ferramenta e pequenos ajustes por tarefa [@apple2025foundation]. Nada disso precisa de um data center pra cada pergunta.

<!-- src: 2026/10/10/qual-modelo-de-decisao-classificador-de-ia-tipo-jev-e-melhor -->
É o mesmo resultado dos [classificadores]{.gls key=classificador} do @sec-ch13: pra uma decisão fechada, um modelo aberto de 4 bilhões empatou com o serviço da OpenAI. Em vez de caber o mundo inteiro num modelo maior, cabe o domínio num modelo menor.

<!-- src: 2026/10/12/llms-agentes-competente-o-suficiente -->
O que tornou isso viável foi o agente. Um modelo especializado de 2023, como o BloombergGPT pras finanças [@wu2023bloomberggpt], precisava saber tudo de cor, porque a única coisa que ele fazia era completar texto. Um modelo de 2026 dentro de um [harness]{.gls} busca o que falta na hora: a lei que acabou de mudar, o documento do cliente, a tabela que ele nunca viu. É a mesma ideia do @sec-ch20, de que o ganho recente veio menos do modelo cru e mais do que se constrói em volta dele.

<!-- src: original -->
O meu modelo de 337 milhões me mostrou o tamanho do "basta" nessa frase. Ele sabe a sintaxe e o nome das coisas. Falta exatamente o que separa um gerador de texto de um agente: entender o pedido, usar ferramenta, lembrar. Isso ninguém treina em duas semanas numa placa de jogo.

Pela régua que eu tenho hoje, e é uma expectativa, não uma medida, isso se treina em meses, em data center, com trilhões de tokens, e depois se especializa.

<!-- src: original -->
E aí está o outro lado da conta. O meu modelo custou uns 80 reais e não esconde nada: o relatório diz o que ele faz e o que ele zera. Quem gasta centenas de milhões de dólares num modelo de fronteira precisa de uma história à altura do gasto, e o próximo capítulo é sobre essas histórias.
