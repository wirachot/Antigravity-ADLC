# Antigravity ADLC Toolkit

Skills, agents, and templates for spec-driven development tailored specifically for **Antigravity** (Advanced Agentic Coding Assistant). 

Designed to fully leverage native workspace tools (`write_to_file`, `multi_replace_file_content`, `generate_image`) for rapid, high-fidelity full-stack implementations with rich aesthetics.

## What's Included

### Core Pipelines & Native Actions

The toolkit provides specialized end-to-end workflows executed directly within your active workspace session. Below are the details of each action, highlighting their native behaviors, ideal use cases, and underlying execution flows.

#### 1. `/init` — Bootstrap ADLC Structure
- **Native Behavior**: Uses `write_to_file` to instantly drop standard project blueprints and config schemas.
- **When to Use**: Use when starting a new project or onboarding an existing repository to the spec-driven ADLC workflow. Supports both standalone repositories (single-repo) and interconnected multi-repo environments.
- **Execution Flow**:
  1. **Context Gathering**: Audits the target directory and requests standard project context (Name, Description, Tech Stack, Scope, and Architecture).
  2. **Scaffold Layout**: Generates the standard `.adlc/` infrastructure (`context/`, `specs/`, `bugs/`, and `knowledge/` directories).
  3. **Template Injection**: Drops canonical templates (`ETHOS.md`, task/spec blueprints) and contextual baselines (`conventions.md`, `taxonomy.md`), along with base permissions in `.claude/settings.json`.
  4. **Cross-Repo Integration** *(Optional)*: Configures `.adlc/config.yml` to map interconnected sibling repositories for synchronized features.

#### 2. `/spec` — Requirement Specification
- **Native Behavior**: Establishes `REQ-xxx.md` with explicit data models, constraints, and acceptance criteria.
- **When to Use**: Use when receiving a new feature request. It translates ambiguous human requirements into rigorous, actionable specifications before code implementation begins.
- **Execution Flow**:
  1. **Context Grounding**: Ingests foundational guidelines from `project-overview.md` and `architecture.md`.
  2. **Unified Retrieval**: Derives query tags (component, domain, stack, etc.) to fetch highly relevant historical lessons and resolved bugs as functional context.
  3. **ID Assignment**: Allocates a unique requirement identifier via a global atomic counter (`REQ-xxx`).
  4. **Spec Authoring**: Scaffolds `.adlc/specs/REQ-xxx-slug/requirement.md`, rigorously detailing the System Model, explicit Business Rules, Acceptance Criteria, and retrieved context citations.
  5. **Review Gate**: Surfaces the completed spec for human validation and refinement before proceeding to architecture.

#### 3. `/architect` — Architecture & Task Breakdown
- **Native Behavior**: Breaks workloads into structured implementation tasks forming a Directed Acyclic Graph (DAG) with explicit file routing.
- **When to Use**: Use once a requirement spec (`REQ-xxx`) is approved. It designs the technical implementation plan and breaks the workload into granular, executable tasks.
- **Execution Flow**:
  1. **Grounding**: Loads the validated spec and active coding conventions (`conventions.md`).
  2. **Codebase Exploration**: Dispatches parallel sub-agents (Feature Tracer, Architecture Mapper, Integration Explorer) to trace integration points and file layer impacts.
  3. **System Design**: Documents technical approaches and records core decisions via Architectural Decision Records (ADRs).
  4. **Task Breakdown**: Establishes discrete `TASK-xxx-description.md` files structured into a Directed Acyclic Graph (DAG) representing dependencies. Defines precise files to create or modify (routed by target repository in cross-repo mode).
  5. **Pipeline Advancement**: Promotes the requirement status to `approved` and outputs a clear implementation sequence.

#### 4. `/proceed` — End-to-End Autonomous Pipeline
- **Native Behavior**: Orchestrates multi-file edits, tracks task completion states, and handles automatic revision loops.
- **When to Use**: Use to drive an approved requirement autonomously from spec to pull request. It coordinates implementations, automates multi-agent reviews, and handles cross-repo merges with minimal intervention.
- **Execution Flow**:
  1. **Phase 0 (Setup)**: Validates prerequisites, resolves absolute workspace targets, creates parallel Git worktrees per touched repository, and initializes tracking in `pipeline-state.json`.
  2. **Phase 1–3 (Validate)**: Runs pre-flight validation gates over the spec and task architecture, applying automated revisions if issues are caught.
  3. **Phase 4 (Implement)**: Executes tasks sequentially or in parallel tiers based on DAG dependencies. Operates strictly within target repository worktrees, validating code with native test suites.
  4. **Phase 5 (Verify)**: Dispatches parallel review agents across 5 distinct dimensions (Correctness, Quality, Architecture, Test Coverage, Security) along with self-reflection. Consolidates findings and applies atomic fixes in a unified pass.
  5. **Phase 6–8 (Ship & Wrapup)**: Pushes branches, creates localized Pull Requests with cross-repo links, monitors CI checks, executes merges in dependency order, captures compounding code lessons, and removes temporary worktrees.

#### 5. `/review` — Multi-Agent Code Review
- **Native Behavior**: Cross-references real-time code diffs against `conventions.md` to ensure absolute alignment.
- **When to Use**: Use as a pre-push quality gate to audit modified files or specific branches against standard team conventions and architectural boundaries.
- **Execution Flow**:
  1. **Context Scoping**: Identifies target diffs and matches affected components against active repository knowledge items.
  2. **Parallel Audit**: Triggers 5 specialized reviewer agents simultaneously to assess Correctness, Code Quality, Architecture limits, Test completeness, and Security postures.
  3. **Consolidation**: Deduplicates overlapping agent findings, sorting them by severity (Critical, Major, Minor, Nit). Automatically elevates severity if an issue repeats a known historical lesson.
  4. **Gate Report**: Presents a visual markdown dashboard indicating an overall `PASS` or `FAIL` status (blocking execution if Critical findings remain).

#### 6. `/bugfix` — Scoped Root-Cause Resolution
- **Native Behavior**: Employs exact content replacement tools to ensure side-effect-free root-cause remediation.
- **When to Use**: Use to resolve isolated runtime errors, test failures, or reported system bugs. It bypasses full specification ceremonies while enforcing a production-grade review and deployment lifecycle.
- **Execution Flow**:
  1. **Phase 1 (Report)**: Allocates a unique `BUG-xxx` identifier and constructs a standard issue report tracking reproduction steps and affected repositories.
  2. **Phase 2 (Analyze)**: Spawns exploratory agents to trace execution flows, document true root causes (beyond surface symptoms), and validate remediation plans.
  3. **Phase 3–4 (Fix & Verify)**: Executes targeted drop-in content replacements in target worktrees and verifies logic natively against package test suites.
  4. **Phase 5 (Ship)**: Commits updates and opens dedicated PRs across touched code repositories, monitoring check statuses.
  5. **Phase 6 (Wrapup)**: Merges approved PRs, verifies traffic routing/deployment baselines across Staging and Production endpoints, documents a compounding lesson in `.adlc/knowledge/`, and cleans up branches.

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
