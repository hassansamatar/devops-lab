# Terraform Remote State Setup (Azure Backend)

> End-to-end Terraform remote backend setup using Azure Storage Account and WSL Ubuntu.

---

# Overview

This guide configures a complete Terraform remote state backend on Microsoft Azure using:

- WSL2 Ubuntu
- Azure CLI
- Terraform
- Azure Storage Account
- Azure Blob Container

The setup follows a production-style Infrastructure-as-Code (IaC) workflow using remote Terraform state management.

---

# Why Remote State Matters

Remote state is critical for professional Terraform workflows because it:

- Prevents local state conflicts
- Enables team collaboration
- Centralizes infrastructure tracking
- Supports CI/CD automation
- Enables state locking
- Protects infrastructure consistency

---

# Architecture

```text
+----------------------+
| Terraform (WSL)      |
| Ubuntu Linux         |
+----------+-----------+
           |
           v
+----------------------+
| Azure Resource       |
| Manager (ARM)        |
+----------+-----------+
           |
           v
+----------------------+
| Azure Storage Account|
| Terraform Backend    |
+----------+-----------+
           |
           v
+----------------------+
| Blob Container       |
| terraform-state      |
+----------+-----------+
           |
           v
+----------------------+
| dev.terraform.tfstate|
| Remote State File    |
+----------------------+
Prerequisites

Before starting, ensure you have:

System Requirements
Windows 10/11
WSL2 enabled
Ubuntu installed
Internet connection
Required Tools

Installed inside WSL Ubuntu:

Azure CLI
Terraform (>= 1.5 recommended)
Git
Azure Requirements
Active Azure subscription
Owner or Contributor access
Project Structure
devops-lab/
├── docs/
├── terraform/
│   ├── environments/
│   │   └── dev/
│   │       ├── backend.tf
│   │       ├── main.tf
│   │       ├── providers.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   │
│   ├── modules/
│   ├── scripts/
│   └── tests/
│
├── .github/
└── README.md
Step 1 — Login to Azure

Use device login authentication inside WSL:

az login --use-device-code --tenant <TENANT_ID>

Steps:

Open browser:
https://microsoft.com/devicelogin
Enter the device code shown in terminal
Sign in with Azure account
Select correct subscription
Verify Azure Login
az account show
Set Active Subscription
az account set --subscription <SUBSCRIPTION_ID>
Step 2 — Create Backend Infrastructure
Create Resource Group
az group create \
  --name tfstate-rg \
  --location westeurope
Create Storage Account

Storage account names must be globally unique.

az storage account create \
  --name tfstate<unique-number> \
  --resource-group tfstate-rg \
  --location westeurope \
  --sku Standard_LRS \
  --kind StorageV2

Example:

tfstate19257
Save Storage Account Name
export STORAGE_NAME=tfstate19257

Verify:

echo $STORAGE_NAME
Create Blob Container
az storage container create \
  --name terraform-state \
  --account-name $STORAGE_NAME \
  --auth-mode login
Step 3 — Configure Terraform Backend

Create:

terraform/environments/dev/backend.tf
Backend Configuration
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate19257"
    container_name       = "terraform-state"
    key                  = "dev.terraform.tfstate"
  }
}
Step 4 — Initialize Terraform Backend

Run inside:

terraform/environments/dev/

Initialize backend:

terraform init -reconfigure
Migration Prompt

Terraform may ask:

Do you want to copy existing state to the new backend?

Answer:

yes

This migrates local Terraform state to Azure Blob Storage.

Step 5 — Verify Terraform State
View Terraform State Resources
terraform state list

Example:

azurerm_resource_group.dev_rg
Verify Remote State File in Azure
az storage blob list \
  --account-name $STORAGE_NAME \
  --container-name terraform-state \
  --auth-mode login

Expected result:

dev.terraform.tfstate
Step 6 — Protect Backend Resources

Create a resource lock:

az lock create \
  --name tfstate-lock \
  --lock-type CanNotDelete \
  --resource-group tfstate-rg

This prevents accidental deletion of Terraform backend resources.

Terraform State Concepts
Terraform State

Terraform state:

Tracks deployed infrastructure
Maps Terraform resources to Azure resources
Stores infrastructure metadata
Enables lifecycle management
Remote Backend

Azure Blob Storage backend provides:

Centralized state storage
Team collaboration support
State consistency
Remote accessibility
State locking support
Infrastructure Workflow
Code
  ↓
Terraform
  ↓
Azure Resources
  ↓
Remote State (Azure Blob Storage)
Common Terraform Commands
Initialize Terraform
terraform init
Format Terraform Files
terraform fmt -recursive
Validate Configuration
terraform validate
Preview Infrastructure Changes
terraform plan
Apply Infrastructure
terraform apply
Destroy Infrastructure
terraform destroy
View Terraform State
terraform state list
Important Rules
Do NOT
Manually edit .tfstate
Delete backend storage resources
Commit secrets to GitHub
Change backend configuration without reinitialization
Always
Use remote backend
Run Terraform in correct environment folder
Keep backend configuration consistent
Validate before apply
Protect backend resources
Security Notes
Sensitive Resources

Treat the following as sensitive:

Storage account keys
Service principals
Terraform state files
Production Recommendations
Use Azure RBAC instead of storage keys
Enable soft delete on storage accounts
Restrict public network access
Enable storage account firewall rules
Use separate backend per environment
Protect backend resources with resource locks
Final Result

You now have:

WSL-based Terraform environment
Azure authentication configured
Remote backend configured
Terraform state stored in Azure Blob Storage
Production-style Infrastructure-as-Code workflow
State protection using Azure resource locks
Next Learning Path
Terraform
Reusable modules
Workspaces
Multi-environment infrastructure
Terraform testing
Azure Infrastructure
Virtual Networks (VNet)
Subnets
Network Security Groups (NSG)
Virtual Machines
Azure Key Vault
DevOps Automation
GitHub Actions
Terraform CI/CD pipelines
Security scanning
Automated validation
Outcome

This setup represents a real-world DevOps foundation used in enterprise cloud environments:

Infrastructure as Code
Remote state management
Secure Azure integration
Scalable Terraform architecture
Production-style DevOps workflow