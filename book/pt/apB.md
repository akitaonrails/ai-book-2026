---
id: apB
chapter: "Kit mínimo para usar agentes com segurança"
sources:
  - {post: 2026/03/01/ai-jail-sandbox-para-agentes-de-ia-de-shell-script-a-ferramenta-real, sha256: "9f3b13a3c124f69e6a832ef5d6b8e4218d7dab134f639e8bad41c70580feebbb"}
  - {post: 2026/04/09/20-anos-de-blog-o-ano-em-que-a-ia-finalmente-me-deixou-traduzir-tudo, sha256: "247ad116f3c45c935f8a59156a72b8852733e259c70b65044f19fb56c6d32f3b"}
  - {post: 2026/05/18/como-memoria-de-agentes-funciona-e-como-melhorar, sha256: "f4efb1344b38638f025ff0b617ac8ff0311ed4b0adaabf7b6ae8ed13a08526e8"}
  - {post: 2026/05/23/criei-sistema-memoria-agentes-codigo-ai-memory, sha256: "2a5277bea57d0bf92a002a4cee03ff4346308f18b1e8f06c018e874bfd8ce14a"}
  - {post: 2026/05/24/criei-widget-waybar-omarchy-monitorar-uso-llms-ai-usagebar, sha256: "cbd63fc0c5ed86a201d6420d5e1cbaf04f067b13677e6f312eb5fe1e55f1f68b"}
  - {post: 2026/05/24/dicas-e-toolkit-de-ia-do-akita-ai-jail-ai-memory-ai-usagebar, sha256: "c034c8d6f4ad01f1cb2a7189dba567aad28f547cd135a5104a48fdf97c5a88dc"}
  - {post: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas, sha256: "c1c7d372d1654932a63455ef8c205e83209a4d5e9a2d6cf037ce6dae97aee041"}
  - {post: 2026/07/25/ai-jail-update-seguranca-docker-opt-in, sha256: "dc064ef739ebe8a36ccc90a6749dddf3017098c85f4ad1162be4a6d6f1cd6375"}
  - {post: 2026/10/06/desastre-no-meu-nas-como-quase-perdi-90-tb-de-dados, sha256: "0feadb627f15c5bd325c7ac8d2e0c67519e86987a51e7645b5d46bf4674b3cab"}
refs_projects:
  - "ai-jail/README.md"
  - "ai-jail/src/cli.rs"
  - "ai-jail/src/bootstrap.rs"
  - "ai-memory/README.md"
  - "ai-usagebar/README.md"
blog_commit: "cc8b467dd4d6d3b5c57fad6bb6fae70ec5839a01"
---

# Kit mínimo para usar agentes com segurança {#sec-apB}

<!-- src: original -->
Este apêndice junta a parte prática que eu tirei dos capítulos pra não quebrar a história. No @sec-ch15 você viu por que um [agente]{.gls} de IA merece o tratamento de um estagiário com a senha de administrador. No @sec-ch02 viu por que ele esquece o que vocês combinaram uma hora antes. Aqui fica o que fazer a respeito, na ordem em que eu montaria a casa de alguém que está começando.

Passo a passo de instalação ficou de fora de propósito. Ferramenta muda de versão, de nome e de dono, e um passo a passo copiado hoje estaria errado em seis meses. O que dura é a função de cada peça: pra que ela serve, o que ela precisa garantir e como conferir se está funcionando. Os poucos comandos que aparecem estão aí pra mostrar o tamanho da coisa, e cada um vem explicado.

<!-- src: original -->
A primeira parte vale pra qualquer ferramenta e qualquer sistema. A segunda mostra, como exemplo, as três ferramentas de código aberto que eu escrevi em 2026 pra resolver esses problemas no meu próprio computador. Qualquer ferramenta que cumpra a mesma função serve.

## As sete peças

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
Cada peça cobre o buraco que a anterior deixa passar. Nenhuma, sozinha, resolve tudo:

