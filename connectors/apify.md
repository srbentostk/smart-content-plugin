# Conector: Apify

## O que é
Apify é uma plataforma de web scraping com actors prontos para extrair dados de redes sociais.

## Por que precisa
- Instagram e TikTok não têm API pública para extrair transcrições/comentários
- Apify oferece actors especializados que fazem isso de forma confiável

## Como configurar

### 1. Criar conta
- Acesse https://apify.com e crie conta gratuita
- Plano grátis: $5/mês em créditos (suficiente para ~50-100 extrações)

### 2. Obter API key
- Settings → Integrations → Personal API Tokens
- Copie o token

### 3. Configurar no Sofia
- Edite `knowledge/config.yaml`
- Cole em `apify_api_key: "seu-token"`
- Ou defina `APIFY_API_KEY` como variável de ambiente

## Actors utilizados

### Instagram
| Actor | Uso | Crédito/run |
|-------|-----|-------------|
| `apify/instagram-scraper` | Dados do post (caption, métricas) | ~$0.01 |
| `apify/instagram-comment-scraper` | Comentários ordenados | ~$0.02 |

### TikTok
| Actor | Uso | Crédito/run |
|-------|-----|-------------|
| `clockworks/tiktok-scraper` | Dados do vídeo | ~$0.01 |
| `clockworks/tiktok-comments-scraper` | Comentários | ~$0.02 |

## Custo estimado
- 1 análise completa (post + comentários): ~$0.03
- 100 análises/mês: ~$3.00
- Dentro do plano grátis para uso moderado

## Uso via MCP (Claude Code)
Se o Apify MCP está instalado, os agentes usam diretamente:
```
mcp__Apify__call-actor(actorId, input)
mcp__Apify__get-actor-output(runId)
```

## Uso via CLI (outros ambientes)
```bash
curl -X POST "https://api.apify.com/v2/acts/apify~instagram-scraper/runs" \
  -H "Authorization: Bearer $APIFY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"directUrls": ["URL"], "resultsLimit": 1}'
```
