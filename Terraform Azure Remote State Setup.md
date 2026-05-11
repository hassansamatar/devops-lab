
---

# 📘 Terraform Azure Remote State Setup (WSL + Azure CLI)

> End-to-end DevOps setup for Terraform with Azure Remote Backend using WSL (Ubuntu)

---

# 🧭 Overview

This project sets up a complete **Terraform environment integrated with Azure Cloud**, including:

* WSL (Ubuntu) as development environment
* Azure CLI authentication (MFA-supported)
* Terraform infrastructure provisioning
* Azure Storage remote backend for state management
* Resource tracking via Azure Blob Storage
* Dev environment separation (`environments/dev`)

---

# 🏗️ Architecture

```text id="arch"
+----------------------+
|  Terraform (WSL)     |
|  Ubuntu Linux        |
+----------+-----------+
           |
           v
+----------------------+
| Azure Resource       |
| Manager (ARM)       |
+----------+-----------+
           |
           v
+----------------------+
| Azure Storage Account|
| (Terraform Backend)  |
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
| (Remote State File)  |
+----------------------+
```

---

# 🧰 Prerequisites

Before starting, ensure you have:

## System Requirements

* Windows 10/11
* WSL2 enabled
* Ubuntu installed (WSL)
* Internet connection

## Tools Installed in WSL

* Azure CLI
* Terraform (>= 1.5 recommended)
* Git

## Azure Requirements

* Active Azure subscription
* Owner or Contributor access

---

# 🔐 Step 1 — Install & Login to Azure (WSL)

## Login using device code (recommended for WSL)

```bash id="login"
az login --use-device-code --tenant <TENANT_ID>
```

Steps:

1. Open browser: [https://microsoft.com/devicelogin](https://microsoft.com/devicelogin)
2. Enter device code
3. Sign in with Azure account
4. Select correct subscription

---

## Verify login

```bash id="verify-login"
az account show
```

---

## Set active subscription

```bash id="set-sub"
az account set --subscription <SUBSCRIPTION_ID>
```

---

# 📁 Step 2 — Project Structure

Terraform is organized using environment-based structure:

```text id="structure"
devops-lab/
└── terraform/
    └── environments/
        └── dev/
            ├── main.tf
            ├── provider.tf
            ├── variables.tf
            ├── backend.tf
```

## Execution folder:

All Terraform commands must be run from:

```bash id="cwd"
terraform/environments/dev/
```

---

# ☁️ Step 3 — Create Backend Infrastructure (Azure Storage)

## 3.1 Create Resource Group for Terraform State

```bash id="rg"
az group create \
  --name tfstate-rg \
  --location westeurope
```

---

## 3.2 Create Storage Account (state storage)

```bash id="storage"
az storage account create \
  --name tfstate<unique-number> \
  --resource-group tfstate-rg \
  --location westeurope \
  --sku Standard_LRS \
  --kind StorageV2
```

Example created:

```text id="example"
tfstate19257
```

---

## 3.3 Save storage account name

```bash id="export"
export STORAGE_NAME=tfstate19257
```

Verify:

```bash id="check-env"
echo $STORAGE_NAME
```

---

## 3.4 Create Blob Container

```bash id="container"
az storage container create \
  --name terraform-state \
  --account-name $STORAGE_NAME \
  --auth-mode login
```

---

# ⚙️ Step 4 — Configure Terraform Backend

Create file:

```text id="backend-file"
terraform/environments/dev/backend.tf
```

## Backend configuration:

```hcl id="backend"
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate19257"
    container_name       = "terraform-state"
    key                  = "dev.terraform.tfstate"
  }
}
```

---

# 🔄 Step 5 — Initialize Terraform Backend

Run inside `dev` folder:

```bash id="init"
terraform init -reconfigure
```

### When prompted:

```text id="prompt"
Do you want to copy existing state?
```

👉 Answer:

```text id="yes"
yes
```

---

# 📦 Step 6 — Terraform State Verification

## View local state tracking

```bash id="state"
terraform state list
```

Example output:

```text id="output"
azurerm_resource_group.dev_rg
```

---

## Verify Azure remote state file

⚠️ Requires storage key or RBAC access

```bash id="blob"
az storage blob list \
  --account-name $STORAGE_NAME \
  --container-name terraform-state \
  --account-key <KEY>
```

Expected:

```text id="statefile"
dev.terraform.tfstate
```

---

# 🧠 Key DevOps Concepts Learned

## Terraform State

* Tracks infrastructure mapping
* Stores resource metadata
* Enables lifecycle management

## Remote Backend (Azure Storage)

* Centralized state storage
* Team collaboration support
* State locking capability

## Infrastructure Flow

```text id="flow"
Code → Terraform → Azure Resources → Remote State (Azure Storage)
```

---

# ⚠️ Important Rules

## Do NOT:

* ❌ manually edit `.tfstate`
* ❌ delete storage account
* ❌ change backend without `terraform init -reconfigure`

## Always:

* ✔ run Terraform in correct folder
* ✔ keep backend consistent
* ✔ use remote state for safety

---

# 🔐 Security Notes

* Storage keys are sensitive (treat like passwords)
* Prefer Azure RBAC in production
* Rotate keys if exposed
* Never commit secrets to GitHub

---

# 🚀 Final Result

You now have:

✔ WSL-based Terraform environment
✔ Azure authentication configured
✔ Remote backend working
✔ State stored in Azure Blob Storage
✔ First Azure resource deployed
✔ Production-style infrastructure pattern

---

# 📈 Next Learning Path

Recommended next steps:

## 1. Azure Networking

* Virtual Network (VNet)
* Subnets
* NSG (firewall rules)

## 2. Compute

* Virtual Machines with Terraform

## 3. DevOps Automation

* GitHub Actions for Terraform CI/CD

## 4. Advanced

* Terraform modules
* Multi-environment setup (dev/prod/staging)

---

# 🎯 Outcome

This setup represents a **real-world DevOps foundation** used in production environments:

* Cloud infrastructure as code
* Remote state management
* Secure Azure integration
* Scalable project structure

---

