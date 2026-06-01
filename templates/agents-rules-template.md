# Antigravity ADLC — Agent Rules

This file configures AI coding assistants (OpenCode, Codex, etc.) to use the ADLC skill pipeline.

## Slash Command Routing

When the user inputs a short command, read the corresponding Skill file **before** starting work:

| Command | Skill File |
|---|---|
| `/init` | `ADLC_TOOLKIT_PATH/init/SKILL.md` |
| `/spec` | `ADLC_TOOLKIT_PATH/spec/SKILL.md` |
| `/architect` | `ADLC_TOOLKIT_PATH/architect/SKILL.md` |
| `/proceed` | `ADLC_TOOLKIT_PATH/proceed/SKILL.md` |
| `/review` | `ADLC_TOOLKIT_PATH/review/SKILL.md` |
| `/bugfix` | `ADLC_TOOLKIT_PATH/bugfix/SKILL.md` |
| `/deploy` | `ADLC_TOOLKIT_PATH/deploy/SKILL.md` |
| `/deploy-analyze` | `ADLC_TOOLKIT_PATH/deploy-analyze/SKILL.md` |
| `/deploy-env` | `ADLC_TOOLKIT_PATH/deploy-env/SKILL.md` |
| `/deploy-provision` | `ADLC_TOOLKIT_PATH/deploy-provision/SKILL.md` |
| `/deploy-trigger` | `ADLC_TOOLKIT_PATH/deploy-trigger/SKILL.md` |
| `/deploy-heal` | `ADLC_TOOLKIT_PATH/deploy-heal/SKILL.md` |

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
