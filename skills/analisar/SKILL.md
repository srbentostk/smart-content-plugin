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

### 4. Output — estrutura simples

```markdown
## Resumo em 3 linhas
- **Do que fala:** [tema em uma frase]
- **Por que funcionou:** [1-2 motivos principais em linguagem simples]
- **O que dá pra aprender:** [insight prático aplicável]

## A abertura
> "[primeira frase]"

**Por que segura:** [explicação simples]

## A estrutura (em 4-6 passos)
1. **Abre com:** [...]
2. **Vira pra:** [...]
3. **Sobe pra:** [...]
4. **Fecha com:** [...]

## O que o público sentiu (vindo dos comentários)
- Reação dominante: [...]
- O que mais comentaram: [...]
- O que isso revela: [...]

## 3 padrões pra você usar
1. [...]
2. [...]
3. [...]

## Roteiro anotado
[transcrição com observações curtas em itálico ao lado das frases-chave]
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
