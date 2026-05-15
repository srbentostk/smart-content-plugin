---
name: sofia-analisar
description: Analisa vídeo(s) viral(is) extraindo transcrição, comentários e aplicando análise de princípios frase a frase. Cole um ou mais links de vídeo (Instagram, YouTube, TikTok).
---

# Analisar Vídeo

## Trigger

Usuário cola link(s) de vídeo ou pede para analisar conteúdo.

## Fluxo

### 1. Receber links
- Aceitar um ou múltiplos links
- Detectar plataforma de cada um
- Confirmar com o usuário: "Vou analisar [N] vídeo(s) de [plataformas]. Confirma?"

### 2. Pesquisa (agente: pesquisador)
Para cada link:
- Extrair transcrição completa
- Extrair top 20 comentários por likes
- Extrair métricas (views, likes, comments)
- Separar o hook (primeira frase)

### 3. Análise de princípios (agente: analista-de-principios)
Para cada vídeo:
- Analisar frase a frase qual princípio está aplicado
- Seguir formato: `[Princípio: explicação]\nFrase do roteiro`
- Gerar diagnóstico completo (5 perguntas do framework)
- Análise especial do hook

### 4. Insights de comentários
- Agrupar comentários por tema/emoção
- Identificar que debate mental os comentários revelam
- Extrair padrões: que tipo de reação domina?

### 5. Gerar output
Salvar em: `Sofia/Pesquisas/{canal}/{titulo}/`

Arquivos:
- `roteiro-anotado.md` — transcrição com princípios anotados
- `hook.md` — hook isolado + análise detalhada
- `comentarios.md` — top comentários organizados + insights
- `metricas.md` — dados quantitativos
- `aprendizados.md` — resumo do que aprender deste vídeo

### 6. Apresentar resultados
Mostrar ao usuário:
- Resumo da análise (3-5 linhas)
- Hook com análise
- Top 3 insights
- Princípios mais fortes identificados
- O que está "carregando" o vídeo

### 7. Oferecer próximos passos
> "O que quer fazer agora?
> 1. Ver análise completa
> 2. Aprender (salvar padrões na base de conhecimento)
> 3. Escrever roteiro inspirado nesta análise
> 4. Gerar dashboard com insights
> 5. Exportar como arquivo .md"

## Múltiplos vídeos

Se o usuário colar vários links:
- Analisar cada um separadamente
- Ao final, gerar comparativo:
  - Que princípios aparecem em todos?
  - Que padrões são recorrentes?
  - Que estruturas se repetem?

## Perguntas ao usuário (se necessário)

- "Não consegui extrair a transcrição. Pode colar o roteiro manualmente?"
- "O vídeo é em qual idioma?"
- "Quer que eu foque em algum aspecto específico da análise?"
