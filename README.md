# Antigravity ADLC Toolkit

Skills, agents, and templates for spec-driven development. Works with **Antigravity**, **OpenCode**, **Claude Code**, and any agent that reads `AGENTS.md`.

Designed to fully leverage native workspace tools (`write_to_file`, `multi_replace_file_content`, `generate_image`) for rapid, high-fidelity full-stack implementations with rich aesthetics.

## Supported Assistants

| Assistant | Config File | Setup Required |
|---|---|---|
| **Antigravity** (Gemini) | `~/.gemini/GEMINI.md` → project `.gemini/GEMINI.md` | Run `install.sh` / `install.ps1` once, then `/init` per project |
| **OpenCode** | `AGENTS.md` (this repo's root) | None — clone and use |
| **Claude Code** | `.claude/settings.json` | Scaffolded by `/init` |

## What's Included

### Core Pipelines & Native Actions

The toolkit provides specialized end-to-end workflows executed directly within your active workspace session. Below are the core interactions, documented directly from their respective skill definitions:

| Interaction | Description | When to Use | Execution Flow |
|---|---|---|---|
| **`/init`** | Bootstrap `.adlc/` structure in a new repo or subdirectory. | Setting up the `.adlc/` directory structure for spec-driven development. | Determine Target → Gather Context → Create Structure → Populate Context → Update `.gitignore` → Copy ETHOS & Templates → Scaffold Taxonomy → Scaffold Allowlist → Scaffold Gemini Rules → Scaffold Config → Summary |
| **`/spec`** | Write requirement specs from feature requests. | Writing a requirement spec following the spec-driven ADLC process. | Understand Request → Derive Query Tags → Unified Retrieval → Determine REQ ID → Create Spec → Present for Review |
| **`/architect`** | Design architecture and break requirement into tasks. | Designing architecture and breaking a requirement into implementable tasks. | Locate/Read Requirement → Explore Codebase → Design Architecture → Break Into Tasks → Update Status → Present for Review |
| **`/proceed`** | End-to-end ADLC pipeline that takes a requirement from spec through to deployed. | When the user says "proceed", "run the pipeline", "take REQ-xxx to completion", or wants to advance a drafted requirement all the way through to deployment in one shot. | Step 0 (Setup) → Phase 1 (Validate Spec) → Phase 2 (Architect) → Phase 3 (Validate Tasks) → Phase 4 (Implement) → Phase 5 (Verify) → Phase 6 (PR) → Phase 7 (Cleanup/CI) → Phase 8 (Wrapup) |
| **`/review`** | Multi-agent code review covering correctness, quality, architecture, test coverage, and security. | Performing a thorough code review of recent changes using multiple specialized review agents. | Determine Scope/Context → Read Changed Files → Launch Review Agents → Consolidate Findings → Present Review → Summary |
| **`/bugfix`** | End-to-end bug fix workflow — report, analyze, fix, verify, ship (PR + merge + deploy + knowledge capture). | Fixing a bug using a streamlined workflow that skips the full spec ceremony but follows the same deployment strategy as a feature. | Phase 1 (Report) → Phase 2 (Analyze) → Phase 3 (Fix) → Phase 4 (Verify) → Phase 5 (Ship) → Phase 6 (Wrapup) |
| **`/deploy`** | Auto-analyze, scaffold, deploy, and self‑heal applications on Coolify, Railway, AWS, or VPS (orchestrates sub‑skills). | Deploying applications with auto‑configuration and self‑healing runtime/build errors. | Parse Input → `/deploy-analyze` → `/deploy-env` → `/deploy-provision` → `/deploy‑trigger` → `/deploy‑heal` (loop) → Verification |
| **`/deploy-analyze`** | Analyze deployment target, infer environment and configuration. | Determining target platform, gathering current state before provisioning. | Inspect target, enumerate services, produce deployment plan. |
| **`/deploy-env`** | Configure environment variables, secrets, and service connections. | Setting up required env for deployment. | Resolve env vars, validate secrets, write `.env` files. |
| **`/deploy-provision`** | Provision resources (containers, databases, networking). | Creating infrastructure for the app. | Call provider APIs, spin up containers, set up DB. |
| **`/deploy-trigger`** | Trigger the actual build/deployment process. | Initiating build pipelines. | Execute build, stream logs, monitor startup. |
| **`/deploy‑heal`** | Diagnose and auto‑fix deployment failures. | When build/runtime errors occur. | Parse error logs, apply fixes, recommit, redeploy. |

## How it Works with Antigravity

Unlike legacy CLI approaches, this toolkit operates **natively within your chat session**:

1. **Deep Workspace Awareness**: Antigravity natively maps your `.adlc/` directory structure using lightning-fast workspace scanning.
2. **Precision Execution**: Code additions and modifications are dispatched via specialized code-editing tools, eliminating the risk of malformed streaming output.
3. **Visual Excellence Priority**: When dealing with web/mobile interfaces, Antigravity adheres to modern design principles (glassmorphism, curated palettes, micro-animations) to ensure premium deliverables.

## Initialization & Setup

### OpenCode (Zero Config)

OpenCode reads `AGENTS.md` at the repo root automatically. Clone and start using slash commands immediately — no setup required.

### Antigravity (One-Time Install)

Antigravity requires knowing where the toolkit lives. Run the install script **once** after cloning:

**macOS / Linux:**
```bash
chmod +x install.sh && ./install.sh
```

**Windows (PowerShell):**
```powershell
.\install.ps1
```

This writes `~/.gemini/GEMINI.md` with the correct absolute path to this toolkit. After that, use `/init` in any project to bootstrap it.

### Per-Project Setup (`/init`)

After the one-time install, run `/init` in each new project:

> *"ช่วย setup โครงสร้าง ADLC (init) ให้โปรเจกต์นี้หน่อย"*

`/init` scaffolds the full `.adlc/` structure **and** generates a project-local `.gemini/GEMINI.md` (gitignored, machine-specific). After `/init`, the project is self-sufficient — no global setup required for any subsequent command:

```
Clone toolkit → run install script (once)
                      ↓
         Open new project → /init
                      ↓
    Project gets .adlc/ + .gemini/GEMINI.md
                      ↓
  /spec, /architect, /proceed, /review ... ✅
  (no global setup needed anymore)
```

```text
.adlc/
  config.yml         # Core stack config and agentic automation levels
  context/           # Core architecture and style conventions
  specs/             # Active specifications and granular tasks
  knowledge/         # Compounding lessons and verified assumptions
```

## Core Ethos
See [`ETHOS.md`](ETHOS.md) for the agentic principles guiding these workflows.
