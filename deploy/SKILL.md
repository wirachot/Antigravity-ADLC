---
name: deploy
description: Auto-analyze, scaffold, deploy, and self-heal applications on Coolify, Railway, AWS, or VPS
argument-hint: [Optional target domain, VPS address, or Git repo URL]
---

# /deploy — AI DevOps & Auto-Deployment

You are executing the `/deploy` skill, acting as a personal DevOps agent to analyze code, configure the environment, trigger deployment, and self-heal any runtime or build failures.

## Ethos

!`sh .adlc/partials/ethos-include.sh 2>/dev/null || sh ~/.claude/skills/partials/ethos-include.sh`

## Context

- Deployment config: !`cat .adlc/config.yml 2>/dev/null || echo "No cross-repo / deployment config found"`
- Active spec: !`grep -rl 'status: in-progress' .adlc/specs/*/requirement.md 2>/dev/null | head -1 || echo "No active spec"`

## Input

Target/Arguments: $ARGUMENTS

## Prerequisites

1. Ensure the workspace git tree is clean (unless the deployment is for a target git repo specified in the arguments).
2. If utilizing Coolify, ensure `COOLIFY_API_KEY` is present in the environment or available in config.

## Instructions

### Step 1: Parse Input & Resolve Target
1. Parse the target domain, VPS connection details, or Git repository from `$ARGUMENTS`.
2. Read `.adlc/config.yml` if it exists to retrieve any predefined deployment settings under `deploy:` or `services:`.
3. If no target is specified, prompt the user to confirm the deploy target (e.g., Coolify, Railway, AWS, or direct VPS).

### Step 2: Code Analysis & Scaffolding
1. Analyze the codebase to detect the primary technology stack (e.g., Node.js/TypeScript, Python, Golang, PHP, Ruby).
2. Detect the runtime port by scanning file entrypoints (e.g., `app.listen(`, `PORT || 3000`, `EXPOSE` in Dockerfile).
3. Identify database requirements (e.g., checking `package.json`, `requirements.txt`, imports for `pg`, `mysql2`, `redis`, `mongoose`).
4. **Scaffold Deployment Configs (BR-1):**
   - If no Dockerfile, `docker-compose.yml`, or `nixpacks.toml` is found:
     - Generate a production-ready, highly optimized `Dockerfile` (multi-stage builds for JS/TS/Go/Rust, optimized caching) or `docker-compose.yml`.
     - Save the generated files to the workspace root.
   - If they already exist, review them for correctness and suggest improvements.

### Step 3: Auto Environment Variables Setup
1. Scan for environment variables in:
   - `.env.example`, `.env.local`, `.env` files.
   - Code occurrences of `process.env.*`, `os.environ.get()`, `os.Getenv()`.
2. Extract a complete list of required environment variables.
3. Compare the list with the active deployment target's configured variables (if accessible via API/SSH).
4. Present a list of missing variables to the user.
5. If secrets are needed (e.g., database passwords, secret keys), **prompt the user or generate secure placeholders** and ask the user to fill them.

### Step 4: Provision Services & Integration
1. **Coolify Integration:**
   - Call Coolify API using the token in `COOLIFY_API_KEY` to:
     - Check if the project and destination exist.
     - Provision any required database services (e.g., PostgreSQL, Redis) if not already created.
     - Create a new Application pointing to the repository's Git URL.
     - Set the application port, domain name, and environment variables via Coolify API endpoints.
2. **Direct VPS (SSH) Integration:**
   - Establish SSH connection to the target VPS (using SSH keys or prompting for access).
   - Verify if Docker, Docker Compose, or Nixpacks is installed on the VPS. If not, suggest commands to install.
   - Setup project directories and deploy configurations on the VPS.
3. **Railway/AWS Integration:**
   - Trigger API/CLI calls to configure the cloud services.

### Step 5: Trigger Deploy & Stream Logs
1. Trigger the deployment process (via Coolify deploy API, Git push to Railway/AWS, or docker-compose up via SSH).
2. Fetch and stream the build logs in real-time.
3. If the build completes, monitor the runtime logs for container startup.
4. Perform an initial health check by fetching the application domain.

### Step 6: Self-Healing & Auto-Correction (BR-2 — Critical DevOps Loop)
If the build fails or the runtime crashes (e.g., Nginx 502, crash loops, database connection timeout):
1. **Fetch Logs:** Pull the complete build log or container runtime log.
2. **Analyze Failure:** Feed the logs to the LLM context to determine the exact failure reason (e.g., missing package, port mismatch, bad environment variable, database connection string format).
3. **Execute Auto-Fix:**
   - **Configuration / Code Fix:** Edit the codebase or configurations automatically using `replace_file_content` or `multi_replace_file_content` (e.g., update the port, add missing import, correct DB url, update package.json).
   - **Git Commit & Push:**
     - Commit the fix to the repository: `git commit -m "chore(deploy): auto-heal - [failure description]"`
     - Push the commit to trigger a rebuild on the cloud provider.
4. **Iterate:** Repeat Step 5 and 6. Allow up to **3 auto-heal attempts**. If it still fails, halt and present the parsed logs and proposed fixes to the user for manual guidance.

### Step 7: Final Verification & Handover
1. Verify the application is fully functional by sending a HTTP GET request to the target domain.
2. Output a summary table of the deployment:
   - **Status:** Success / Active
   - **Domain:** [Clickable Link]
   - **Exposed Port:** e.g., 3000
   - **Database:** e.g., Connected to PostgreSQL
   - **Auto-healed issues:** List of issues fixed during the run (if any)

## Quality Checklist

- [ ] Tech stack and ports are accurately identified.
- [ ] Dockerfile/nixpacks configuration is correct and present in the repo.
- [ ] All required environment variables are listed and set.
- [ ] Database services are provisioned and connected.
- [ ] Self-healing loop executes no more than 3 times to prevent infinite push/redeploy loops.
- [ ] Application returns HTTP 200 OK on health check.