1. uma jaula, que limita o que o agente enxerga e altera;
2. snapshots, o botão de desfazer do erro de minutos atrás;
3. um backup externo, a cópia que sobrevive ao disco morto;
4. uma lista de permissões, que separa o que o agente faz sozinho do que ele precisa pedir;
5. a regra de que agente não mexe em produção;
6. notas de memória, pra que o trabalho não evapore quando a sessão acaba;
7. um olho nos limites de uso, pra você não ficar sem agente no meio de uma tarefa grande.

As cinco primeiras protegem as suas coisas. As duas últimas protegem o seu trabalho.

## 1. A jaula

<!-- src: 2026/03/01/ai-jail-sandbox-para-agentes-de-ia-de-shell-script-a-ferramenta-real -->
Uma [sandbox]{.gls} é um ambiente isolado em que o programa só vê e só altera o que você permitiu (o @sec-ch15 explica a ideia com calma). Pra um agente de programação, a jaula mínima precisa garantir quatro coisas:

- a pasta do projeto é gravável; o resto da sua pasta pessoal aparece vazio ou nem aparece, com exceções declaradas pra áreas como as credenciais do próprio agente;
- as pastas sensíveis ficam de fora: chaves de acesso a servidores, credenciais de nuvem, perfis do navegador com senhas salvas;
- a rede vem desligada ou filtrada, liberando só o necessário pro agente conversar com o modelo e baixar bibliotecas;
- nada de atalho pra programas que rodam como [root]{.gls}, o administrador do sistema.

<!-- src: 2026/07/25/ai-jail-update-seguranca-docker-opt-in -->
O último item parece detalhe e foi o furo que mais me ensinou no ano. O Docker, a ferramenta de [contêineres]{.gls key=conteiner} que todo agente adora usar, atende os pedidos por um programa que roda como root, fora da jaula. Liberar o acesso a ele é o mesmo que entregar a chave da casa (a história está no @sec-ch15). Se você precisa dele dentro da jaula, ligue só naquela sessão, sabendo o que está liberando.

### Como montar, em cada sistema

<!-- src: 2026/03/01/ai-jail-sandbox-para-agentes-de-ia-de-shell-script-a-ferramenta-real -->
No Linux, a peça básica é o bubblewrap, o mesmo isolador que o Flatpak usa pros aplicativos instalados por ele. Ele monta pro programa uma visão falsa do sistema, com as pastas que você escolher. Em cima dele dá pra escrever um script próprio, que foi como eu comecei, ou usar uma ferramenta pronta.

No macOS, o sistema tem um mecanismo de isolamento embutido, o `sandbox-exec`, que a Apple marca como obsoleto, mas continua funcionando. É menos flexível do que o do Linux, e algumas proteções funcionam só pela metade.

<!-- src: ref:ai-jail/README.md -->
No Windows, o caminho mais simples é rodar o agente dentro do WSL2, o Linux que a Microsoft embute no sistema, e usar as ferramentas do Linux lá dentro. É o que a documentação do ai-jail, a minha jaula, manda fazer [@akita2026aijail; @aijail2026site].

<!-- src: 2026/03/01/ai-jail-sandbox-para-agentes-de-ia-de-shell-script-a-ferramenta-real -->
Os agentes grandes também trazem uma sandbox própria, configurável nas opções de cada um. Vale ligar. Só lembre que ela protege apenas aquele agente, e que o dia em que você trocar de ferramenta, a proteção não vai junto.

<!-- src: ref:ai-jail/README.md -->
E tem um limite que nenhuma dessas jaulas cruza. Elas existem pra conter os erros de um programa em que você confia, mas que é falível. Pra rodar código de origem duvidosa, que pode estar tentando fugir de propósito, a resposta é uma [máquina virtual]{.gls key=maquina-virtual} descartável, um computador inteiro simulado que você joga fora depois.

### O Git como rede

<!-- src: 2026/03/01/ai-jail-sandbox-para-agentes-de-ia-de-shell-script-a-ferramenta-real -->
Se você programa, já tem uma rede de segurança e talvez não use direito. Com o projeto num repositório remoto e o agente proibido de enviar coisas pra lá sem a sua aprovação, o pior que ele consegue é estragar a cópia local. Aí você volta ao último [commit]{.gls} ou apaga a pasta e baixa de novo.

