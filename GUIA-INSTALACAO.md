# Sofia 2.0 — Guia de Instalação e Uso

> **Versão visual:** Abra `templates/guia-instalacao.html` no navegador para ver este guia com design bonito.

---

## O que é a Sofia?

A Sofia é uma assistente inteligente que vive dentro do Claude. Ela faz duas coisas:

1. **Pesquisa** — você manda o link de um vídeo viral e ela descobre por que aquele vídeo funcionou, frase por frase
2. **Escrita** — ela te ajuda a escrever roteiros para vídeos virais, fazendo perguntas e sugerindo ideias

---

## Passo 1: Crie suas contas

Antes de instalar, crie contas nestes serviços:

### Claude (obrigatório)

É onde a Sofia vive. Crie sua conta grátis em [claude.ai](https://claude.ai).

Depois, baixe o app Claude no computador: [claude.ai/download](https://claude.ai/download) (Mac ou Windows).

### Apify (recomendado para Instagram/TikTok)

Serviço que coleta comentários com curtidas do Instagram e TikTok. Crie sua conta em [apify.com](https://www.apify.com).

- $5/mês grátis ao criar conta (~150 análises/mês sem pagar)
- Para YouTube não precisa — o yt-dlp (grátis) já faz tudo

---

## Passo 2: Instale a Sofia

1. Abra o **app Claude** no seu computador
2. Vá na **aba Code**
3. Cole o primeiro comando e aperte **Enter**:

```
claude plugin marketplace add https://github.com/srbentostk/smart-content-plugin
```

4. Espere aparecer uma mensagem de confirmação
5. Agora cole o segundo comando e aperte **Enter**:

```
claude plugin install sofia
```

6. Espere aparecer a confirmação de que o plugin foi instalado

Pronto. A Sofia está instalada.

7. Agora **feche o app Claude** e **abra de novo**. Isso é necessário para o Claude reconhecer o plugin novo.

---

## Passo 3: Configure a Sofia

Depois de reabrir o Claude, digite:

```
/sofia:setup
```

A Sofia vai te guiar passo a passo:

1. **Verifica o yt-dlp** — ferramenta grátis que coleta dados de vídeos. Se não tiver instalado, ela explica como instalar
2. **Pede a API key do Apify** — se você criou conta no Apify, ela pede o código. Se não, pula (YouTube funciona sem)
3. **Configura onde salvar** — detecta se você está num Obsidian Vault e sugere o local ideal
4. **Faz um teste** — extrai um vídeo curto para confirmar que tudo funciona
5. **Confirma** — mostra os comandos disponíveis

Depois do setup, você está pronto para usar.

---

## Como usar

### `/sofia:analisar` — Analisar um vídeo

Cole o link de um vídeo e a Sofia busca tudo: texto falado, comentários mais curtidos, números, capa. Depois analisa frase por frase por que o vídeo funciona.

```
/sofia:analisar https://youtube.com/watch?v=XXXXX
/sofia:analisar https://instagram.com/reel/XXXXX
/sofia:analisar https://tiktok.com/@usuario/video/XXXXX
```

Funciona com YouTube, Instagram, TikTok, e milhares de outros sites.

### `/sofia:roteiro` — Escrever um roteiro

A Sofia faz perguntas sobre seu tema, público e o que as pessoas estão comentando. Depois sugere aberturas e escreve 2-3 versões do roteiro completo.

### `/sofia:critica` — Criticar um roteiro

Cole um roteiro (seu ou de outra pessoa) e ela avalia com honestidade.

### `/sofia:melhorar` — Melhorar um roteiro

Depois de uma crítica, ela reescreve corrigindo os problemas.

### `/sofia:dashboard` — Ver painel visual

Gera uma página bonita com a análise completa do vídeo.

### `/sofia:exportar` — Exportar

Salva tudo que a Sofia aprendeu em arquivos organizados.


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
A Sofia é grátis. O Claude tem versão grátis. Para YouTube, tudo é grátis. Para Instagram/TikTok, o Apify é recomendado e tem $5 grátis/mês.

### "Funciona no celular?"
Você pode despachar tarefas pelo celular usando o app Claude, mas a instalação precisa ser feita no computador.

### "Funciona no navegador (claude.ai)?"
Não. O navegador não suporta plugins. Use o app Claude ([claude.ai/download](https://claude.ai/download)).

### "Preciso usar o Terminal?"
Não. O app Claude tem interface visual. O Terminal é opcional.

### "Com quais sites a Sofia funciona?"
YouTube, Instagram, TikTok, Twitter/X, Reddit, Facebook, Twitch, Vimeo, e milhares de outros.

### "Preciso do Apify?"
Para YouTube: não. Para Instagram/TikTok: é muito recomendado. Sem ele, a Sofia não consegue pegar os comentários com curtidas. O Apify tem $5 grátis/mês (~150 análises).
