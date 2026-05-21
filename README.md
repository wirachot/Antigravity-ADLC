# Antigravity ADLC Toolkit

Skills, agents, and templates for spec-driven development tailored specifically for **Antigravity** (Advanced Agentic Coding Assistant). 

Designed to fully leverage native workspace tools (`write_to_file`, `multi_replace_file_content`, `generate_image`) for rapid, high-fidelity full-stack implementations with rich aesthetics.

## What's Included

### Core Pipelines & Native Actions

The toolkit provides specialized end-to-end workflows executed directly within your active workspace session. Below are the core interactions, documented directly from their respective skill definitions:

| Interaction | Description | When to Use | Execution Flow |
|---|---|---|---|
| **`/init`** | Bootstrap `.adlc/` structure in a new repo or subdirectory. | Setting up the `.adlc/` directory structure for spec-driven development. | Determine Target → Gather Context → Create Structure → Populate Context → Update `.gitignore` → Copy ETHOS & Templates → Scaffold Taxonomy → Scaffold Allowlist → Scaffold Config → Summary |
| **`/spec`** | Write requirement specs from feature requests. | Writing a requirement spec following the spec-driven ADLC process. | Understand Request → Derive Query Tags → Unified Retrieval → Determine REQ ID → Create Spec → Present for Review |
| **`/architect`** | Design architecture and break requirement into tasks. | Designing architecture and breaking a requirement into implementable tasks. | Locate/Read Requirement → Explore Codebase → Design Architecture → Break Into Tasks → Update Status → Present for Review |
| **`/proceed`** | End-to-end ADLC pipeline that takes a requirement from spec through to deployed. | When the user says "proceed", "run the pipeline", "take REQ-xxx to completion", or wants to advance a drafted requirement all the way through to deployment in one shot. | Step 0 (Setup) → Phase 1 (Validate Spec) → Phase 2 (Architect) → Phase 3 (Validate Tasks) → Phase 4 (Implement) → Phase 5 (Verify) → Phase 6 (PR) → Phase 7 (Cleanup/CI) → Phase 8 (Wrapup) |
| **`/review`** | Multi-agent code review covering correctness, quality, architecture, test coverage, and security. | Performing a thorough code review of recent changes using multiple specialized review agents. | Determine Scope/Context → Read Changed Files → Launch Review Agents → Consolidate Findings → Present Review → Summary |
| **`/bugfix`** | End-to-end bug fix workflow — report, analyze, fix, verify, ship (PR + merge + deploy + knowledge capture). | Fixing a bug using a streamlined workflow that skips the full spec ceremony but follows the same deployment strategy as a feature. | Phase 1 (Report) → Phase 2 (Analyze) → Phase 3 (Fix) → Phase 4 (Verify) → Phase 5 (Ship) → Phase 6 (Wrapup) |
| **`/deploy`** | Auto-analyze, scaffold, deploy, and self-heal applications on Coolify, Railway, AWS, or VPS (orchestrates sub-skills). | Deploying applications with auto-configuration and self-healing runtime/build errors. | Parse Input → `/deploy-analyze` → `/deploy-env` → `/deploy-provision` → `/deploy-trigger` → `/deploy-heal` (loop) → Verification |

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

## Global Setup (Enabling Short Commands)

To achieve a seamless, short-command developer experience across all your repositories and chat sessions without typing full file paths, configure Antigravity's **Global Setup** once:

1. Create or open the global rules file at **`~/.gemini/GEMINI.md`** (or create project-specific rules in **`.agent/rules/`** within your workspace).
2. Paste the following routing configuration (adjust the path to match your local clone of `adlc-toolkit`):

```markdown
When the user inputs a short command, always execute the `view_file` tool in the background with `IsSkillFile: true` pointing to the corresponding Skill file before starting work:
- `/init` -> Read the file `<PROJECT_ROOT>/init/SKILL.md`
- `/spec` -> Read the file `<PROJECT_ROOT>/spec/SKILL.md`
- `/architect` -> Read the file `<PROJECT_ROOT>/architect/SKILL.md`
- `/proceed` -> Read the file `<PROJECT_ROOT>/proceed/SKILL.md`
- `/review` -> Read the file `<PROJECT_ROOT>/review/SKILL.md`
- `/bugfix` -> Read the file `<PROJECT_ROOT>/bugfix/SKILL.md`
- `/deploy` -> Read the file `<PROJECT_ROOT>/deploy/SKILL.md`
- `/deploy-analyze` -> Read the file `<PROJECT_ROOT>/deploy-analyze/SKILL.md`
- `/deploy-env` -> Read the file `<PROJECT_ROOT>/deploy-env/SKILL.md`
- `/deploy-provision` -> Read the file `<PROJECT_ROOT>/deploy-provision/SKILL.md`
- `/deploy-trigger` -> Read the file `<PROJECT_ROOT>/deploy-trigger/SKILL.md`
- `/deploy-heal` -> Read the file `<PROJECT_ROOT>/deploy-heal/SKILL.md`
```

With this configuration active, Antigravity will automatically internalize the appropriate background skill file whenever you type short commands like `/spec` or `/proceed`, adhering perfectly to the ADLC pipeline workflow.

## Core Ethos
See [`ETHOS.md`](ETHOS.md) for the agentic principles guiding these workflows.
