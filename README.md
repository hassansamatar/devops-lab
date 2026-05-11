# DevOps
# Azure DevOps Setup Guide (WSL + Azure CLI)

This document provides a clean step-by-step guide to set up a complete Azure DevOps environment using Windows Subsystem for Linux (WSL), Ubuntu, and Azure CLI.

---

# 🧭 1. Install WSL (Windows Subsystem for Linux)

Run PowerShell as Administrator:

```powershell
wsl --install
```

### What this does:

* Installs WSL2
* Enables Virtual Machine Platform
* Installs default Linux support
* Requires system restart

---

# 🔄 2. Restart Windows

After installation:

* Restart your computer
* This activates WSL features

---

# 🐧 3. Install Ubuntu Linux (Recommended)

Check available distributions:

```powershell
wsl --list --online
```

Install Ubuntu 24.04 LTS:

```powershell
wsl --install -d Ubuntu-24.04
```

---

# 👤 4. Create Linux User

On first Ubuntu launch:

* Create a username (e.g. `hassan`)
* Set a Linux password (used for sudo commands)

---

# 🖥️ 5. Open WSL (Linux Terminal)

Start WSL:

```bash
wsl
```

Or open Ubuntu directly from Windows.

---

# ☁️ 6. Install Azure CLI

Inside Ubuntu (WSL):

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

Verify installation:

```bash
az version
```

---

# 🔐 7. Login to Azure (MFA Enabled)

Use device login method:

```bash
az login --use-device-code
```

Steps:

* Open browser: [https://microsoft.com/devicelogin](https://microsoft.com/devicelogin)
* Enter provided code
* Complete sign-in with MFA

---

# 🔄 8. Set Active Subscription

Set correct subscription:

```bash
az account set --subscription b5650912-09b4-4990-a18c-92c0e07f087b
```

Verify:

```bash
az account show
```

---

# 🧱 9. Create Resource Group

Create a container for Azure resources:

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

# 📊 10. Verify Azure Setup

Check account details:

```bash
az account show
```

Expected:

* Active subscription
* Correct tenant
* State = Enabled

---

# 🧠 Final Setup Overview

You now have:

✔ WSL Ubuntu installed
✔ Azure CLI installed
✔ MFA login configured
✔ Active Azure subscription
✔ Resource group created (`dev-rg`)

---

# 🚀 Next Steps (Recommended Learning Path)

## 🖥️ Infrastructure

* Virtual Machines
* Storage Accounts
* Networking (VNet, Subnets)

## ⚙️ DevOps Tools

* Git + GitHub setup
* Terraform (Infrastructure as Code)
* Docker in WSL

## 🔐 Advanced Azure

* Service Principal authentication
* Azure Key Vault (secrets management)
* CI/CD pipelines (GitHub Actions / Azure DevOps)

---

# 📌 Notes

* Always use `westeurope` for best performance in Norway
* Always stop VMs to avoid unnecessary charges
* Use service principals for automation (not personal login)

---

# 🎯 End of Setup Guide

This environment is now ready for real Azure DevOps workflows.
🔐 Azure Login & Environment Setup (WSL)
This section describes how to correctly authenticate Azure CLI in WSL and ensure the correct tenant and subscription are selected before using Terraform.

🧭 1. Open WSL (Ubuntu)
Start your Linux environment:
wsl
Navigate to your home directory:
cd ~

🧹 2. Clear previous Azure sessions (recommended)
Removes any cached or incorrect subscription/tenant context:
az account clear

🔐 3. Login to Azure using the correct tenant
Use device code login (recommended for WSL):
az login --use-device-code --tenant 18ed99ea-84ac-4738-b227-773da6b24321
Follow the instructions:


Open https://microsoft.com/devicelogin


Enter the provided code


Sign in with your Azure account (hassansamat@hotmail.com)


Select the correct subscription: Azure subscription 1



📌 4. Set the active subscription
After successful login, set the correct subscription:
az account set --subscription b5650912-09b4-4990-a18c-92c0e07f087b

✅ 5. Verify active Azure context
Confirm correct tenant and subscription:
az account show
Expected values:


Tenant ID: 18ed99ea-84ac-4738-b227-773da6b24321


Subscription: Azure subscription 1


State: Enabled



📂 6. Verify resource group access
Ensure your Azure resources are visible:
az group list --output table
Expected output includes:


dev-rg (westeurope)



🧠 Important Notes


Always verify the correct tenant before provisioning resources


Azure CLI is the source of truth (not the portal UI)


Portal may temporarily show no subscriptions if wrong directory is selected


Always confirm subscription context before running Terraform



🚀 Ready for Terraform
Once these steps are complete, your environment is fully configured and ready for Infrastructure as Code using Terraform.