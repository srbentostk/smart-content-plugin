# Conector: Obsidian Vault

## Estrutura de output

Todo output do Sofia 2.0 é salvo como arquivos Markdown com frontmatter YAML, compatíveis com Obsidian.

## Organização de pastas

```
{vault_path}/Sofia/
├── Pesquisas/
│   └── {nome-do-criador}/
│       └── {titulo-do-video}/
│           ├── roteiro-anotado.md
│           ├── hook.md
│           ├── comentarios.md
│           ├── metricas.md
│           └── aprendizados.md
│
├── Roteiros/
│   └── {YYYY-MM-DD}-{titulo}/
│       ├── roteiro-v1.md
│       ├── roteiro-v2.md
│       ├── critica.md
│       └── versao-final.md
│
├── Knowledge/
│   ├── hooks-que-funcionam.md
│   ├── padroes-aprendidos.md
│   └── elementos-viciantes.md
│
└── Dashboard/
    ├── index.md
    └── dashboard.html
```

## Configuração

### Auto-detecção
O setup tenta encontrar o vault automaticamente:
```bash
find ~ -name ".obsidian" -maxdepth 4 -type d 2>/dev/null
```

### Manual
Definir em `knowledge/config.yaml`:
```yaml
obsidian_vault_path: "/caminho/completo/para/seu/vault"
```

## Convenções de nomenclatura

- **Criadores:** slug do nome (lowercase, hifens): `nutri-das-estrelas`
- **Títulos:** primeiras 5-6 palavras slug: `empresario-mentiroso-faturou-bilhoes`
- **Datas:** formato ISO: `2026-05-14`

## Frontmatter padrão

Todos os arquivos incluem:
```yaml
---
title: ""
tags: [sofia, ...]
created: "YYYY-MM-DD"
---
```

## Integração com Obsidian

- Tags permitem filtrar por tipo (analise, roteiro, hook, insight)
- Wikilinks conectam análises a roteiros inspirados nelas
- Dataview pode agregar dados dos frontmatters
- Graph view mostra conexões entre análises e roteiros
