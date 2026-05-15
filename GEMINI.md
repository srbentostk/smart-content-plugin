# Sofia 2.0 — Instruções para Gemini CLI

## Mapeamento de tools

| Claude Code | Gemini CLI | Uso |
|-------------|-----------|-----|
| `Read` | `read_file` | Ler references, knowledge, templates |
| `Write` | `write_file` | Salvar análises e roteiros |
| `Edit` | `edit_file` | Atualizar knowledge base |
| `Bash` | `shell` | Executar scripts (yt-dlp, etc.) |
| `Agent` | `activate_skill` | Ativar agentes especializados |
| `AskUserQuestion` | resposta direta | Perguntas ao usuário |

## Skills disponíveis

As skills em `skills/` são ativadas por linguagem natural:
- "Analisa esse vídeo" → `skills/analisar-video.md`
- "Escreve um roteiro" → `skills/escrever-roteiro.md`
- "Faz uma crítica" → `skills/critica-roteiro.md`
- "Melhora esse roteiro" → `skills/melhorar-roteiro.md`
- "Mostra a dashboard" → `skills/dashboard.md`
- "Configura o Sofia" → `skills/setup.md`

## Agentes

Os agentes em `agents/` contêm prompts completos. Para usar:
1. Leia o arquivo do agente relevante
2. Siga as instruções como system prompt para aquela tarefa
3. Referencie `references/` conforme indicado no agente

## Referências obrigatórias

Antes de qualquer tarefa de escrita ou análise, leia:
- `references/principios.md` — framework completo
- `references/regras-universais.md` — regras que nunca quebrar
