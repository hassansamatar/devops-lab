Great — this is already a solid DevOps README. I’ve cleaned it up, removed duplication, fixed structure, and added your **SSH “master key” setup properly at the end** so it reads like a professional engineering document.

You can copy-paste this directly into your `README.md` 👇

---

# 🚀 Azure DevOps Setup Guide (WSL + Azure CLI + Git + SSH)

This document provides a clean, step-by-step guide to set up a complete Azure DevOps environment using:

* Windows Subsystem for Linux (WSL)
* Ubuntu 24.04 LTS
* Azure CLI
* Git + GitHub
* SSH authentication

---

# 🧭 1. Install WSL (Windows Subsystem for Linux)

Run PowerShell as Administrator:

```bash
wsl --install
```

### What this does:

* Installs WSL2
* Enables Virtual Machine Platform
* Installs Linux support
* Requires restart

---

# 🔄 2. Restart Windows

After installation:

* Restart your computer
* This activates WSL features

---

# 🐧 3. Install Ubuntu (Recommended)

Check available distributions:

```bash
wsl --list --online
```

Install Ubuntu 24.04:

```bash
wsl --install -d Ubuntu-24.04
```

---

# 👤 4. Create Linux User

On first launch:

* Create username (e.g. `hassan`)
* Set Linux password

---

# 🖥️ 5. Open WSL

```bash
wsl
```

or open Ubuntu directly.

---

# ☁️ 6. Install Azure CLI

Inside WSL:

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

Verify:

```bash
az version
```

---

# 🔐 7. Azure Login (MFA Enabled)

```bash
az login --use-device-code
```

Steps:

* Open [https://microsoft.com/devicelogin](https://microsoft.com/devicelogin)
* Enter code
* Login with Azure account
* Complete MFA

---

# 🔄 8. Set Active Subscription

```bash
az account set --subscription <SUBSCRIPTION_ID>
```

Verify:

```bash
az account show
```

---

# 🧱 9. Create Resource Group

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

```bash
az account show
az group list --output table
```

---

# 🧠 Setup Summary

✔ WSL Ubuntu installed
✔ Azure CLI installed
✔ MFA login configured
✔ Active subscription selected
✔ Resource group created

---

# 🚀 Next Steps

## 🖥️ Infrastructure

* Virtual Machines
* Storage Accounts
* Networking (VNet, Subnets)

## ⚙️ DevOps Tools

* Git + GitHub
* Terraform (Infrastructure as Code)
* Docker in WSL

## 🔐 Advanced Azure

* Service Principal authentication
* Azure Key Vault
* CI/CD pipelines (GitHub Actions)

---

# 🔐 11. SSH Setup (GitHub Master Key Setup)

This ensures passwordless Git access from WSL.

---

## 📁 Check Windows SSH keys

```powershell
dir $env:USERPROFILE\.ssh
```

You should see:

* `id_rsa`
* `id_rsa.pub`

---

## 📂 Copy SSH key into WSL

```bash
mkdir -p ~/.ssh
cp /mnt/c/Users/HP/.ssh/id_rsa* ~/.ssh/
```

---

## 🔐 Fix permissions

```bash
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```

---

## 🚀 Start SSH agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```

---

## 🌐 Add SSH key to GitHub

Copy key:

```bash
cat ~/.ssh/id_rsa.pub
```

Add it here:

[GitHub SSH Keys](https://github.com/settings/keys?utm_source=chatgpt.com)

---

## 🔗 Switch Git to SSH

```bash
git remote set-url origin git@github.com:hassansamatar/devops-lab.git
```

---

## 🧪 Test connection

```bash
ssh -T git@github.com
```

Expected:

```text
Hi hassansamatar! You've successfully authenticated.
```

---

# 🎯 Final Result

You now have:

✔ WSL DevOps environment
✔ Azure CLI configured
✔ GitHub SSH authentication
✔ Terraform-ready workspace
✔ Clean DevOps structure

---

# 🚀 Ready for Terraform

Next phase:

👉 Terraform backend (Azure Storage state)
👉 First Azure resource deployment
👉 GitHub Actions CI/CD pipeline

---

If you want, I can next help you:

👉 structure your Terraform repo like production (modules/environments/backend)
👉 or deploy your first real Azure infrastructure step-by-step
👉 or build full CI/CD pipeline for Terraform

Just say 👍
