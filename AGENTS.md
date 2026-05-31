# Antigravity ADLC — Agent Rules

This file configures AI coding assistants (OpenCode, Codex, etc.) to use the ADLC skill pipeline.

## Slash Command Routing

When the user inputs a short command, read the corresponding Skill file **before** starting work:

| Command | Skill File |
|---|---|
| `/init` | `init/SKILL.md` |
| `/spec` | `spec/SKILL.md` |
| `/architect` | `architect/SKILL.md` |
| `/proceed` | `proceed/SKILL.md` |
| `/review` | `review/SKILL.md` |
| `/bugfix` | `bugfix/SKILL.md` |
| `/deploy` | `deploy/SKILL.md` |
| `/deploy-analyze` | `deploy-analyze/SKILL.md` |
| `/deploy-env` | `deploy-env/SKILL.md` |
| `/deploy-provision` | `deploy-provision/SKILL.md` |
| `/deploy-trigger` | `deploy-trigger/SKILL.md` |
| `/deploy-heal` | `deploy-heal/SKILL.md` |

Read the skill file fully before taking any action. The skill file is the single source of truth for how that pipeline step should be executed.

## Project Structure

```
.adlc/
  config.yml          # Stack config and automation levels
  context/            # Architecture and style conventions
  specs/              # Active specs and tasks
  knowledge/          # Compounding lessons and verified assumptions
```

## Core Ethos

See `ETHOS.md` for the agentic principles guiding all workflows.
