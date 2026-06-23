---
name: review
description: Multi-agent code review covering correctness, quality, architecture, test coverage, and security
argument-hint: Optional file paths, branch name, or REQ/TASK ID to scope the review
---

# /review — Antigravity Code Review

You are performing a thorough code review of recent changes using specialized review checklists in your active session context.

This skill is the **pre-push ADLC review gate**. It runs 5 review checklists sequentially in-context, covering the same dimensions as the CI review workflow (correctness, conventions, test coverage, security) plus architecture. Running this before pushing ensures that issues are caught regardless of CI availability.

## Ethos

!`sh .adlc/partials/ethos-include.sh 2>/dev/null || sh ~/.claude/skills/partials/ethos-include.sh`

## Context

- Current branch: !`git branch --show-current 2>/dev/null || echo "Not a git repo"`
- Integration branch: !`git show-ref --verify --quiet refs/heads/staging && echo "staging" || echo "main"`
- Recent changes: !`git diff $(git show-ref --verify --quiet refs/heads/staging && echo "staging" || echo "main") --stat 2>/dev/null || echo "No diff available"`

**Context files loaded on demand**: `.adlc/context/conventions.md` and recent lessons are loaded by Step 1 below — **skip the Reads if they are already in the current conversation** (e.g., when invoked from `/proceed`).

## Input

Scope: $ARGUMENTS

## Prerequisites

Before proceeding, verify that `.adlc/context/conventions.md` exists. If it doesn't, stop and tell the user: "The `.adlc/` structure hasn't been initialized. Run `/init` first to set up conventions."

## Instructions

### Step 1: Determine Review Scope, Base Branch, and Load Context
1. Detect the integration base branch (check if `staging` exists locally or in origin, otherwise default to `main`). Let this be `<integration-branch>`.
2. If given specific file paths, review those files.
3. If given a branch name, review all changes on that branch vs `<integration-branch>`.
4. If given a REQ/TASK ID, find the associated branch and review its changes.
5. If no argument, review all uncommitted changes + commits on the current branch vs `<integration-branch>`.
6. Get the full diff: `git diff <integration-branch>...HEAD` (or `git diff` for uncommitted changes).
7. **Conventions**: if `.adlc/context/conventions.md` is NOT already in your conversation context, Read it now. Otherwise skip.
8. **Relevant lessons** (relevance-ranked based on touched components):
   a. Derive the set of touched **components** and **domains** from the diff file paths (e.g., `api/auth/*` → `API/auth`, `infrastructure/*` → `infra`).
   b. Glob `.adlc/knowledge/lessons/*.md` and read each file's frontmatter. Keep lessons where `component`, `domain`, or `tags` match the touched paths.
   c. If fewer than 5 entries, top it up with the most recently modified lessons until the set has up to 10 entries.
   d. Cap the final list at 15 lessons. Read their bodies in full and keep them in context. Cite their `id` if a finding matches.

### Step 2: Read All Changed Files
Read the complete current version of every changed file (not just the diff) to understand full context.

### Step 3: Run Review Checklists Sequentially In-Context
Since you are executing natively in **Antigravity**, perform the reviews sequentially in your current session context. Read each checklist definition from the `agents/` folder of the ADLC toolkit repository (located in the `../agents/` directory relative to this `review/SKILL.md` file):

1. **correctness-reviewer** (`../agents/correctness-reviewer.md`) — Focus: logic errors, null risks, race conditions, edge cases, async/concurrency bugs.
2. **quality-reviewer** (`../agents/quality-reviewer.md`) — Focus: naming, convention compliance, code duplication, complexity, maintainability.
3. **architecture-reviewer** (`../agents/architecture-reviewer.md`) — Focus: layering, separation of concerns, API contracts, module boundaries, scope discipline.
4. **test-auditor** (`../agents/test-auditor.md`) — Focus: test coverage gaps for the changed code, mock completeness, edge case coverage, test isolation.
5. **security-auditor** (`../agents/security-auditor.md`) — Focus: input validation, authentication/authorization gaps, data exposure, injection risks.

Evaluate the changed files against each checklist's criteria and collect structured findings (Critical/Major/Minor/Nit, file path, line number, and suggested fix).

### Step 4: Consolidate Findings
1. Collect results from all sequential checks.
2. Deduplicate overlapping findings.
3. Categorize by severity:
   - **Critical**: Must fix before merge (bugs, security, data loss, test gaps that hide regressions)
   - **Major**: Should fix before merge (convention violations, missing tests, architectural smells)
   - **Minor**: Nice to fix (style, naming, minor improvements)
   - **Nit**: Optional suggestions
4. Cross-reference findings against the loaded recent lessons — if a finding matches a known pitfall, escalate its severity by one level (e.g., Minor → Major). Flag this explicitly in the report.

### Step 5: Present Review
Display findings organized by file, then by severity within each file. Include a dimension summary at the top so the user can see which of the 5 dimensions have issues at a glance:

```
## Dimension Summary

| Dimension | Critical | Major | Minor | Nit | Gate |
|---|---|---|---|---|---|
| Correctness | 0 | 1 | 2 | 0 | PASS |
| Quality | 0 | 0 | 3 | 1 | PASS |
| Architecture | 0 | 2 | 0 | 0 | PASS |
| Test Coverage | 0 | 0 | 1 | 0 | PASS |
| Security | 0 | 0 | 0 | 0 | PASS |

**Overall gate: PASS / FAIL**

## file/path.js

### Critical
- Line XX: description of issue

### Major
- Line XX: description of issue
```

### Step 6: Summary
1. Overall gate: PASS (ready to merge) / FAIL (fix criticals first) / RESHAPE (significant rework needed)
2. Count of issues by severity and by dimension
3. Top 3 most important things to address
4. Any findings that matched recent lessons (elevated-severity items)
5. If changes look good, say so clearly — an empty review is a valid result.
