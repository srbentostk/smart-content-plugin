# Sofia 2.0 — Guia de Instalação e Uso

Este guia explica tudo passo a passo, do zero, como se você nunca tivesse mexido com nada disso antes.

> **Versão visual:** Abra `templates/guia-instalacao.html` no navegador para ver este guia com design bonito.

---

## O que é a Sofia?

A Sofia é uma assistente inteligente que vive dentro do Claude (uma inteligência artificial). Ela faz coisas que você levaria horas fazendo manualmente — em segundos.

1. **Pesquisa** — você manda o link de um vídeo viral e ela descobre por que aquele vídeo funcionou, frase por frase
2. **Escrita** — ela te ajuda a escrever roteiros para vídeos virais, fazendo perguntas e sugerindo ideias

---

## O que a Sofia extrai de um vídeo

Quando você manda o link de um vídeo, a Sofia coleta:

- **Texto falado** — tudo que a pessoa disse no vídeo, em texto escrito
- **Comentários mais curtidos** — os que mais receberam curtidas (mostra o que o público sentiu)
- **Números** — quantas visualizações, curtidas e comentários o vídeo teve
- **Capa do vídeo** — a imagem que aparece antes de clicar
- **Primeira frase (hook)** — separada e analisada, porque é ela que faz a pessoa parar e assistir
- **Análise frase a frase** — cada frase marcada com o princípio que usa para prender atenção

---

## Ferramentas que a Sofia usa

### yt-dlp (principal — 100% grátis)

É uma ferramenta que roda no seu computador e coleta informações de vídeos de **milhares de sites**.

- **No YouTube, pega TUDO:** texto falado, comentários com curtidas, visualizações, capa
- **No Instagram/TikTok, pega dados parciais:** curtidas do vídeo, descrição, capa, áudio — mas NÃO traz as curtidas de cada comentário nem as visualizações
- **Preço:** grátis, sem conta, sem limite de uso

### Apify (necessário para Instagram — tem créditos grátis)

É um serviço online que complementa o yt-dlp no Instagram e TikTok, trazendo dados que o yt-dlp não consegue:

- **Comentários mais curtidos COM a quantidade de curtidas** (essencial para entender o público)
- **Visualizações** do Reel
- **Compartilhamentos e salvamentos**
- **Preço:** $5/mês grátis ao criar conta (~150 análises/mês sem pagar)
- **Criar conta:** apify.com (recomendado se usa Instagram)
- **Para YouTube:** não precisa — o yt-dlp já faz tudo

### Resumo por plataforma

| Plataforma | yt-dlp (grátis) | Apify (recomendado) |
|---|---|---|
| **YouTube** | Faz tudo | Não precisa |
| **Instagram** | Áudio, capa, curtidas do vídeo | Comentários com curtidas, views, shares |
| **TikTok** | Igual ao Instagram | Igual ao Instagram |

---

## Passo 0: Crie suas contas (se ainda não tem)

Antes de instalar, crie contas nestes serviços (todos têm versão grátis):

