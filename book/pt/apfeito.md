---
id: apfeito
chapter: "Este livro foi escrito por IA?"
sources:
  - {post: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente, sha256: "0d435e79de9e1f54ea1807e862f303e235607474050bc7b2e85f0a8ed71ba55d"}
refs_projects: []
blog_commit: "956fc9ed1cc8e32f61deeef64518eece134fd510"
---

# Este livro foi escrito por IA? {#sec-apfeito}

<!-- src: original -->
É a pergunta mais óbvia sobre um livro como este, e logo atrás dela vêm outras duas: se foi tão fácil quanto parece, e se o resultado não passa de texto gerado em série, sem dono.

O passo a passo de como o livro foi montado está no posfácio (@sec-posfacio), e eu não vou repetir aqui. Este apêndice responde às três perguntas de forma direta, e depois diz o que eu acho que este livro mostra sobre trabalhar com IA.

## Sim e não

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
Sim: boa parte do texto que você leu saiu primeiro de agentes de IA. Eles leram os 131 textos que eu publiquei no blog em 2026, preencheram uma ficha pra cada um, escreveram o rascunho dos capítulos, traduziram o livro pro inglês, conferiram fatos e leram o livro inteiro fazendo papel de leitor. O rascunho deste apêndice também saiu de um agente, a partir do texto em que eu contei no blog como o livro foi feito.

<!-- src: original -->
Não: a matéria-prima é minha. Cada experiência que o livro conta eu vivi, e cada medição eu fiz, ao longo de oito meses, com bilhões de tokens gastos e centenas de horas de trabalho. As opiniões são as que eu escrevi durante o ano. Nenhuma foi inventada pra preencher capítulo.

E as decisões também são minhas: a estrutura em cinco partes, o que entra e o que sai, as regras a que o texto tem que obedecer, o que fazer quando dois posts meus discordam, e a palavra final sobre cada capítulo. Os agentes digitaram. Eu decidi o que eles iam digitar e o que ia pro lixo.

## Dois prompts e pronto?

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
Não. Fazer um livro com IA está longe de ser um pedido de "escreva um livro pra mim". Eu tive que inventar o processo inteiro e pilotar os agentes pra montar cada peça dele: a consolidação dos posts, a estratégia narrativa, o que fica e o que sai, a revisão de texto, a checagem de fatos, o lançamento de cada versão.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
O primeiro rascunho de todos os capítulos ficou pronto no mesmo dia em que o repositório do livro nasceu, 13 de outubro. Esse é o pedaço rápido. Pra dar uma ideia do resto, alguns números:

- quase meio milhão de palavras de blog na entrada, 96 textos sobre IA, e cada texto deixado de fora com o motivo anotado;
- uma revisão de texto completa em cada língua, além da conferência de fatos;
- três rodadas de leitura com cinco leitores simulados, cada um com nome, profissão e o medo que o trouxe ao livro, e mais uma leitura, só nos capítulos que ganharam a minha história de antes de 2026;
- mais de 140 afirmações tiradas dos meus vídeos antigos conferidas antes de qualquer uma entrar no livro;
- quase 170 testes automáticos só pras ferramentas que montam e conferem o livro.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
O primeiro resultado várias vezes não prestou. Na primeira rodada, os leitores simulados apontaram 73 falhas de lógica.

A conclusão de @sec-ch20 ia além do que o meu teste conseguia medir. Um capítulo argumentava de um jeito que nunca perde, pondo toda falha do agente na conta do pedido. Quatro dos cinco leitores foram mandados pro capítulo errado pelo guia de leitura.

Na segunda rodada, uma frase de desculpa posta ao lado de uma contradição fez os cinco notarem a contradição que antes três tinham deixado passar. Cada falha dessas virou uma regra escrita, e as rodadas só pararam quando os problemas apontados deixaram de voltar: 73 anotações de lógica na primeira, 53 na segunda, 51 na terceira.

<!-- src: original -->
Os rascunhos de 13 de outubro são os primeiros dez por cento de @sec-ch05: impressionam e quase não dizem nada sobre o resto. Tudo o que vem depois é leitura, corte e correção.

## É só slop?

<!-- src: original -->
Slop é o volume sem cuidado de @sec-ch10: texto que ocupa espaço e não responde por nada. A diferença que eu consigo mostrar está em três coisas que você pode conferir.

A primeira é a origem. Cada parágrafo do livro, no arquivo de onde ele sai, traz uma marca dizendo de qual post veio ou se foi escrito pro livro, e cada referência de fora está na bibliografia. O posfácio explica como isso funciona.

