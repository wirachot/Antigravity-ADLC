# Antigravity ADLC Toolkit

Skills, agents, and templates for spec-driven development tailored specifically for **Antigravity** (Advanced Agentic Coding Assistant). 

Designed to fully leverage native workspace tools (`write_to_file`, `multi_replace_file_content`, `generate_image`) for rapid, high-fidelity full-stack implementations with rich aesthetics.

## What's Included

### Core Pipelines & Native Actions

| Interaction | Description | Native Antigravity Behavior |
|-------|-------------|---------------------------|
| `/init` | Bootstrap `.adlc/` structure | Uses `write_to_file` to instantly drop standard templates |
| `/spec` | Requirement engineering | Establishes `REQ-xxx.md` with explicit data models and constraints |
| `/architect` | System design & Task breakdown | Breaks tasks and utilizes `generate_image` for stunning UI mockups |
| `/proceed` | End-to-end autonomous pipeline | Orchestrates multi-file edits and tracks task completion state |
| `/review` | Quality & alignment audit | Cross-references real-time code diffs against `conventions.md` |
| `/bugfix` | Scoped root-cause resolution | Employs exact content replacement to prevent side effects |

## How it Works with Antigravity

Unlike legacy CLI approaches, this toolkit operates **natively within your chat session**:

1. **Deep Workspace Awareness**: Antigravity natively maps your `.adlc/` directory structure using lightning-fast workspace scanning.
2. **Precision Execution**: Code additions and modifications are dispatched via specialized code-editing tools, eliminating the risk of malformed streaming output.
3. **Visual Excellence Priority**: When dealing with web/mobile interfaces, Antigravity adheres to modern design principles (glassmorphism, curated palettes, micro-animations) to ensure premium deliverables.

## Initialization & Setup

To initialize any code repository for Antigravity ADLC:

1. Simply prompt the assistant in your active project workspace:
   > *"ช่วย setup โครงสร้าง ADLC (init) ให้โปรเจกต์นี้หน่อย"*
2. Antigravity will instantly generate the clean standard layout:
   ```text
   .adlc/
     config.yml         # Core stack config and agentic automation levels
     context/           # Core architecture and style conventions
     specs/             # Active specifications and granular tasks
     knowledge/         # Compounding lessons and verified assumptions
   ```
3. Configure your stack parameters in `.adlc/config.yml` to unlock fully automated code adjustments.

## Core Ethos
See [`ETHOS.md`](ETHOS.md) for the agentic principles guiding these workflows.
