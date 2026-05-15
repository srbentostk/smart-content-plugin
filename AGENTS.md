# Sofia 2.0 — Instruções para Agent SDK

## Arquitetura de agentes

O Sofia 2.0 usa 6 agentes especializados orquestrados por skills.

### Orquestração

```
Skill (entry point)
  └── detecta qual agente(s) ativar
       ├── pesquisador (extração de dados)
       ├── analista-de-principios (análise frase a frase)
       ├── critico (avaliação honesta)
       ├── roteirista (escrita guiada)
       ├── melhorador (reescrita pós-crítica)
       └── aprendiz (evolução da base)
```

### Implementação com Agent SDK

Cada arquivo em `agents/` contém o system prompt completo do agente. Para implementar:

```python
from anthropic import Agent

pesquisador = Agent(
    name="pesquisador",
    system=open("agents/pesquisador.md").read(),
    tools=["bash", "apify", "read", "write"]
)

analista = Agent(
    name="analista-de-principios",
    system=open("agents/analista-de-principios.md").read(),
    tools=["read"]  # só precisa ler references
)

# Orquestração
async def analisar_video(url):
    dados = await pesquisador.run(f"Extraia dados de: {url}")
    analise = await analista.run(f"Analise: {dados}")
    return analise
```

### Contexto obrigatório

Todos os agentes devem ter acesso a:
- `references/principios.md` — como contexto base
- `references/regras-universais.md` — como guardrails
- `knowledge/` — como memória de longo prazo

### Tools por agente

| Agente | Tools necessários |
|--------|------------------|
| pesquisador | bash, apify MCP, write |
| analista-de-principios | read (references) |
| critico | read (references, checklists) |
| roteirista | read (references, knowledge, estruturas) |
| melhorador | read, write |
| aprendiz | read, write, edit |
