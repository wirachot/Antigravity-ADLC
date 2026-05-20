---
name: deploy-env
description: Identify required environment variables, prompt user for inputs/secrets, and prepare environment config
argument-hint: [Optional target codebase path]
---

# /deploy-env — Environment Variables Setup

You are executing the `/deploy-env` skill. Your task is to identify all required environment variables in the codebase and help the user configure them.

## Ethos

!`sh .adlc/partials/ethos-include.sh 2>/dev/null || sh ~/.claude/skills/partials/ethos-include.sh`

## Input

Target Path: $ARGUMENTS

## Instructions

### Step 1: Scan for Environment Variables
1. Search the target codebase for:
   - Example/template env files: `.env.example`, `.env.template`, `.env.local`
   - Code patterns: `process.env.VARIABLE_NAME`, `os.environ.get('VARIABLE_NAME')`, `os.Getenv("VARIABLE_NAME")`
2. Compile a unique list of all identified environment variables.

### Step 2: Categorize Variables
Group the identified variables into:
- **Database/Service Connection URLs:** (e.g. `DATABASE_URL`, `REDIS_URL`)
- **System Settings:** (e.g. `PORT`, `NODE_ENV`, `LOG_LEVEL`)
- **Secrets/Credentials:** (e.g. `API_KEY`, `JWT_SECRET`, `AWS_ACCESS_KEY_ID`)

### Step 3: Gather Input & Configure
1. Present the discovered list of environment variables in a clean markdown table.
2. Cross-check if any default values are provided (e.g., from `.env.example`).
3. For secret/credential fields, prompt the user to input the value, or automatically generate strong placeholders (such as passwords or JWT keys) and confirm with the user.
4. Prepare the final list of resolved key-value pairs (to be handed off to the deployment target).

### Step 4: Summary Output
Output the compiled environment configuration keys (redacting actual values of secrets in display for security) and confirm readiness for deployment.