A segunda é a conferência. Cada número, data e nome foi checado contra os meus posts, contra os projetos de onde os dados saíram e contra fontes primárias. Quando o resumo de um agente e o post discordavam, valia o post.

<!-- src: 2026/10/13/auto-publiquei-meu-proprio-livro-ebook-competente-o-suficiente -->
A terceira é que a conferência corrigiu a mim também. Em junho eu escrevi no blog que um modelo custava dez vezes mais que outro; refeitas as contas, era quase o dobro, e o livro conta o erro e a correção. Num post de fevereiro eu datei a bolha de contratação em 2014; ela começou por volta de 2010, com o juro perto de zero. O posfácio lista outras correções desse tipo, e boa parte delas é do meu próprio blog.

<!-- src: original -->
E o que ainda pode estar errado? Boa parte da conferência foi feita por agentes, e o próprio livro mostra em @sec-ch04 e @sec-ch15 que máquina inventa fato e que auditoria feita por IA deixa coisa passar. Eu li e aprovei cada capítulo, e ainda assim vai ter erro.

O livro é público, e quem achar um pode abrir uma issue no repositório dele no GitHub. A marca de origem existe pra que a correção chegue ao parágrafo certo.

> "Foi feito com IA" diz muito pouco, como eu argumento em @sec-ch16. O que diz alguma coisa é quem conferiu, contra o quê, e o que fez quando achou erro.

## O que só a experiência entrega

<!-- src: original -->
Agora a parte que eu queria deixar registrada, e é opinião minha, apoiada num caso só: este livro, somado aos projetos do ano. A IA ajuda muito quem sabe exatamente o que quer. Um produto completo, do tipo que outra pessoa pode usar e confiar, eu só vi sair das mãos de quem já sabia fazer aquilo sem ela.

Um livro é um produto, e este foi tratado como um. Ele tem uma especificação: a estrutura inteira escrita num lugar só, com o que cada capítulo responde e de quais posts sai. Tem testes: verificações automáticas que impedem a montagem do livro quando uma referência aponta pro nada, quando um número aparece diferente em dois capítulos ou quando um parágrafo perde a origem. Tem revisões, versões numeradas e um registro público do que mudou em cada uma.

<!-- src: original -->
Nada disso é novidade, e esse é o ponto. É a mesma rede de segurança de @sec-ch19, testes, integração contínua, revisão desconfiada, voltar atrás rápido, aplicada a texto. É o que fez a newsletter de @sec-ch06 ir pro ar em menos de uma semana e continuar funcionando. É o que fez o editor de @sec-ch05 sair em umas 30 horas onde eu, sozinho, levaria umas 200: eu sabia o que um editor precisava ter e onde ele costuma quebrar.

<!-- src: original -->
Os agentes não tomaram nenhuma das decisões abaixo, e cada uma está registrada no repositório.

Uma seção inteira, já escrita e revisada, saiu do livro e ficou guardada porque a verificação ainda estava pendente. Quando os leitores simulados se perderam no detalhe técnico, umas 8 mil palavras saíram dos capítulos e foram pra um apêndice próprio, pra quem programa.

Quando dois números meus discordavam, a regra foi descobrir por quê e dizer o escopo de cada um, em vez de escolher o mais bonito. Linhas que os leitores leram como exibição saíram. E a versão fácil, publicar os rascunhos de 13 de outubro, foi recusada.

<!-- src: original -->
Saber o que decidir não veio de 2026. Em 2019 eu gravei um vídeo chamado "Não terceirize suas decisões" [@akitando063]. Em outubro de 2022, um mês antes do ChatGPT, eu defendia no canal testes, integração contínua e estimativa como ordem de grandeza [@akitando130].

Também errei previsões nesse período, e @sec-ch18 conta uma delas. O que este livro aproveitou foram as práticas, que eu tinha testado por anos antes de pôr um agente pra executá-las.

<!-- src: original -->
É isso que @sec-ch18 chama de senioridade: decidir e responder pela decisão. Os agentes foram competentes o suficiente pra escrever, traduzir e conferir. Saber o que pedir, o que aceitar e o que jogar fora continuou sendo trabalho de quem fez isso por décadas.

<!-- src: original -->
E vale aqui a pergunta que @sec-ch14 manda fazer a qualquer anúncio: quem ganha se você acreditar? Eu ganho, porque o livro é meu. Então não acredite só na minha palavra.

As fontes estão listadas, cada parágrafo sabe de onde veio, e o repositório é público. Abra, confira, e se achar onde eu errei, me conte.