A regra prática é simples: faça commits pequenos e frequentes, mantenha uma cópia remota e deixe o envio pro remoto sempre na sua mão.

## 2. O botão de desfazer

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
Um [snapshot]{.gls} congela o estado do disco num instante. Nos sistemas de arquivos com [copy-on-write]{.gls key=copy-on-write}, ele sai instantâneo e quase de graça, porque só o que muda dali pra frente ocupa espaço novo (@sec-ch15 conta como isso salvou onze álbuns meus). Dá pra abrir o snapshot das duas da tarde como uma pasta qualquer e copiar de volta o projeto que o agente apagou às três.

O que você precisa garantir é pouco. Snapshots automáticos, pelo menos de hora em hora durante o dia, e uma regra de quantos guardar por hora, por dia, por semana e por mês. E saber onde clicar pra recuperar um arquivo antes de precisar.

### Linux

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
O sistema de arquivos, a forma como o disco organiza os dados, precisa suportar snapshots. O mais comum em computador de mesa é o Btrfs, que várias distribuições já oferecem na instalação. Pra agendar, as duas ferramentas clássicas são o Timeshift, com interface gráfica e um painel onde você marca quantos snapshots manter, e o snapper, mais detalhado, que tira snapshot antes e depois de cada instalação de pacote.

Eu uso o Timeshift agendado e, antes de uma sessão que me deixa desconfiado, tiro um na mão:

```bash
sudo timeshift --create --comments "antes de soltar o agente"
```

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
Tem um complemento que vale ouro no dia em que o sistema nem liga mais: o grub-btrfs, que coloca cada snapshot como opção no menu de inicialização [@antynea2026grubbtrfs]. Você escolhe o snapshot da véspera, entra nele e manda restaurar. Foi uma variação disso, num sistema construído em cima de snapshots, que me poupou uma reinstalação no meio da crise do NAS (@sec-ch15).

### macOS

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
O sistema de arquivos padrão do Mac, o APFS, também é copy-on-write e também tem snapshots leves. Com o Time Machine ligado, o próprio macOS tira snapshots locais de hora em hora e guarda as últimas 24 horas no disco interno, mesmo sem nenhum disco externo plugado. Pra tirar um na mão antes de uma sessão arriscada, basta um comando no Terminal:

```bash
tmutil localsnapshot
```

A recuperação é pelo próprio Time Machine, que navega pelos snapshots locais e restaura o arquivo escolhido.

### Windows

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
Aqui a história é mais fraca. O Windows tem as cópias de sombra, que alimentam os pontos de restauração e a aba "Versões anteriores" das pastas, mas elas foram pensadas pros arquivos do sistema e raramente cobrem os seus dados na hora em que você precisa. Se você usa agente no Windows, trate a próxima peça como obrigatória.

O snapshot resolve o acidente de minutos atrás, em segundos. Ele mora no mesmo disco dos seus dados e morre junto com ele.

## 3. A cópia que mora em outro lugar

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
Um [backup]{.gls} externo é uma cópia num aparelho separado: um HD externo, um NAS (o armazenamento ligado à rede da sua casa), um serviço de nuvem. Ele cobre o que o snapshot não cobre, do disco que morreu ao computador roubado. Um bom backup tem quatro propriedades:

- roda sozinho, numa agenda, sem depender de você lembrar;
- guarda várias versões, com uma política de retenção que diz quantas manter;
- é criptografado, pra que perder o HD não signifique entregar os seus dados;
- é testado de vez em quando, abrindo arquivos restaurados de verdade.

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
No meu computador de mesa, quem faz isso é o restic, um programa de backup de código aberto que roda em Linux, macOS e Windows [@restic2026]. Ele guarda só o que mudou desde a cópia anterior, criptografa tudo e restaura com um comando. Um agendador dispara a cópia toda madrugada, às três da manhã, pro meu NAS.

A política de retenção é a parte que quase todo mundo esquece. A minha mantém sete cópias diárias, quatro semanais, seis mensais e uma anual, e cabe numa linha:

