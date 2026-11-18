---
id: apmemoria
chapter: "ai-memory: a memória que é sua"
sources:
  - {post: 2026/05/18/como-memoria-de-agentes-funciona-e-como-melhorar, sha256: "f4efb1344b38638f025ff0b617ac8ff0311ed4b0adaabf7b6ae8ed13a08526e8"}
  - {post: 2026/05/23/criei-sistema-memoria-agentes-codigo-ai-memory, sha256: "2a5277bea57d0bf92a002a4cee03ff4346308f18b1e8f06c018e874bfd8ce14a"}
  - {post: 2026/06/14/ai-memory-arquitetura-emergente-e-software-maleavel, sha256: "247f115ca025919eceb5edf4563a6ce71bc4e6747293dc33c7702dce92c0b3a4"}
  - {post: 2026/06/16/ai-memory-memoria-longo-prazo-karpathy-wiki-auto-aprendizado-hermes-projetos, sha256: "7b25cc52f03575fd6c68f40e1985b7b1708cba9be353e973256adcca2540cd2b"}
  - {post: 2026/07/20/novidades-no-meu-ai-memory-cada-vez-melhor-pra-usar-com-suas-ias, sha256: "daafe1a63fd8b3f44a5fdf0f302047fdd438903451950a999c5ffd47def491e3"}
  - {post: 2026/09/02/ai-memory-2-0-melhor-sistema-memoria-agentes-e-times, sha256: "be2e1bb212c22cd90673fefb8978f21bebc8894fdda4181a7104b2b1e5b66691"}
refs_projects:
  - "ai-memory/README.md"
  - "ai-memory/CHANGELOG.md"
  - "ai-memory/docs/install.md"
  - "ai-memory/docs/local-embeddings.md"
  - "ai-memory/docs/cross-project-profile.md"
blog_commit: "b9c029231693369b8f895576b491c878aea3e8da"
---

# ai-memory: a memória que é sua {#sec-apmemoria}

<!-- src: 2026/05/23/criei-sistema-memoria-agentes-codigo-ai-memory -->
Uma cena que se repetiu o ano inteiro no meu computador. O Claude Code empaca num defeito depois de uma hora de conversa. Eu fecho, abro o Codex na mesma pasta pra ver o problema por outro ângulo e, antes de ele ajudar em qualquer coisa, passo um bom tempo explicando de novo o projeto, o que a gente já tentou e o que deu errado.

<!-- src: 2026/06/16/ai-memory-memoria-longo-prazo-karpathy-wiki-auto-aprendizado-hermes-projetos -->
Nessa hora, quem guarda o contexto sou eu. O programador vira o cache do agente, a memória rápida que ele consulta porque não tem a dele.

Este apêndice é sobre a ferramenta que eu escrevi pra parar de fazer isso, o ai-memory [@akita2026aimemory; @aimemory2026site]. O kit de segurança de @sec-apB já mostrou a ideia em poucas linhas, como a sexta peça. Aqui vai a versão completa: por que vale a pena, o que ela faz, quando você não precisa dela e como começar.

## Por que memória importa

<!-- src: 2026/06/16/ai-memory-memoria-longo-prazo-karpathy-wiki-auto-aprendizado-hermes-projetos -->
Você já conhece o peixinho de @sec-ch02. O modelo não lembra de nada entre uma conversa e outra, a mesa de trabalho começa vazia a cada sessão, e quando ela enche no meio do caminho a [compactação]{.gls key=compactacao} troca o começo da conversa por um resumo que perde detalhe. Uma [janela de contexto]{.gls key=janela-de-contexto} enorme não muda isso: ela é grande, mas pertence só à sessão atual.

O que se perde é justamente a parte cara do trabalho. O código mostra o que sobreviveu. A sessão guarda o resto: o experimento que falhou, o defeito que só aparecia de vez em quando, o motivo de a gente ter mudado de ideia depois de três horas. Fechou o agente, isso some.

