# Terraform Setup on WSL Ubuntu (Azure Environment)

> Complete local development environment setup for Azure Terraform workflows using WSL2 Ubuntu.

---

# Overview

This guide configures a local DevOps environment for working with:

- Terraform
- Microsoft Azure
- Azure CLI
- Git
- WSL Ubuntu

The goal is to create a production-style Infrastructure-as-Code (IaC) development environment on Windows using Linux tooling through WSL2.

---

# What You Will Achieve

After completing this setup, you will have:

- WSL2 Ubuntu environment
- Azure CLI installed
- Terraform installed
- Git configured
- Azure authentication working
- First Terraform deployment completed

---

# System Requirements

- Windows 10 or Windows 11
- Administrator access
- Internet connection
- Active Azure subscription

---

# Step 1 — Install WSL2

Open PowerShell as Administrator:

```bash
wsl --install

This command:

Enables WSL2
Enables Virtual Machine Platform
Installs Linux support
Installs default Ubuntu distribution

Restart your computer after installation.

Step 2 — Install Ubuntu

List available distributions:

wsl --list --online

Install Ubuntu 24.04:

wsl --install -d Ubuntu-24.04
Step 3 — Create Linux User

On first Ubuntu launch:

Create Linux username
Create Linux password

Example:

Username: hassan

This password will be used for sudo commands.

Step 4 — Open WSL Ubuntu

Launch Ubuntu using:

wsl

Or open Ubuntu from the Windows Start Menu.

Step 5 — Update Ubuntu Packages
sudo apt update && sudo apt upgrade -y
Step 6 — Install Git
sudo apt install git -y

Verify:

git --version
Step 7 — Install Azure CLI

Install Azure CLI:

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

Verify installation:

az version
Step 8 — Login to Azure

Use device code authentication:

az login --use-device-code

Steps:

Open:
https://microsoft.com/devicelogin
Enter device code
Sign in with Azure account
Select Azure subscription
Verify Azure Login
az account show
Set Active Subscription
az account set --subscription <SUBSCRIPTION_ID>
Step 9 — Install Terraform

Install required packages:

sudo apt update && sudo apt install -y gnupg software-properties-common curl
Add HashiCorp GPG Key
curl -fsSL https://apt.releases.hashicorp.com/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg
Add HashiCorp Repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
Install Terraform
sudo apt update && sudo apt install terraform -y

Verify:

terraform version
Step 10 — Create Terraform Project Structure

Recommended structure:

devops-lab/
├── docs/
├── terraform/
│   ├── environments/
│   │   └── dev/
│   │       ├── main.tf
│   │       ├── providers.tf
│   │       ├── variables.tf
│   │       ├── outputs.tf
│   │       └── backend.tf
│   │
│   ├── modules/
│   ├── scripts/
│   └── tests/
│
├── .github/
└── README.md
Step 11 — Configure Terraform Provider

Create:

terraform/environments/dev/providers.tf

Add:

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
Step 12 — Create First Azure Resource

Create:

terraform/environments/dev/main.tf

Add:

resource "azurerm_resource_group" "dev_rg" {
  name     = "dev-rg-terraform"
  location = "westeurope"
}
Step 13 — Create Outputs

Create:

terraform/environments/dev/outputs.tf

Add:

output "resource_group_name" {
  value = azurerm_resource_group.dev_rg.name
}
Step 14 — Terraform Workflow

Move into environment folder:

cd terraform/environments/dev
Initialize Terraform
terraform init
Format Terraform Files
terraform fmt -recursive
Validate Configuration
terraform validate
Preview Changes
terraform plan
Apply Infrastructure
terraform apply

Confirm:

yes
Successful Deployment

Example output:

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Azure resource created:

Resource Group: dev-rg-terraform
Key Concepts Learned
Infrastructure as Code (IaC)
Azure CLI authentication
Terraform workflow
Azure resource provisioning
Linux-based DevOps tooling
WSL development environments
Important Notes
Do NOT
Manually edit Terraform state files
Hardcode secrets
Commit sensitive files to GitHub
Always
Use version control
Validate before apply
Use .gitignore
Keep infrastructure reproducible
Security Recommendations
Use Multi-Factor Authentication (MFA)
Prefer Azure RBAC authentication
Rotate credentials regularly
Never expose secrets publicly
Next Steps
Terraform
Remote backend configuration
Reusable modules
Workspaces
Multi-environment infrastructure
Azure
Virtual Networks
Subnets
Network Security Groups
Virtual Machines
Key Vault
DevOps
GitHub Actions
Terraform CI/CD
Automated validation
Infrastructure security scanning
Outcome

You now have a complete local Azure Terraform development environment using WSL Ubuntu and production-style DevOps tooling.