```bash
restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --keep-yearly 1 --prune
```

Traduzindo: guarde a última cópia de cada um dos sete dias mais recentes com backup, das quatro semanas mais recentes com backup, dos seis meses mais recentes com backup e do ano mais recente com backup, e apague o resto pra liberar espaço.

<!-- src: 2026/10/06/desastre-no-meu-nas-como-quase-perdi-90-tb-de-dados -->
Em outubro de 2026 eu aprendi que essa camada também tem camadas. Um NAS que aguenta a perda de um disco protege contra um disco morto, mas não contra a perda do aparelho inteiro (@sec-ch15). Pro que é crítico de verdade, mantenha uma terceira cópia fora de casa, na nuvem ou num HD guardado em outro endereço.

### Sem programar nada

<!-- src: original -->
Se você não programa, a versão curta desta peça é a seguinte. No Mac, ligue o Time Machine apontando pra um HD externo. No Windows, use o programa de backup que vem no sistema ou um de terceiros, apontando pra um HD externo ou pra nuvem. E, nos dois casos, uma vez por mês abra três ou quatro arquivos da cópia pra ver se eles abrem.

> A prova de que o backup funciona está no arquivo restaurado, comparado com o original. O aviso de "backup concluído" é o programa falando dele mesmo.

## 4. O que pode, o que pergunta, o que nunca

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
Por padrão, os agentes de programação pedem permissão antes de cada comando. É seguro e é exaustivo: depois da centésima confirmação de um comando inofensivo, você começa a apertar "sim" sem ler, e a trava perde o sentido. O outro extremo é o [modo YOLO]{.gls key=modo-yolo}, em que o agente executa tudo sem perguntar nada.

<!-- src: ref:ai-jail/src/bootstrap.rs -->
O meio-termo é uma lista de permissões em três colunas, que quase todo agente aceita num arquivo de configuração:

- **pode sem perguntar**: comandos que só leem ou que são fáceis de desfazer, como ver o estado do repositório, listar arquivos, buscar texto, rodar os testes, gravar um commit local;
- **pergunta antes**: comandos que saem da sua máquina ou apagam coisas, como enviar pro repositório remoto, apagar arquivos, subir contêineres;
- **nunca**: virar administrador, abrir as permissões de um arquivo pra todo mundo, jogar fora sem volta as mudanças locais, reescrever à força o histórico do repositório remoto.

<!-- src: ref:ai-jail/src/bootstrap.rs -->
No Claude Code, essa lista mora num arquivo de configuração em JSON. Um pedaço da que a minha jaula gera, em outubro de 2026, mostra o formato:

```json
"deny": ["Bash(sudo *)", "Bash(chmod 777 *)", "Bash(git push --force *)"],
"ask":  ["Bash(git push *)", "Bash(rm *)", "Bash(docker run *)"],
"allow": ["Bash(git status *)", "Bash(git diff *)", "Bash(git log *)"]
```

Cada entrada é um padrão de comando. O asterisco quer dizer "qualquer coisa daqui pra frente". Outros agentes usam outros nomes e outros arquivos, mas a ideia é a mesma.

<!-- src: 2026/03/01/ai-jail-sandbox-para-agentes-de-ia-de-shell-script-a-ferramenta-real -->
Repare onde está o envio pro remoto: na coluna do meio. O agente pode gravar commits à vontade, criar ramificações, reorganizar o histórico local. Quando chega a hora de publicar, ele para e você revisa. O envio forçado, que sobrescreve o histórico do remoto, fica na coluna do "nunca".

### Modo YOLO, só dentro da jaula

<!-- src: 2026/05/24/dicas-e-toolkit-de-ia-do-akita-ai-jail-ai-memory-ai-usagebar -->
Desde maio de 2026, rodo os agentes quase o tempo todo em modo YOLO (@sec-ch15). Parece contraditório com tudo acima, e seria, se não fosse um detalhe: eu tiro a trava de dentro do agente e coloco uma cerca no sistema operacional. O agente trabalha rápido dentro do projeto, e os dados que eu não compartilhei ficam fora do alcance dele.