1. **Claude** — crie sua conta em [claude.ai](https://claude.ai) (obrigatório)
2. **Apify** — crie sua conta em [apify.com](https://www.apify.com) (recomendado para Instagram/TikTok)

---

## Instalação

Escolha o jeito mais fácil para você:

### Opção A: Marketplace (mais simples — se já tem Claude Code)

Se você já tem o Claude Code instalado, basta abrir o terminal e digitar:

```
/plugin install sofia
```

Pronto. Todos os comandos da Sofia ficam disponíveis imediatamente.

> **Baixar Claude Code:** Se ainda não tem, baixe em [claude.ai/download](https://claude.ai/download)

### Opção B: Instalador visual (dois cliques)

Baixe o instalador do GitHub e dê dois cliques:

- **Mac:** baixe `Instalar Sofia.app` e dê dois cliques (na primeira vez, clique com botão direito > Abrir)
- **Windows:** baixe `Instalar Sofia.vbs` e dê dois cliques

Uma janela vai abrir e tudo será instalado automaticamente (Node.js, Claude Code, yt-dlp, plugin Sofia).

### Opção C: Comando no Terminal

1. Abra o **Terminal** (Mac) ou **PowerShell** (Windows)
2. Cole o comando abaixo e aperte **Enter**:

```
curl -sSL https://raw.githubusercontent.com/srbentostk/smart-content-plugin/main/scripts/install.sh | bash
```

### Depois de instalar: Abra a Sofia

Digite no Terminal:

```
claude
```

Na primeira vez, o Claude vai pedir login. Use a conta que criou no Passo 0.

### Configure a Sofia

Dentro do Claude, digite:

```
/sofia:setup
```

A Sofia verifica se tudo está funcionando e te guia pela configuração.

---

## Links úteis

| O que | Link |
|---|---|
| Criar conta Claude | [claude.ai](https://claude.ai) |
| Baixar Claude Code | [claude.ai/download](https://claude.ai/download) |
| Criar conta Apify | [apify.com](https://www.apify.com) |
| Repositório Sofia | [github.com/srbentostk/smart-content-plugin](https://github.com/srbentostk/smart-content-plugin) |

---

## Como usar a Sofia

### Comando 1: Analisar um vídeo — `/sofia:analisar`

Você cola o link de um vídeo e a Sofia busca tudo: texto falado, comentários, números, capa. Depois analisa frase por frase por que o vídeo funciona.

```
/sofia:analisar https://youtube.com/watch?v=XXXXX
/sofia:analisar https://instagram.com/reel/XXXXX
/sofia:analisar https://tiktok.com/@usuario/video/XXXXX
```

**Funciona com:** YouTube, Instagram, TikTok, e milhares de outros sites.
**Custo:** Grátis (usa yt-dlp). Se yt-dlp não conseguir, pergunta se quer tentar com Apify (~R$0,15).

### Comando 2: Escrever um roteiro — `/sofia:roteiro`

A Sofia faz perguntas sobre seu tema, público e o que as pessoas estão comentando. Depois sugere aberturas e escreve 2-3 versões do roteiro completo.

**Custo:** Grátis

### Comando 3: Criticar um roteiro — `/sofia:critica`

Cole um roteiro (seu ou de outra pessoa) e ela avalia com honestidade.

**Custo:** Grátis

### Comando 4: Melhorar um roteiro — `/sofia:melhorar`

Depois de uma crítica, ela reescreve corrigindo os problemas.

**Custo:** Grátis

### Comando 5: Ver painel visual — `/sofia:dashboard`

Gera uma página bonita com a análise completa do vídeo.

**Custo:** Grátis

### Comando 6: Exportar — `/sofia:exportar`

Salva tudo que a Sofia aprendeu em arquivos organizados.

**Custo:** Grátis

---

## Fluxo recomendado

```
1. Analise um vídeo viral que você admira
   /sofia:analisar + link do vídeo
         ↓
2. Estude a análise — entenda por que funciona
         ↓
3. Escreva seu próprio roteiro
   /sofia:roteiro
         ↓
4. Peça uma crítica honesta
   /sofia:critica
         ↓
5. Melhore com base na crítica
   /sofia:melhorar
         ↓
6. Repita! Quanto mais você analisa e escreve,
   melhor a Sofia fica
```

---

## Perguntas frequentes

### "Preciso pagar alguma coisa?"
A Sofia é grátis. O Claude tem versão grátis. O yt-dlp é grátis. O Apify é opcional e tem $5 grátis/mês.

### "Funciona no celular?"
Não. Precisa de computador (Mac ou Windows).

### "Funciona no navegador (claude.ai)?"
Não. A versão do navegador não permite instalar plugins. O comando de instalação já instala o Claude Code (versão que funciona no Terminal).

### "O que é o Terminal?"
É um programa que já vem no computador. Parece uma tela escura. No Mac: "Terminal". No Windows: "PowerShell".

### "Com quais sites a Sofia funciona?"
YouTube, Instagram, TikTok, Twitter/X, Reddit, Facebook, Twitch, Vimeo, e milhares de outros.

### "A instalação deu erro"
Feche o Terminal, abra novamente, e cole o comando de novo. Se persistir, tire um print e envie para seu instrutor.

### "O yt-dlp não conseguiu pegar um vídeo"
A Sofia avisa e pode sugerir usar o Apify. Você nunca gasta dinheiro sem autorizar antes. Também pode colar o texto do vídeo manualmente.

### "Preciso do Apify?"
**Para YouTube:** Não. O yt-dlp faz tudo de graça. **Para Instagram/TikTok:** É muito recomendado. Sem ele, a Sofia não consegue pegar os comentários mais curtidos com a quantidade de curtidas — dado essencial para entender o público. O Apify tem $5 grátis/mês (~150 análises).

---

## Glossário

| Palavra | O que significa |
|---|---|
| **Terminal** | Programa que já vem no computador. Tela escura onde se digita comandos. |
| **yt-dlp** | Ferramenta grátis que coleta dados de vídeos (texto, comentários, números) de milhares de sites. |
| **Apify** | Serviço online opcional para coleta avançada de dados. Tem créditos grátis. |
| **Claude Code** | Versão do Claude que roda no Terminal. Permite instalar plugins como a Sofia. |
| **Hook** | A primeira frase do vídeo. Faz a pessoa parar e prestar atenção. |
| **Roteiro** | O texto completo do que vai ser falado no vídeo. |
| **Princípios** | Regras de psicologia que fazem um vídeo prender atenção. |
| **Bolha** | Grupo de pessoas que segue o mesmo tipo de conteúdo. |
| **Transcrição** | O texto de tudo que foi falado no vídeo. |
| **Thumbnail** | A imagem de capa do vídeo. |
| **Dashboard** | Página visual com a análise organizada. |
| **API Key** | Código secreto (como uma senha) para acessar um serviço. Só necessário para o Apify. |
