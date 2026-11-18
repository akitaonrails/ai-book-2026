---
id: ch19b
chapter: "O mundo não vai esperar"
sources:
  - {post: 2026/10/16/estamos-no-futuro-carros-voam-e-nao-temos-mais-que-fazer-html-css, sha256: "de077ef703c6e8c2f78d26fb0a4a7cc7d56913b37c5d46ccb4eaa791c4120787", commit: "760caa8f77017b84661ed95fcca0f0d61b222594"}
  - {post: 2020/04/01/akitando-76-guia-definitivo-de-aprendendo-a-aprender-a-maior-bronca-da-sua-vida-rated-r, sha256: "4c8343cf9487f3e389341a2e5654a423cb2ff2cced3ecbbddb5aed5385b544c1"}
  - {post: 2021/01/06/akitando-90-o-que-os-cursos-nao-te-ensinam-sobre-mercados, sha256: "5a6b08a8fdebc6eac5511e470883960e1f763187351f8df54e684349eee446c1"}
refs_projects: []
blog_commit: "79bca4b5ce7a7bc72f950b923318e9ca2c04b01d"
---

# O mundo não vai esperar {#sec-ch19b}

<!-- src: 2026/10/16/estamos-no-futuro-carros-voam-e-nao-temos-mais-que-fazer-html-css -->
Passava das duas da manhã de 16 de outubro de 2026. Eu estava no escritório, ainda acordado depois de um dia mexendo nos meus sites, assistindo à apresentação do novo **Tesla Roadster**. Vi o protótipo subir uma rampa, ficar de cabeça pra baixo e, em outra passagem, girar no ar e pousar. Era uma demonstração controlada, longe de significar que qualquer pessoa já podia sair voando pela cidade.

Mesmo com essa distância entre demonstração e produto, eu estava feliz pra cacete. Era o tipo de futuro que eu queria ver. No meu computador tinha acontecido uma mudança menos cinematográfica: em cerca de um dia, eu tinha redesenhado seis sites existentes com agentes, sem escrever à mão a maior parte do HTML e CSS.