A regra que eu sigo é essa combinação. Modo YOLO sem jaula é confiar que nenhum comando errado, de nenhuma origem, vai aparecer. Com jaula, Git remoto e envio manual, o pior caso realista é refazer o trabalho local de uma tarde.

### Segredos

<!-- src: 2026/05/24/dicas-e-toolkit-de-ia-do-akita-ai-jail-ai-memory-ai-usagebar -->
O acidente mais comum que eu vi no ano foi segredo vazando pro repositório: um arquivo com senhas que entra no commit junto com o resto e vai parar no remoto. Aconteceu comigo mais de uma vez.

Três hábitos resolvem quase tudo:

- antes de gravar um commit, confira o que está preparado (`git status` e `git diff --cached`); antes de enviar, revise também todos os commits locais que ainda não foram enviados, inclusive arquivos removidos num commit posterior;
- guarde as senhas e chaves num gerenciador de senhas, pra que perder a pasta do projeto não seja perder a chave do reino;
- se uma chave vazar, troque a chave; limpar o histórico ajuda, mas quem copiou antes continua com ela.

## 5. Agente não entra em produção

<!-- src: 2026/07/11/como-me-precaver-pros-meus-agentes-nao-apagarem-minhas-coisas -->
Esta peça é curta porque o @sec-ch15 já fez o argumento inteiro. Nenhum agente deve ter acesso direto à [produção]{.gls key=producao}, o sistema que atende os clientes de verdade: nada de senha do banco de dados, nada de chave de administrador dos servidores.

Em ambiente de teste, o agente pode trabalhar à vontade, desde que escreva receitas em vez de dar comandos avulsos. Uma receita é um arquivo que descreve a configuração desejada, fica guardado no histórico e pode ser revisado e executado de novo. Ele escreve, aplica no teste, confere e ajusta. Um humano revisa e promove pra produção.

A regra de produção, com a história por trás, está no @sec-ch15.

## 6. Notas que sobrevivem à sessão

<!-- src: 2026/05/18/como-memoria-de-agentes-funciona-e-como-melhorar -->
O modelo não lembra de você. Ele relê, a cada pergunta, o que cabe na mesa de trabalho que você viu no @sec-ch02, e quando a mesa enche, a [compactação]{.gls key=compactacao} resume o começo da conversa e perde detalhe. Fechou a sessão, acabou. A memória que vale é a que você escreve em arquivo.

Eu separo o que guardar em três gavetas:

- **regras do projeto**: como o projeto se organiza, que comandos rodam os testes, o que nunca fazer; vão no [arquivo de instruções do projeto]{.gls key=agents-md} que o agente lê ao começar (@sec-ch09);
- **decisões e pesquisas**: por que escolhemos esta biblioteca, o resultado daquele teste comparativo, o procedimento de publicação; viram documentos numa pasta de documentação dentro do projeto, versionados junto com o código;
- **o meio do caminho**: o defeito esquisito que apareceu, a hipótese que falhou, onde a tarefa parou; é o que se perde com mais facilidade e o que mais faz falta na sessão seguinte.

<!-- src: 2026/05/24/dicas-e-toolkit-de-ia-do-akita-ai-jail-ai-memory-ai-usagebar -->
As duas primeiras gavetas são fáceis: peça ao agente pra escrever e revisar esses arquivos, e confira o que ele escreveu. A terceira é a mais chata, e foi pra ela que eu escrevi uma ferramenta (@sec-apmemoria). Sem ferramenta nenhuma, dá pra resolver com disciplina: no fim de cada sessão, peça ao agente um resumo de onde parou, do que falhou e do que falta, salvo num arquivo de passagem de turno que o próximo agente lê ao começar.

### Pra quem usa chat

<!-- src: original -->
Quem só conversa com um chatbot tem os equivalentes. O campo de instruções permanentes da maioria dos chatbots faz o papel do arquivo de regras (@sec-ch09). E um arquivo de texto seu, com o resumo do que você já combinou com a máquina, faz o papel das outras duas gavetas: você cola o resumo no começo de uma conversa nova e não precisa explicar tudo de novo.

