
---

# 📘 DevOps Lab — Azure Terraform Setup Guide (WSL + Azure CLI + Terraform)

This document provides a complete step-by-step guide to set up a working **Azure DevOps Infrastructure-as-Code (IaC) environment** using:

* Windows Subsystem for Linux (WSL)
* Ubuntu
* Azure CLI
* Terraform
* Git + GitHub

---

# 🧭 1. Install WSL (Windows Subsystem for Linux)

Run PowerShell as Administrator:

```bash
wsl --install
```

### What this does:

* Installs WSL2
* Enables Virtual Machine Platform
* Installs default Linux environment

👉 Restart your computer after installation

---

# 🐧 2. Install Ubuntu (WSL Linux Distribution)

List available distributions:

```bash
wsl --list --online
```

Install Ubuntu 24.04 LTS:

```bash
wsl --install -d Ubuntu-24.04
```

---

# 👤 3. Create Linux User

On first launch of Ubuntu:

* Create username (e.g. `hassan`)
* Set Linux password (used for `sudo`)

---

# 🖥️ 4. Open WSL Terminal

Start Ubuntu:

```bash
wsl
```

Or open “Ubuntu” from Windows start menu.

---

# ☁️ 5. Install Azure CLI

Inside WSL Ubuntu:

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

Verify installation:

```bash
az version
```

---

# 🔐 6. Login to Azure (Device Login)

Use device code authentication:

```bash
az login --use-device-code
```

Steps:

1. Open: [https://microsoft.com/devicelogin](https://microsoft.com/devicelogin)
2. Enter the code shown in terminal
3. Sign in with Azure account
4. Select subscription

---

# 🔄 7. Set Active Subscription

```bash
az account set --subscription <SUBSCRIPTION_ID>
```

Verify:

```bash
az account show
```

---

# 🧱 8. Create Azure Resource Group (CLI)

```bash
az group create \
  --name dev-rg \
  --location westeurope
```

Verify:

```bash
az group show --name dev-rg
```

---

# ⚙️ 9. Install Terraform (Ubuntu WSL)

Add HashiCorp repository:

```bash
sudo apt update && sudo apt install -y gnupg software-properties-common curl

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

Install Terraform:

```bash
sudo apt update && sudo apt install terraform -y
```

Verify:

```bash
terraform version
```

---

# 📁 10. Terraform Project Structure

Final structure:

```text
terraform/
└── environments/
    └── dev/
        ├── main.tf
        ├── provider.tf
        ├── variables.tf
        └── outputs.tf
```

---

# ☁️ 11. Terraform Provider Configuration

`provider.tf`

```hcl
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
```

---

# 🧱 12. First Azure Resource (Resource Group)

`main.tf`

```hcl
resource "azurerm_resource_group" "dev_rg" {
  name     = "dev-rg-terraform"
  location = "westeurope"
}
```

---

# 📤 13. Outputs (Optional but recommended)

`outputs.tf`

```hcl
output "resource_group_name" {
  value = azurerm_resource_group.dev_rg.name
}
```

---

# 🚀 14. Terraform Workflow

Initialize project:

```bash
terraform init
```

Validate configuration:

```bash
terraform validate
```

Preview changes:

```bash
terraform plan
```

Apply infrastructure:

```bash
terraform apply
```

Confirm:

```text
yes
```

---

# 🎉 15. Successful Deployment Output

```text
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

Azure Resource Created:

* Resource Group: `dev-rg-terraform`

---

# 🧠 16. Key Concepts Learned

* Infrastructure as Code (IaC)
* Terraform state management
* Azure CLI authentication
* Resource provisioning automation
* WSL-based DevOps environment

---

# ⚠️ 17. Important Notes

* Do NOT manually modify Terraform-managed resources
* Always use Terraform for infrastructure changes
* Keep state file secure (future improvement: remote backend)
* Use consistent Azure region (`westeurope` for Norway)

---

# 🚀 18. Next Steps (Recommended Learning Path)

## 🔐 Terraform Advanced Setup

* Azure Storage remote backend (state management)
* Workspaces (dev / prod environments)

## ⚙️ Infrastructure Expansion

* Virtual Networks (VNet)
* Virtual Machines (VMs)
* Key Vault (secrets management)

## 🔁 CI/CD Integration

* GitHub Actions for Terraform automation
* Azure DevOps pipelines

---

# 🏁 End of Setup Guide

This environment is now fully ready for **real-world Azure DevOps and Terraform workflows** 🚀
