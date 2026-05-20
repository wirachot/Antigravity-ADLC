---
name: deploy-analyze
description: Analyze project codebase to identify tech stack, port, and databases, and scaffold Docker/Nixpacks configs
argument-hint: [Optional local path or Git repo URL]
---

# /deploy-analyze — Codebase DevOps Analysis & Scaffolding

You are executing the `/deploy-analyze` skill. Your task is to scan the project files to identify the technology stack, listen port, database dependencies, and scaffold optimized deployment configuration files.

## Ethos

!`sh .adlc/partials/ethos-include.sh 2>/dev/null || sh ~/.claude/skills/partials/ethos-include.sh`

## Input

Target Path/Git URL: $ARGUMENTS

## Instructions

### Step 1: Clone or Access Codebase
1. If a Git URL is provided:
   - Determine if the repository is public (e.g. check if it uses HTTPS, or verify if it can be accessed without authentication).
   - **For public repositories, do NOT ask the user for SSH keys or SSH configurations.** Clone it directly using HTTPS (convert SSH URLs to HTTPS if needed to avoid ssh-agent prompting).
   - For private repositories, request the appropriate deployment credentials (SSH key path, deploy token, or PAT) only if they are not already cached.
   - Clone the repository into a temporary directory within the workspace (e.g., `temp-deploy-src/`).
2. If no argument is provided, target the current workspace directory.

### Step 2: Tech Stack Detection
Analyze files to detect:
1. **Language & Runtime:**
   - JS/TS (Node.js): `package.json`, `pnpm-lock.yaml`, `yarn.lock`
   - Python: `requirements.txt`, `Pipfile`, `pyproject.toml`
   - Golang: `go.mod`
   - Ruby: `Gemfile`
   - Rust: `Cargo.toml`
2. **Ports Used:**
   - Scan code for common port references (e.g. `process.env.PORT`, `app.listen(`, `port:`, `EXPOSE` statements).
3. **Database Dependencies:**
   - Look for packages, imports, or configuration files indicating database use (e.g. `pg`, `mysql2`, `redis`, `mongodb`, `mongoose`, `prisma`, `sequelize`, `SQLAlchemy`).

### Step 3: Scaffold Deployment Configs
If the codebase does not already contain a `Dockerfile`, `docker-compose.yml`, or `nixpacks.toml`:
1. Generate an optimized `Dockerfile` suitable for production:
   - For Node.js/TS: Multi-stage build caching node_modules, executing build, and running lightweight runner.
   - For Python/Go/Rust: Compact, secure container.
2. If multi-service is needed, generate `docker-compose.yml` or `nixpacks.toml` to declare dependencies.
3. Save these files to the root of the targeted codebase.

### Step 4: Summary Output
Output the results in a clean markdown table:
- **Runtime Stack:** e.g., Node.js (TypeScript)
- **Detected Port:** e.g., 3000
- **Database Dependency:** e.g., PostgreSQL
- **Scaffolded Configs:** e.g., `Dockerfile` (created)