<!-- src: 2026/05/18/como-memoria-de-agentes-funciona-e-como-melhorar -->
No @sec-ch02 eu também mostrei o remédio caseiro, que continua valendo: memória de agente é texto, e você pode escrever os seus próprios bilhetes numa pasta de documentos do projeto. O defeito do remédio é a disciplina. Pra manter esses bilhetes em dia, eu ainda tenho que lembrar de pedir e conferir, toda vez, inclusive nos dias em que estou cansado.

### O cadeado do fornecedor

<!-- src: ref:ai-memory/README.md -->
Os agentes grandes perceberam o problema e vêm ganhando funções de memória. O Claude Code faz as próprias anotações, o Cursor lembra de algumas coisas, e cada plataforma acrescenta mais um pouco a cada versão. Todas esbarram nos mesmos limites: as notas moram numa máquina só, pertencem a um agente só e saem de vista quando você troca de ferramenta ou passa o trabalho pra um colega.

<!-- src: 2026/07/20/novidades-no-meu-ai-memory-cada-vez-melhor-pra-usar-com-suas-ias -->
No @sec-ch20 eu contei por que isso me incomoda: se a memória do projeto mora dentro da ferramenta de uma empresa, trocar de ferramenta vira mudança de casa, e quanto mais tempo você fica, mais pesada fica a mudança.

<!-- src: 2026/05/18/como-memoria-de-agentes-funciona-e-como-melhorar -->
As notas dessas ferramentas são texto, como o @sec-ch02 mostrou, então em tese dá pra levar. Na prática, cada uma guarda num lugar, num formato e numa máquina diferentes, e ninguém carrega a mudança por você.

> A sessão de um agente é a parte mais cara do trabalho, e ela pertence a quem trabalhou, seja qual for a ferramenta que a gravou.

## O que é o ai-memory

<!-- src: ref:ai-memory/README.md -->
O ai-memory é uma memória de longo prazo pra agentes de programação, de [código aberto]{.gls key=codigo-aberto}, distribuída como um [binário]{.gls key=binario} só, um programa único que não depende de outros serviços pra rodar. A promessa é que a sessão seguinte, em qualquer agente compatível, continue de onde a anterior parou, sem você explicar de novo a arquitetura, as tentativas que falharam e as perguntas em aberto.

<!-- src: 2026/06/14/ai-memory-arquitetura-emergente-e-software-maleavel -->
A origem do projeto, de maio de 2026, está contada no @sec-ch20. Começou como uma versão pra um usuário, numa máquina, num sistema operacional, e cresceu com gente de fora usando e mandando correção. Em 13 de outubro de 2026, saiu a versão 3.0.

### Como funciona

<!-- src: ref:ai-memory/README.md -->
O ciclo tem quatro tempos:

- **captura**: [hooks]{.gls key=hook}, pequenos ganchos que o próprio agente dispara a cada evento, registram em silêncio o que acontece na sessão (pedidos, comandos usados, começo e fim), e um filtro tira dados sensíveis antes de qualquer coisa ser guardada;
- **consolidação**: no fim da sessão, esse registro vira páginas legíveis numa wiki do projeto, no espírito da LLM Wiki de Karpathy que apareceu no @sec-ch02;
- **consulta**: a sessão seguinte, em qualquer agente compatível e em qualquer máquina, começa com um resumo curto e pode buscar no resto;
- **passagem de turno**: um agente deixa pro próximo um bilhete formal dizendo o que foi feito, o que falhou e o que ficou aberto.

<!-- src: 2026/06/16/ai-memory-memoria-longo-prazo-karpathy-wiki-auto-aprendizado-hermes-projetos -->
O agente conversa com a memória pelo [MCP]{.gls}, a tomada padrão que liga ferramentas a agentes. Na prática, você pergunta "a gente já discutiu isso?" e ele vai buscar, sem você precisar saber onde a página está.

### O que ele faz em outubro de 2026

<!-- src: ref:ai-memory/README.md -->
A lista de funções cresceu bastante desde maio. As que mais importam pra quem está chegando:

