---
description: Analisa vídeo(s) viral(is) extraindo transcrição, comentários e identificando o que faz funcionar. Cole um ou mais links de vídeo (Instagram, YouTube, TikTok).
---

# Analisar Vídeo

## Trigger

Usuário cola link(s) de vídeo ou pede para analisar conteúdo.

## Antes de analisar — sempre pergunte

Não saia analisando sem entender pra quê. Pergunte (uma ou duas por vez):

1. **"Por que você quer analisar esse vídeo?"** (entender o sucesso, copiar formato, aprender padrão, comparar com o seu)
2. **"Você quer aplicar o que aprender em qual tipo de conteúdo seu?"** (nicho, plataforma)
3. **"Tem algo específico que te chamou atenção nesse vídeo?"** (a abertura, o roteiro, os comentários, a edição)

Isso direciona a análise — sem isso, vira relatório genérico.

## Fluxo

### 1. Receber links
- Aceitar um ou múltiplos links
- Detectar plataforma de cada um
- Confirmar com o usuário: "Vou analisar [N] vídeo(s). Confirma?"

### 2. Pesquisa (agente: pesquisador)
Para cada link:
- Transcrição completa
- Top 20 comentários por likes
- Métricas (views, likes, comments)
- Hook isolado (primeira frase)

### 3. Análise (agente: analista-de-principios)
- Frase a frase, anotar o que faz cada parte funcionar
- Análise especial do hook
- Padrões dos comentários: que emoção/debate domina

### 4. Output — estrutura simples + análise frase a frase

**Regra visual:** sempre que mostrar trecho do roteiro, usar **blockquote** (`>`). A análise vem em **texto comum abaixo**. Isso deixa visualmente óbvio o que é fala do vídeo e o que é comentário seu.

```markdown
## Resumo em 3 linhas
- Do que fala: [tema em uma frase]
- Por que funcionou: [1-2 motivos em linguagem simples]
- O que dá pra aprender: [insight prático]

## A abertura

> "[primeira frase do roteiro]"

Aqui explica por que essa abertura segura a pessoa. Em linguagem simples, 2-4 frases.

## Análise bloco a bloco

> "Primeira parte do roteiro"

Análise dessa parte: o que faz com quem assiste, por que funciona, se bate forte ou é discreto.

> "Próxima parte"

Análise da próxima parte.

> "E assim por diante até o final"

Análise final.

## O que o público sentiu (dos comentários)
- Reação dominante: [...]
- O que mais comentaram: [...]
- O que isso revela: [...]

## 3 padrões pra você usar
1. [...]
2. [...]
3. [...]
```

> Tabela técnica de princípios fica em arquivo separado (`principios-detalhados.md`) — só mostrar se o usuário pedir.

### 5. Salvar
`Sofia/Pesquisas/{canal}/{titulo}/`
- `analise.md` (output acima)
- `roteiro-anotado.md`
- `hook.md`
- `comentarios.md`
- `metricas.md`
- `principios-detalhados.md` (opcional)

### 6. Próximos passos
> "O que quer fazer agora?
> 1. Ver o roteiro anotado em detalhe
> 2. Aprender (salvar esses padrões pra usar depois)
> 3. Escrever um roteiro seu inspirado nisso (vou te perguntar algumas coisas pra não inventar)
> 4. Comparar com outro vídeo
> 5. Exportar"

## Múltiplos vídeos

Se vários links:
- Analisar cada um separado
- Ao final, gerar comparativo simples:
  - "O que esses vídeos têm em comum"
  - "Onde eles diferem"
  - "Padrão que mais aparece"

## Perguntas (se necessário)

- "Não consegui extrair a transcrição. Pode colar manualmente?"
- "Qual o idioma do vídeo?"
- "Quer foco em algum aspecto específico?"