O resumo é seu. Ele funciona no Claude, no ChatGPT, no Gemini e no que vier depois.

## 7. Saber quando trocar de cavalo

<!-- src: 2026/05/24/dicas-e-toolkit-de-ia-do-akita-ai-jail-ai-memory-ai-usagebar -->
Em maio de 2026, a conta que eu fazia era esta: pagar o modelo por [token]{.gls}, o pedacinho de texto que é a unidade de cobrança, saía muito mais caro do que os planos mensais das próprias empresas, que vinham subsidiados. O preço do subsídio são os limites: por sessão de algumas horas, por semana, às vezes por modelo. E esses limites mudam sem muito aviso.

<!-- src: 2026/04/09/20-anos-de-blog-o-ano-em-que-a-ia-finalmente-me-deixou-traduzir-tudo -->
Estourar o limite no meio de uma tarefa grande é o jeito mais burro de perder uma tarde. Foi o que quase aconteceu na tradução do blog (@sec-interlude1), quando eu passei pela primeira vez do teto do meu plano Max e paguei uso extra por cima da mensalidade.

<!-- src: 2026/05/24/criei-widget-waybar-omarchy-monitorar-uso-llms-ai-usagebar -->
A peça aqui é um medidor à vista. Os próprios serviços costumam mostrar o consumo em algum canto das configurações, mas ninguém abre essa página no meio do trabalho. O que funciona é ter o número sempre na tela e um alerta antes do teto. Com ele, dá pra decidir:

- começar a refatoração grande só com cota fresca;
- passar a tarefa pra outro agente, de outra empresa, quando um deles está perto do limite (é aqui que as notas da peça anterior pagam o investimento);
- recarregar crédito antes de travar, nos serviços que cobram por uso.

## As minhas ferramentas, como exemplo

<!-- src: original -->
O que vem a seguir são as três ferramentas que eu escrevi em 2026 pra cobrir as peças 1, 6 e 7 no meu computador. São projetos de código aberto, feitos em grande parte com os próprios agentes, e cada uma é só uma das formas possíveis de resolver o problema. As versões e o comportamento descritos são os de outubro de 2026; confira a documentação de cada uma antes de usar.

### ai-jail, a jaula

<!-- src: ref:ai-jail/README.md -->
O ai-jail roda um agente de programação dentro de uma sandbox: no Linux, com o bubblewrap e mais algumas proteções do próprio núcleo do sistema; no macOS, com o `sandbox-exec` [@akita2026aijail; @aijail2026site]. No Windows, ele só funciona dentro do WSL2. Em outubro de 2026 estava na versão 2.9.0.

A documentação diz o que ele promete: proteção contra acidentes, o limite que vimos na peça 1. Contra um atacante tentando fugir de propósito, ele manda usar uma máquina virtual descartável (@sec-ch15).

<!-- src: ref:ai-jail/README.md -->
O uso é colocar `ai-jail` na frente do comando do agente, de dentro da pasta do projeto:

```bash
ai-jail claude              # roda o Claude Code dentro da jaula
ai-jail --dry-run claude    # mostra o que seria montado, sem rodar nada
ai-jail --lockdown claude   # modo mais restrito: projeto só leitura, quase tudo desligado
```

O primeiro mostra o dia a dia. O segundo é pra auditar antes de confiar: ele imprime a configuração da jaula e não executa. O terceiro é o modo de bloqueio total, que ainda assim, avisa a documentação, não substitui uma máquina virtual.

<!-- src: ref:ai-jail/README.md -->
Por padrão, a pasta do projeto é gravável e a pasta pessoal é uma área temporária vazia, que some no fim da sessão. As credenciais do próprio agente entram, pra ele começar logado; a documentação chama isso de troca consciente, e quem não aceita roda com `--no-agent-state`. Rede ampla, placa de vídeo, áudio, Docker, chaves SSH e credenciais de nuvem vêm desligados, cada um com uma opção pra ligar.