![O Roadster na demonstração de outubro de 2026: um protótipo, longe de estar disponível pra sair voando pela cidade.](assets/figures/ch19b-roadster.jpg){#fig-ch19b-roadster width=3.4in fig-alt="Carro esportivo prateado suspenso acima de uma pista escura, com jatos visíveis sob a carroceria." fig-desc="O carro aparece com as quatro rodas afastadas do chão. Vários jatos claros saem da parte inferior em direção à pista, onde se espalha uma nuvem iluminada. A imagem isolada não estabelece duração, velocidade ou condições de segurança da manobra."}

<!-- src: original -->
Eu já ganhei dinheiro fazendo uma parte daquele trabalho manual. Receber uma tela desenhada, transformar em página e ajustar até funcionar no navegador pagou contas minhas. Agora eu estava comemorando conseguir delegar aquilo.

Essa alegria pode parecer estranha num livro que recebeu o leitor preocupado com o emprego. Mas seria desonesto passar os capítulos explicando quanta coisa os agentes já fazem e, na hora de falar de carreira, prometer que nenhuma vaga vai desaparecer. A minha expectativa é que desapareçam muitas, inclusive vagas ocupadas por gente competente.

Também espero que apareçam trabalhos que hoje mal consigo descrever. Não sei em que quantidade, em que prazo ou pra quem. O que eu me recuso a desejar é um mundo congelado no estágio em que aprendi a ganhar dinheiro.

## O trabalho que eu fiquei feliz de perder

<!-- src: 2026/10/16/estamos-no-futuro-carros-voam-e-nao-temos-mais-que-fazer-html-css -->
Os seis sites eram o AI Lair, os sites do ai-memory e do ai-jail, a newsletter The M.Akita Chronicles, seu arquivo e o meu blog. Todos já existiam. Eu estava refazendo suas interfaces, a partir de cinco repositórios, com o conhecimento que já tinha dos produtos.

Essa diferença importa. Eu não construí seis empresas em um dia, nem descobri seis necessidades de mercado. O conteúdo, os programas e boa parte das decisões anteriores estavam lá. A experiência mostra quanto consegui acelerar uma reforma com escopo conhecido; não mede o tempo que qualquer equipe levaria pra criar qualquer produto.

As versões anteriores tinham aquele visual que eu comecei a reconhecer antes de ler o título: fundo escuro, gradiente roxo, letras enormes e cartões arredondados. Pedir ao Claude um design diferente produzia variações da mesma coisa. Eu aceitava porque funcionava, até cansar.

Usei o **Stitch**, do Google, pra explorar propostas visuais, e Claude Code e Codex pra levar as propostas aos sites reais. O ai-memory ganhou a ideia de um arquivo de memória. A newsletter ganhou a de uma transmissão noturna. Pro AI Lair, puxei a feira mundial dos anos 1950 e 1960 que já estava na capa deste livro.

Vieram versões ruins. Algumas tinham um pedaço aproveitável, outras eu mandei jogar fora inteiras. Escolher uma metáfora ajudava; também era preciso perceber quando a metáfora atrapalhava a leitura, quando a página ficava exagerada ou quando uma imagem bonita disputava atenção com o que o visitante precisava entender.

### A parte que o protótipo esconde

O trabalho continuou nas páginas internas e no celular. Uma direção visual precisava sobreviver ao artigo comprido, ao formulário, ao estado de erro e ao e-mail. Os agentes implementavam, verificavam e corrigiam; eu decidia o que preservar e o que tentar de novo.

Também pedi leituras simuladas de visitantes com perfis diferentes. No ai-jail, elas ajudaram a encontrar uma promessa errada sobre a rede ficar desligada por padrão. No ai-memory, apontaram explicações de permissões que se contradiziam e informação básica enterrada debaixo de funcionalidades avançadas.

Esses visitantes eram simulações feitas por modelos. Suas observações eram hipóteses pra conferir. Ainda precisava comparar cada alegação com o produto e, depois, ouvir gente de verdade.

Eu não terminei o dia achando que tinha virado um designer premiado. Um profissional de design encontraria muita coisa pra melhorar. Terminei com sites melhores do que os anteriores, adequados ao que eu precisava naquele momento, e com a possibilidade de voltar a mexer sem tratar cada tentativa como um investimento irrecuperável de semanas.

<!-- src: original -->
É esse o trabalho que fiquei feliz de perder: a obrigação de executar manualmente cada transformação entre uma decisão e uma interface funcionando. Continuo interessado em descobrir se a decisão presta. Quanto mais barata fica a execução, mais versões consigo comparar antes de me comprometer com uma delas.

> Engenharia de software existe pra resolver problemas usando computadores. Código é um dos meios disponíveis pra chegar ao resultado.

Se você escreve menos código e resolve melhor o problema, fez um trabalho melhor. Se escreve uma montanha de código e ninguém consegue usar o resultado, o esforço não salva a entrega. Essa régua já valia quando todas as linhas eram digitadas por uma pessoa.

## Sim, vagas também desaparecem

<!-- src: original -->
A distinção entre tarefa e emprego ajuda a entender a mudança, mas não protege contrato de trabalho. Imagine uma empresa com demanda estável, cuja equipe passa boa parte da semana implementando variações de telas conhecidas. Se menos pessoas passam a entregar o mesmo resultado, com qualidade suficiente, a empresa pode reduzir a equipe.

Pode também usar a capacidade pra atender uma fila de problemas que vivia sendo adiada. Pode criar outro produto. Essas possibilidades disputam orçamento, clientes e prioridades; nenhuma delas acontece automaticamente pra compensar cada vaga eliminada.

O problema de dizer "a IA só substitui quem digita" é que parece oferecer imunidade a quem se considera um programador de verdade. Um profissional pode entender o negócio, trabalhar bem e perder a vaga porque a empresa precisa de menos gente. Pode ser atingido por uma decisão ruim de gestão, por um concorrente ou pelo desaparecimento do produto inteiro.

Estudar não garante que o mercado vai recompensar cada pessoa na proporção do seu esforço. Formação e experiência aumentam as coisas que você consegue fazer. O mercado continua podendo deixar de comprar justamente aquela que vinha pagando suas contas.

<!-- src: 2026/10/16/estamos-no-futuro-carros-voam-e-nao-temos-mais-que-fazer-html-css -->
Quando saí de sites e agências pra integração de sistemas empresariais, precisei aprender um mundo diferente. Depois vieram outras mudanças, incluindo vídeo, educação e os projetos com IA. A parte da minha carreira que atravessou essas fases foi a capacidade de aprender o problema seguinte; nenhuma interface específica teria servido pra todas elas.

<!-- src: original -->
No @sec-ch18 eu contei a mudança dos cartões perfurados até os agentes. Aqui está a consequência que faltava explicitar: cada camada automatizada permite dispensar parte do trabalho que sustentava a camada anterior. A inovação que substitui uma atividade torna aquela atividade menos necessária, mesmo quando ainda há gente boa vivendo dela.

### A conta não fecha na mesma semana

Uma sociedade que precisa gastar menos esforço pra obter o mesmo resultado pode usar essa capacidade em outras necessidades. É por isso que considero desejável automatizar trabalho repetitivo. Preservar todas as tarefas existentes exigiria abrir mão justamente desse ganho.

Mas a pessoa demitida paga aluguel antes de a economia descobrir onde usar a capacidade liberada. Recolocação, formação e apoio durante a transição são problemas concretos. Reconhecer esse custo não exige defender que a tecnologia pare; exige parar de vender a transição como se fosse indolor.

Também não resolve chamar toda novidade de progresso. Um sistema que ficou barato porque passou a errar cobranças, excluir usuários ou transferir trabalho pro cliente piorou o serviço. A comparação precisa incluir o resultado que chega a quem depende dele, como discutimos no @sec-ch19.

> O fato de uma atividade ter pago suas contas durante anos não obriga o mundo a continuar precisando dela.

Eu entendo o apego. Aprender uma profissão custa tempo, e descobrir que uma parte dela perdeu valor parece uma desvalorização do esforço inteiro. Só que tentar preservar a dificuldade antiga não devolve a utilidade que ela tinha.

Prefiro carregar o que aprendi pra outro problema. Conhecimento de navegador continua ajudando a detectar uma página quebrada, mesmo quando deixo a ferramenta escrever o código. E, se amanhã a ferramenta também conferir melhor parte disso, preciso continuar procurando onde meu conhecimento faz diferença.

## Um filme de Christopher Nolan

<!-- src: original -->
Na apresentação de *A Odisseia*, a Universal destaca "a film by Christopher Nolan": um filme de **Christopher Nolan** [@universal2026odyssey]. É uma forma de atribuição que entendemos sem imaginar que ele tenha feito sozinho tudo que aparece na tela.

O crédito da direção existe junto dos créditos dos demais profissionais, que também tomam decisões criativas:

![Nolan e a equipe nas filmagens de A Odisseia. A direção reúne trabalhos especializados, com autoria e créditos próprios.](assets/figures/ch19b-nolan.png){#fig-ch19b-nolan width=3.65in fig-alt="Nolan à esquerda, equipe e câmera sobre trilhos ao centro, dois intérpretes de figurino à direita, numa locação aberta." fig-desc="Nolan ergue uma mão à esquerda da composição. No centro, profissionais trabalham junto de uma câmera IMAX montada sobre trilhos, com um microfone suspenso acima. À direita estão dois intérpretes com trajes de época. O enquadramento reúne direção, operação de câmera, som e atuação na mesma locação; não revela as instruções dadas naquele momento."}

- O elenco interpreta os personagens, trabalhando a atuação com a direção.
- O figurinista concebe os trajes; a equipe de figurino organiza sua produção, obtenção e uso em cena.
- O diretor de fotografia desenvolve a imagem com o diretor, coordenando escolhas de luz e câmera com equipes especializadas.
- Os artistas de efeitos visuais trabalham nas imagens e composições que exigem esse tratamento.
- O compositor escreve a música, enquanto profissionais de som cuidam de outras partes da experiência sonora, dos efeitos à montagem e à mixagem.
- O montador trabalha a seleção e a organização do material filmado, em colaboração com a direção.

Nolan participa das escolhas de câmera e montagem sem executar sozinho cada ofício. O compositor conversa com a direção sobre a música; os departamentos propõem soluções e precisam coordená-las [@screenskillsdirector; @screenskillscostume; @screenskillsdop; @screenskillscomposer; @screenskillseditor; @screenskillssound].

### O nome maior não apaga os outros

*Oppenheimer* dá um exemplo verificável dessa divisão. No Oscar de 2024, Nolan venceu em direção, **Jennifer Lame** em montagem, **Hoyte van Hoytema** em fotografia e **Ludwig Göransson** em trilha sonora original. Eram reconhecimentos distintos por contribuições ao mesmo filme [@academy2024oscars].

Imagine que você ganhe acesso à mesma equipe e diga: "Façam um filme bom". Ter especialistas excelentes aumenta suas possibilidades, mas deixa questões enormes sem resposta.

Que história merece ser contada, de que ponto de vista? Quanto tempo o espectador precisa passar numa cena antes de entender o que está em jogo?

Considere uma decisão pequena, como prolongar um silêncio. Ela muda a atuação que vale aproveitar, o corte, a entrada da música e a informação que o público recebe. Avaliar cada departamento isoladamente pode produzir partes excelentes que, juntas, estragam a cena.

É parecido com um sistema em que cada tela parece boa, cada serviço passa nos próprios testes e a jornada completa do cliente continua impossível. Alguém precisa entender o conjunto, perceber a incompatibilidade e decidir o que muda. Em software, essa responsabilidade pode estar distribuída entre várias pessoas; não precisa haver um diretor solitário.

### Dar a ordem é o começo

Consigo pedir ao agente "resolva o problema". Se for um defeito pequeno, com um teste claro, ele pode investigar e corrigir sem que eu acompanhe cada passo. Essa autonomia já é útil e faz parte do que estou comemorando.

Agora imagine o pedido: "Resolva o problema de cobrança da empresa". O programa não sabe, só por essa frase, se a divergência vem de uma regra de desconto, de uma negociação comercial ou de dois departamentos usando definições diferentes de atraso. Pode procurar indícios, fazer perguntas e propor hipóteses. Ainda precisamos descobrir o que está acontecendo e como reconhecer uma solução aceitável.

Se eu pedir apenas uma tela nova, posso ganhar uma interface impecável que calcula a dívida errada. Se eu entender o conflito, talvez a melhor solução exija menos software: esclarecer a regra, mudar o fluxo de aprovação e só então automatizar o cálculo. A execução eficiente de uma decisão ruim continua sendo uma decisão ruim.

> Dirigir um trabalho exige saber reconhecer o resultado, inclusive quando ele chega diferente do que você pediu.

É aí que entram repertório, experiência e atenção. Saber o que perguntar, perceber o detalhe que compromete a entrega e recusar uma resposta plausível custa aprendizado. Um pedido com a palavra "excelente" não fornece esse critério.

A analogia termina antes de equiparar uma equipe de cinema a um modelo. Pessoas têm intenção, experiência própria e responsabilidade profissional; o agente pode produzir uma justificativa convincente pra um erro. Uso a comparação pra falar da relação entre direção e execução, respeitando a diferença entre os colaboradores que você tem em cada caso.

## "Foi feito por IA" não encerra a avaliação

<!-- src: original -->
Se alguém me mostra um site e diz "foi feito por IA", ainda sei muito pouco sobre o site. Preciso abrir, tentar usar e descobrir o que ele entrega. A origem do código não responde se a inscrição funciona, se o texto explica o produto ou se uma pessoa consegue navegar pelo teclado.

Posso encontrar uma página genérica, cheia de texto que parece escrito pra ocupar espaço. Posso encontrar uma solução útil e bem cuidada. Em ambos os casos, consigo apontar defeitos e qualidades mais concretos do que a ferramenta que participou da produção.

O mesmo vale pra um programa escrito inteiramente à mão. O trabalho manual não torna uma senha exposta mais segura. A quantidade de horas gastas pra produzir o erro não diminui o prejuízo de quem sofreu com ele.

Isso não obriga ninguém a ignorar o processo. Se um cliente comprou trabalho artesanal, essa característica faz parte do pedido. Se há problema de licença, confidencialidade ou atribuição, temos uma objeção específica que merece resposta; esconder a origem pra contornar uma exigência também compromete a entrega.

O que eu rejeito é usar "feito por IA" como substituto de avaliação técnica. No @sec-ch16 vimos código gerado acumulando riscos reais. Dá pra criticar a vulnerabilidade, o teste insuficiente e o responsável que publicou sem conferir, sem inventar que o mesmo defeito seria aceitável se tivesse sido digitado devagar.

### A assinatura vem com trabalho

O raciocínio também vale pra quem entrega. Você não ganha autoria competente porque escreveu um comando e colocou seu nome no resultado. Precisa decidir o que aceita, reconhecer o que não sabe avaliar e buscar ajuda onde essa limitação importa.

Quando digo que fiz os sites, estou descrevendo um trabalho em que escolhi direções, mandei implementar e conferi resultados, com ajuda explícita das ferramentas. Não estou dizendo que desenhei cada imagem ou digitei cada regra de estilo. A descrição pode ser precisa sem diminuir o resultado nem apagar o processo.

<!-- src: 2026/10/16/estamos-no-futuro-carros-voam-e-nao-temos-mais-que-fazer-html-css -->
A parte mais útil daquele dia foi poder rejeitar trabalho barato. Um protótipo ruim deixou de ser algo que eu precisava defender porque já tinha custado muito esforço. Pude preservar uma ideia, abandonar o resto e tentar outra direção.

<!-- src: original -->
Essa liberdade exige algum gosto desenvolvido, alguma noção de uso e disposição pra comparar. Se eu aceitar tudo que sai primeiro, só acelero a produção de páginas parecidas. A ferramenta amplia o número de tentativas; eu ainda preciso aprender com elas.

## A receita não dá três estrelas

<!-- src: original -->
Pense agora em **Gordon Ramsay** diante de uma receita e numa pessoa que nunca cozinhou preparando o mesmo prato. O texto pode ser idêntico. A experiência pra perceber um ponto errado, ajustar o preparo e organizar o serviço não vem impressa junto.

E vale acertar a expressão: o Guia Michelin concede estrelas a restaurantes, não a chefs individualmente. Entre os critérios estão o domínio das técnicas e a consistência ao longo das visitas [@michelindistinctions; @michelinstar]. Copiar uma receita não entrega, por si só, uma operação capaz de servir refeições nesse nível repetidamente.

O iniciante pode acertar um prato excelente seguindo a receita. Falta conseguir repetir e adaptar quando o ingrediente ou a situação muda.

É esse caminho que muita propaganda de curso tentou vender como dispensável. Memorize os nomes, reproduza a demonstração, termine o projeto guiado e receba uma identidade profissional. Você aprende algumas operações úteis, mas ainda falta enfrentar o problema que não veio com o próximo passo escrito na tela.

<!-- src: 2021/01/06/akitando-90-o-que-os-cursos-nao-te-ensinam-sobre-mercados -->
No episódio 90 do Akitando, *O que os cursos não te ensinam sobre mercados*, publicado em janeiro de 2021, eu já separava o caminho guiado do curso e o mundo do trabalho. Fora da aula, você precisa formular perguntas que ninguém preparou por você. E um período de contratação fácil pode esconder essa diferença por tempo suficiente pra parecer que ela não existe [@akitando090].

<!-- src: original -->
No @sec-ch18 está a história da bolha. Aqui importa o aprendizado errado que ela podia deixar: "Fui contratado, então minha formação terminou". Contratação mostra que alguém precisava de você naquela situação; não é um certificado vitalício de que seu repertório continuará adequado.

### Praticar o que você ainda não domina

<!-- src: 2020/04/01/akitando-76-guia-definitivo-de-aprendendo-a-aprender-a-maior-bronca-da-sua-vida-rated-r -->
No *Guia definitivo de aprendendo a aprender*, de abril de 2020, eu insistia em prática deliberada: identificar um aspecto fraco, trabalhar nele, avaliar e corrigir. Curso e livro podem ajudar muito nesse processo. O erro é confundir assistir a alguém resolver com ter desenvolvido a capacidade de resolver [@akitando076].

<!-- src: original -->
A IA deixa essa confusão mais fácil porque entrega uma resposta com aparência de trabalho concluído. Você pode ler a explicação, achar tudo familiar e continuar incapaz de reconhecer o mesmo problema quando ele aparecer de outro jeito. O exercício que vale é descobrir até onde consegue justificar a solução e o que acontece quando uma condição muda.

Imagine que, numa revisão normal do seu trabalho, você precise conferir um desconto numa compra. Antes de consultar o agente, escreva o resultado esperado; depois mude a condição: parte da compra foi devolvida. Preveja o que deveria acontecer com o desconto, compare com a resposta da ferramenta e leve a divergência a um colega que conheça a regra. Dá pra praticar assim numa planilha de contabilidade ou numa tarefa de programação atribuída pelo chefe, sem precisar escolher o projeto inteiro.

Se você só consegue repetir a explicação da ferramenta, encontrou algo concreto pra estudar. As sugestões por profissão pra começar nesta semana estão no epílogo (@sec-epilogo).

O roteiro de estudo está no @sec-apestudar; não vou repeti-lo aqui. A mudança com os agentes é a quantidade de ajuda disponível pra explorar uma dúvida. Dá pra pedir exemplos, comparar alternativas e preparar exercícios, desde que você confira as respostas e não use a ferramenta pra esconder de si mesmo o que ainda não entendeu.

Isso vale também pra quem tem décadas de carreira. Conhecer muito de um domínio não me torna especialista no próximo. Se eu começo a avaliar design, preciso aprender a enxergar problemas de design; meu histórico programando não transforma toda preferência minha em uma decisão boa.

> Use a facilidade de produzir pra aumentar a qualidade da prática, sem confundir quantidade de respostas com aprendizado.

O espelho que apareceu no @sec-ch06 e no @sec-ch07 volta aqui: a maneira como você escolhe, verifica e corrige fica visível no resultado. Quem aprova qualquer coisa tende a publicar mais qualquer coisa. Quem tem critério consegue usar as tentativas pra melhorar, e quem está começando pode desenvolver esse critério.

Isso não significa que todo erro do agente seja culpa do usuário, nem que um especialista consiga superar qualquer limite do modelo. Também não há garantia de Oscar ou de estrela Michelin. Experiência ajuda a reconhecer onde a ferramenta serve e onde insistir nela só vai produzir mais trabalho ruim.

## Depois que a tarefa acaba

<!-- src: original -->
Se você gosta de programar, continue programando. O prazer de compreender uma máquina e construir alguma coisa permanece. Só não conte com o mercado pagando indefinidamente por uma dificuldade que você prefere conservar.

Eu também não proponho correr atrás de toda ferramenta lançada. Isso pode virar outra forma de repetição, uma coleção de tutoriais sem nenhum problema resolvido. Prefiro escolher um trabalho real, entender suas restrições e experimentar o que permite fazê-lo melhor.

Se a automação libera parte do seu tempo, há uma oportunidade de estudar o trecho que você sempre evitou. Pode ser a regra do negócio por trás de um cálculo ou o motivo de o cliente abandonar um processo. Talvez você descubra que estava aperfeiçoando uma etapa que nem precisava existir.

Continuar fazendo as mesmas perguntas por anos, esperando respostas prontas e repetindo procedimentos sem compreender seus limites, é uma aposta num mundo estático. Com os agentes, essa aposta ficou ainda pior. Uma parte crescente dessa execução já pode ser comprada como serviço.

<!-- src: 2026/10/16/estamos-no-futuro-carros-voam-e-nao-temos-mais-que-fazer-html-css -->
Naquela madrugada, o carro girando no ar me divertiu. A mudança nos sites já alterava meu trabalho. Eu queria poder testar mais ideias, descartar as ruins e usar meu tempo pra descobrir o que valia construir depois.

<!-- src: original -->
Pra isso, não precisei esperar uma máquina consciente, nem um modelo que tivesse aprendido tudo que falta no mundo. Usei as ferramentas que estavam disponíveis. É por isso que a pergunta sobre os limites da IA, adiada no fim de @sec-ch19, continua importante: quanto da mudança já cabe no que temos, mesmo que a próxima versão não dê salto nenhum?
