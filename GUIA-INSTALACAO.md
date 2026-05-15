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

É uma ferramenta que roda no seu computador e coleta informações de vídeos de **milhares de sites** — não só YouTube.

- **Funciona com:** YouTube, Instagram, TikTok, Twitter/X, Reddit, Facebook, Twitch, Vimeo, e mais
- **Coleta:** texto falado, comentários, números, capa, áudio
- **Preço:** grátis, sem conta, sem limite de uso
- **A Sofia sempre tenta o yt-dlp primeiro**

### Apify (opcional — alternativa quando yt-dlp não conseguir)

É um serviço online que faz coleta avançada de dados. A Sofia só usa quando o yt-dlp falha.

- **Funciona com:** YouTube, Instagram, TikTok, Twitter/X, Facebook, LinkedIn
- **Quando é necessário:** quando Instagram ou TikTok bloqueiam o yt-dlp, ou para dados extras (compartilhamentos, salvamentos)
- **Preço:** $5/mês grátis ao criar conta. Cada análise custa ~$0.03. Dá para ~150 análises/mês sem pagar
- **Criar conta:** apify.com (opcional)

### Resumo rápido

| Ferramenta | Preço | Para que serve | Precisa de conta? |
|---|---|---|---|
| Claude | Grátis (limitado) ou $20/mês | Rodar a Sofia | Sim — claude.ai |
| yt-dlp | Grátis | Coletar dados de vídeos (YouTube, Instagram, TikTok, etc.) | Não |
| Apify | Grátis ($5/mês de créditos) | Alternativa quando yt-dlp não conseguir | Sim — apify.com (opcional) |

---

## Instalação (um comando só)

### Passo 1: Abra o Terminal

O Terminal é um programa que já vem no seu computador.

**No Mac:**
1. Aperte **Command + Barra de Espaço**
2. Digite **Terminal**
3. Clique no ícone que aparece

**No Windows:**
1. Clique no botão **Iniciar**
2. Digite **PowerShell**
3. Clique em **Windows PowerShell**

### Passo 2: Cole o comando de instalação

Copie e cole no Terminal, depois aperte **Enter**:

```
curl -sSL https://raw.githubusercontent.com/srbentostk/smart-content-plugin/main/scripts/install.sh | bash
```

> **Nota:** O repositório precisa estar publicado no GitHub para o comando funcionar.

Esse comando faz tudo sozinho:
- ✅ Instala o Node.js
- ✅ Instala o Claude Code
- ✅ Instala o yt-dlp
- ✅ Baixa os arquivos da Sofia

### Passo 3: Abra a Sofia

Depois da instalação, digite:

```
cd ~/sofia-2.0 && claude
```

Na primeira vez, o Claude vai pedir login. Crie uma conta grátis em claude.ai se ainda não tiver.

### Passo 4: Configure

Dentro do Claude, digite:

```
/sofia-setup
```

A Sofia verifica se tudo está funcionando e te guia pela configuração.

---

## Como usar a Sofia

### Comando 1: Analisar um vídeo — `/sofia-analisar`

Você cola o link de um vídeo e a Sofia busca tudo: texto falado, comentários, números, capa. Depois analisa frase por frase por que o vídeo funciona.

```
/sofia-analisar https://youtube.com/watch?v=XXXXX
/sofia-analisar https://instagram.com/reel/XXXXX
/sofia-analisar https://tiktok.com/@usuario/video/XXXXX
```

**Funciona com:** YouTube, Instagram, TikTok, e milhares de outros sites.
**Custo:** Grátis (usa yt-dlp). Se yt-dlp não conseguir, pergunta se quer tentar com Apify (~R$0,15).

### Comando 2: Escrever um roteiro — `/sofia-roteiro`

A Sofia faz perguntas sobre seu tema, público e o que as pessoas estão comentando. Depois sugere aberturas e escreve 2-3 versões do roteiro completo.

**Custo:** Grátis

### Comando 3: Criticar um roteiro — `/sofia-critica`

Cole um roteiro (seu ou de outra pessoa) e ela avalia com honestidade.

**Custo:** Grátis

### Comando 4: Melhorar um roteiro — `/sofia-melhorar`

Depois de uma crítica, ela reescreve corrigindo os problemas.

**Custo:** Grátis

### Comando 5: Ver painel visual — `/sofia-dashboard`

Gera uma página bonita com a análise completa do vídeo.

**Custo:** Grátis

### Comando 6: Exportar — `/sofia-exportar`

Salva tudo que a Sofia aprendeu em arquivos organizados.

**Custo:** Grátis

---

## Fluxo recomendado

```
1. Analise um vídeo viral que você admira
   /sofia-analisar + link do vídeo
         ↓
2. Estude a análise — entenda por que funciona
         ↓
3. Escreva seu próprio roteiro
   /sofia-roteiro
         ↓
4. Peça uma crítica honesta
   /sofia-critica
         ↓
5. Melhore com base na crítica
   /sofia-melhorar
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
Não. É opcional. O yt-dlp funciona com a maioria dos vídeos. O Apify só é útil quando o yt-dlp falha em algum vídeo específico.

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