<!-- src: ref:ai-jail/README.md -->
Dois detalhes de uso que valem pra qualquer jaula. Arquivos de segredo dentro do próprio projeto, como o `.env`, ficam visíveis pro agente, a menos que você mande esconder com `--mask .env`. E o primeiro uso cria um arquivo `.ai-jail` na pasta, com a política daquele projeto, que pode ir pro repositório junto com o código. Como esse arquivo vem de dentro do projeto, a ferramenta desconfia dele: a menos que você marque aquela pasta como confiável na sua configuração pessoal, ele só consegue apertar a jaula, nunca afrouxar.

<!-- src: ref:ai-jail/src/bootstrap.rs -->
Por fim, a opção `--bootstrap` escreve configurações de permissão pra cinco agentes, entre eles o Claude Code, o Codex, o OpenCode e o Gemini CLI. A do Claude Code é a lista de três colunas da peça 4, com o envio pro remoto no "pergunta antes" e o envio forçado no "nunca". Antes de sobrescrever qualquer arquivo, ela guarda uma cópia do antigo.

### ai-memory, as notas

<!-- src: ref:ai-memory/README.md -->
O ai-memory é a memória de longo prazo que eu prometi no @sec-ch02 e contei no @sec-ch20 [@akita2026aimemory; @aimemory2026site]. A ideia: uma sessão nova, em qualquer agente compatível, começa de onde a anterior parou. Ganchos instalados no agente registram a sessão em silêncio, e o servidor transforma o registro em páginas de texto comum. O que ele faz, quando vale a pena e como começar estão no @sec-apmemoria.

<!-- src: 2026/05/24/dicas-e-toolkit-de-ia-do-akita-ai-jail-ai-memory-ai-usagebar -->
Ele cobre a terceira gaveta da peça 6, o meio do caminho. Decisão que precisa sobreviver com garantia continua indo pra um documento dentro do projeto, revisado e versionado. A memória automática guarda o que talvez importe depois; o documento guarda o que com certeza importa.

### ai-usagebar, o medidor

<!-- src: 2026/05/24/criei-widget-waybar-omarchy-monitorar-uso-llms-ai-usagebar -->
O ai-usagebar nasceu em maio de 2026 de uma irritação pequena: eu queria ver o consumo dos planos da Anthropic e da OpenAI num lugar só, sem abrir página nenhuma [@akita2026aiusagebar]. Ele começou como uma reescrita, em Rust, de uma ferramenta parecida que só cobria o Claude [@mryll2026claudebar].

<!-- src: ref:ai-usagebar/README.md -->
Em outubro de 2026 ele mostrava, na barra do sistema ou numa janela de terminal, quanto de cada limite já foi gasto e quando ele zera, pra uma lista longa de serviços, do Claude e do Codex a revendedores que cobram por uso. Pros planos da Anthropic e da OpenAI, ele lê as credenciais que os próprios programas oficiais já guardaram no computador. Por padrão, avisa quando um limite passa de 97%.

<!-- src: ref:ai-usagebar/README.md -->
A versão de barra foi feita pro Linux que eu uso, mas a de terminal roda em qualquer lugar, e a documentação descreve integrações com outros ambientes de Linux e um ícone de bandeja pra macOS e Windows. Na minha tela, ele resolve uma pergunta só: continuo neste agente, passo a tarefa pro outro ou espero a cota zerar?

## A versão de bolso

<!-- src: original -->
Se você só levar uma lista deste apêndice, leve esta:

- rode o agente numa jaula que limita o acesso aos seus dados ao projeto e às exceções que você conferiu;
- tenha snapshots automáticos e saiba recuperar um arquivo deles;
- tenha um backup automático, criptografado, em outro aparelho, e teste a restauração;
- deixe o agente fazer sozinho só o que é fácil de desfazer, e publicar, apagar e sair da máquina só com a sua aprovação;
- mantenha o agente longe de produção;
- guarde as regras, as decisões e o meio do caminho em arquivos que são seus;
- ponha o medidor de uso à vista.

Nenhum item depende de qual modelo é o melhor do mês. Todos continuam valendo quando ele trocar.
