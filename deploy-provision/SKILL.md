---
name: deploy-provision
description: Provision application and databases on Cloud providers (Coolify API, Railway) or direct VPS target
argument-hint: [Target provider/destination details]
---

# /deploy-provision — Cloud & VPS Resource Provisioning

You are executing the `/deploy-provision` skill. Your task is to communicate with the cloud provider (e.g., Coolify REST API, Railway CLI) or connect via SSH to a VPS to set up databases, register the application, configure ports, domains, and environment variables.

## Ethos

!`sh .adlc/partials/ethos-include.sh 2>/dev/null || sh ~/.claude/skills/partials/ethos-include.sh`

## Input

Target & Resolved Variables: $ARGUMENTS

## Instructions

### Step 1: Authenticate and Connect
1. Resolve target provider from input (e.g., Coolify API target, Railway, VPS SSH).
2. Fetch the required authentication token (e.g. `COOLIFY_API_KEY`, SSH key paths) from environment or configuration. Halt if missing credentials.

### Step 2: Provision Databases (If Required)
If database requirements were detected in the analysis phase:
1. **Coolify:**
   - Query Coolify API to check if a suitable database service (e.g. PostgreSQL, Redis) exists in the targeted project/destination.
   - If not, call the Coolify API to create and provision the database service. Save the connection details.
2. **VPS (SSH):**
   - SSH into the VPS and inspect running containers (`docker ps`).
   - If needed, spin up database containers using Docker Compose.
3. **Railway/AWS:**
   - Provision DB resources using CLI or Terraform/API templates.

### Step 3: Register and Configure Application
1. Register/create the Application targeting the Git repository URL.
   - **For public repositories, configure the deployment platform to pull via public HTTPS without requiring or prompting for SSH keys.**
   - For private repositories, set up the required SSH deploy key or API access tokens.
2. Configure application settings:
   - Set the public domain name (e.g., `wowmom-adlc.lanna.engineer`).
   - Configure exposure ports (routing traffic from 80/443 to target container port, e.g., 3000).
   - Inject the complete list of environment variables (including database connection strings generated in Step 2).

### Step 4: Summary Output
Provide a provisioning report showing:
- **Project/Destination ID:**
- **App Resource ID:**
- **Database Status:** Connected / Running
- **Assigned Domain:**
- **Status:** Provisioned & ready to deploy