- **acompanha você entre agentes**: mais de vinte [harnesses]{.gls key=harness}, de Claude Code, Codex, Cursor, Gemini CLI e OpenCode a outros menos conhecidos, alimentam a mesma memória;
- **acompanha você entre máquinas**: a memória mora num servidor que é seu, no próprio computador ou numa máquina de casa, então o projeto que você largou no desktop é o mesmo que você retoma no notebook;
- **funciona pra uma equipe**: todo mundo aponta pro mesmo servidor, o que a sessão de um aprende o agente do outro encontra, e cada escrita registra quem fez;
- **guarda tudo em [Markdown]{.gls key=markdown}**: a memória é uma pasta de arquivos de texto comuns, versionada com Git, e o banco de dados é só um índice que se reconstrói a partir deles;
- **leva os seus hábitos de um projeto pro outro**: um perfil curto do seu jeito de trabalhar, como o gerenciador de pacotes e a organização dos testes, chega a cada repositório novo como sugestão padrão, abaixo das regras do próprio projeto.

<!-- src: 2026/09/02/ai-memory-2-0-melhor-sistema-memoria-agentes-e-times -->
Desde a 2.0, cada página segue o Open Knowledge Format, um formato aberto que outras ferramentas leem. Dá pra abrir a pasta no Obsidian, procurar com [grep]{.gls}, editar à mão ou entregar o pacote pra um colega que usa outra coisa. Foi a mudança da 2.0 que mais me agradou, porque coloca por escrito a tese do projeto: a memória não fica refém nem do meu programa.

<!-- src: ref:ai-memory/docs/local-embeddings.md -->
A busca combina a palavra literal com o significado. Desde a 2.0, o programa baixa sozinho, na primeira vez que roda, um modelo pequeno de [embeddings]{.gls key=embedding} que roda no próprio computador, sem chave de API e sem mandar nada pra fora. Assim uma pergunta sobre "como a gente publica" acha a página que fala em "procedimento de release", mesmo sem palavra em comum.

### O que ele faz sem pedir nada a ninguém

<!-- src: ref:ai-memory/README.md -->
O caminho padrão não chama modelo de linguagem nenhum. Captura, busca e passagem de turno funcionam sem chave de API e sem custo por uso. Com um modelo configurado, os resumos de sessão ficam melhores, mas é opcional.

A memória também envelhece, e o que você usa envelhece mais devagar: abrir uma página, achar ela numa busca ou chegar nela por um link conta como uso. Esse reforço vem sempre ligado, porque ele só segura a memória por mais tempo. E nada é apagado de vez: a versão antiga continua no histórico do Git e dá pra trazer de volta.

As funções que reescrevem ou descartam conteúdo vêm desligadas. A mais curiosa é um "sonho", parecido com o do Claude Code que o @sec-ch02 descreveu: com um modelo configurado, enquanto você não está trabalhando, um processo reescreve grupos de notas antigas numa página só e para assim que você volta.

<!-- src: 2026/06/16/ai-memory-memoria-longo-prazo-karpathy-wiki-auto-aprendizado-hermes-projetos -->
A cautela tem motivo. Memória ruim é pior do que memória nenhuma, porque o agente sem memória pergunta e o agente com memória errada age com certeza falsa.

### Pra quem pula de agente, e pra equipes

<!-- src: 2026/07/20/novidades-no-meu-ai-memory-cada-vez-melhor-pra-usar-com-suas-ias -->
A passagem de turno é um resumo, e todo resumo perde alguma coisa. Pra quem troca de agente o tempo todo, como eu, existe um modo gerenciado: em vez de abrir o agente direto, você abre por um comando do ai-memory. Ele liga as sessões de cada agente a uma linha de trabalho comum, e quando você volta pro Claude Code depois de uma hora no Codex, o Claude retoma a própria sessão e recebe só o que aconteceu nos outros enquanto isso.

<!-- src: 2026/09/02/ai-memory-2-0-melhor-sistema-memoria-agentes-e-times -->
E a passagem de turno tem dono. Num servidor compartilhado, as páginas são de todos, mas o bilhete que você deixou pendente é seu: exatamente uma sessão pega o bastão, e o agente de um colega não consome o seu por engano.

## Quando vale a pena, e quando não

<!-- src: 2026/05/23/criei-sistema-memoria-agentes-codigo-ai-memory -->
Se você usa um agente só, num computador só, e fica nele, talvez não precise de nada disso. A compactação do próprio agente mais uma pasta de documentos bem cuidada, como no @sec-ch02 e na peça 6 de @sec-apB, resolvem o essencial.

<!-- src: ref:ai-memory/README.md -->
O ai-memory começa a pagar o investimento em quatro situações:

- você troca de agente no meio de um projeto, por cota, por preço ou porque um deles empacou;
- você trabalha no mesmo projeto em mais de uma máquina;
- você volta a um projeto depois de semanas e não lembra onde parou;
- você trabalha em equipe e quer que o que um aprendeu chegue ao agente do outro.

<!-- src: 2026/07/20/novidades-no-meu-ai-memory-cada-vez-melhor-pra-usar-com-suas-ias -->
Ele também não substitui os documentos do projeto. A memória automática guarda o que talvez importe depois; decisão, regra e procedimento que precisam durar meses continuam merecendo um documento revisado por você, dentro do repositório. Sessão bruta é evidência. Documento é conhecimento organizado.

<!-- src: ref:ai-memory/README.md -->
E tem custo. É mais um programa rodando no seu computador, com um servidor que precisa estar de pé quando o agente começa. Ele grava o que acontece nas suas sessões, filtrado, mas grava, então vale saber onde a pasta de dados mora e fazer backup dela como de qualquer coisa importante. Na configuração inicial, o servidor só aceita conexões do próprio computador e já vem com senha; antes de abrir pra uma rede ou pra uma equipe, leia a parte de autenticação da documentação.

> Uma memória automática economiza a explicação repetida. A decisão importante continua merecendo um documento que você revisou.

## Pra começar

<!-- src: ref:ai-memory/README.md -->
O caminho mais curto, com a versão 3.0 de outubro de 2026, são dois comandos num terminal de Linux ou macOS:

```bash
curl -fsSL https://github.com/akitaonrails/ai-memory/releases/latest/download/install.sh | sh
ai-memory setup
```

<!-- src: ref:ai-memory/README.md -->
O primeiro baixa o programa certo pro seu sistema, confere se o arquivo chegou íntegro comparando com a soma de verificação publicada, e só instala se ela bater. O segundo cria a pasta de dados com uma senha guardada num arquivo que só você lê, deixa o servidor rodando como um serviço do seu usuário e liga o ai-memory a cada agente que encontrar no computador. Ele mostra o plano e pergunta antes de mexer em qualquer coisa. Depois, reinicie os agentes.

Quem usa Claude Code ou Codex também pode ligar a memória ao agente por um plugin, pelo próprio sistema de extensões de cada um; o programa continua sendo instalado do mesmo jeito.

<!-- src: ref:ai-memory/README.md -->
A partir daí, você conversa com o agente normalmente. Pergunte "onde a gente parou?" pra retomar uma passagem de turno, "a gente já discutiu isso?" pra ele buscar na memória, ou "me atualiza" pra um resumo do que aconteceu no projeto. Num projeto antigo, com meses de histórico, o comando `ai-memory bootstrap`, rodado uma vez, aproveita o que já existe.

<!-- src: original -->
Esses dois comandos são um retrato de outubro de 2026. Existem caminhos pra Docker, pacotes pra Arch Linux e Fedora, um aplicativo de barra de menu pro macOS e um modo pra Windows, e todos mudam de versão em versão. As instruções atualizadas, em português inclusive, ficam no site do projeto, aimemory.sh [@aimemory2026site]. Comece por lá.

<!-- src: 2026/09/02/ai-memory-2-0-melhor-sistema-memoria-agentes-e-times -->
Você não precisa do meu programa pra seguir o princípio. Pode ser ele, pode ser outro, pode ser uma pasta de arquivos de texto mantida na mão. O que importa é que a memória do projeto more num lugar seu, num formato que você lê, e que sobreviva à troca de agente, de máquina e de empresa. É a mesma conta de @sec-ch20: o modelo se aluga de quem estiver melhor no mês, e a memória fica com você.
