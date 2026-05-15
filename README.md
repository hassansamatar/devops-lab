# DevOps Lab — Azure + Terraform Engineering Portfolio

Enterprise-grade DevOps and Infrastructure-as-Code (IaC) learning repository built to simulate real-world cloud engineering workflows using Microsoft Azure and Terraform.

This project demonstrates practical skills in:
- Cloud infrastructure design
- Infrastructure-as-Code (Terraform)
- Modular architecture (network + compute separation)
- CI/CD automation
- DevOps engineering practices
- Security-first cloud architecture

> ✅ Status: Core platform features completed; documentation and future enhancements continue

---

# 🧠 Engineering Objective

This repository simulates how real DevOps engineers design, build, and manage cloud infrastructure in enterprise environments.

Focus areas:
- Reusable Infrastructure-as-Code (IaC)
- Modular Azure architecture
- Secure cloud deployments
- Automated CI/CD pipelines
- Production-ready Terraform patterns
- State-driven infrastructure lifecycle

This project follows production-style Infrastructure-as-Code practices used in enterprise Azure DevOps environments.

---

# 🧰 Technology Stack

- Microsoft Azure (Cloud Platform)
- Terraform (Infrastructure-as-Code)
- Ubuntu (WSL2 Development Environment)
- Git & GitHub (Version Control)
- GitHub Actions (CI/CD Automation)
- Bash Scripting (Automation)
- YAML (Pipeline Definitions)

---

# 🏗️ Current Architecture (Implemented)

```mermaid
flowchart TB
    Developer[👨‍💻 Developer] -->|terraform apply| Terraform[⚙️ Terraform WSL2]
    Terraform --> RG[📦 Azure Resource Group]

    subgraph Network_Module [🌐 Network Module]
        VNet[Virtual Network VNet]
        Subnet[Subnet]
        NSG[Network Security Group NSG]
        VNet --- Subnet
        NSG -.-> Subnet
    end

    subgraph Compute_Module [💻 Compute Module]
        NIC[Network Interface]
        VM[Linux Virtual Machine]
        NIC --> VM
    end

    RG --> Network_Module
    Network_Module --> Compute_Module
    Compute_Module --> AzureCloud[☁️ Azure Cloud Infrastructure]
```

---

# 📁 Repository Structure

```
📁 devops-lab/
│
├── 📁 docs/
│   ├── 📁 terraform/
│   ├── 📁 azure/
│   ├── 📁 devops/
│   └── 📁 architecture/
│
├── 📁 terraform/
│   ├── 📁 environments/
│   │   ├── 📁 dev/
│   │   ├── 📁 staging/
│   │   └── 📁 prod/
│   │
│   ├── 📁 modules/
│   │   ├── 📁 network/
│   │   ├── 📁 compute/
│   │   ├── 📁 storage-account/
│   │   ├── 📁 keyvault/
│   │   └── 📁 monitoring/
│   │
│   ├── 📁 scripts/
│   └── 📁 tests/
│
├── 📁 .github/
│   └── 📁 workflows/
│
├── 📄 .gitignore
└── 📄 README.md
```

---

# 📚 Documentation Index

## Terraform Knowledge Base

* terraform-best-practices.md
* terraform-modules.md
* terraform-remote-state.md
* terraform-security.md
* terraform-setup-wsl-azure.md
* terraform-state-management.md
* terraform-testing.md
* terraform-workspaces.md

---

## Azure Architecture

* azure-networking.md
* azure-storage.md
* azure-rbac.md
* azure-security.md

---

## DevOps & CI/CD

* github-actions.md
* azure-devops-pipelines.md
* pipeline-trigger-cheat-sheet.md
* git-workflow.md
* testing-strategy.md

---

# ✅ Completed Features

The following capabilities are implemented and working in the repository:

✔ WSL2-based DevOps development environment configured
✔ Azure CLI authentication and Terraform toolchain validated
✔ Modular Azure infrastructure implemented for network, key vault, and compute
✔ Remote Terraform state stored in Azure Blob Storage with Azure AD/OIDC auth
✔ GitHub Actions plan/apply workflows implemented for Terraform delivery
✔ Validation chain implemented with `terraform fmt`, `terraform validate`, Checkov, and TFLint
✔ Private Linux VM deployed with no public IP exposure
✔ Azure Bastion access path working for private VM administration
✔ Azure Key Vault deployed for secret storage and VM SSH key handling
✔ RBAC-based Key Vault access enabled
✔ Key Vault firewall and purge-protection controls enabled
✔ CI-specific Terraform tfvars flow added for reproducible pipeline runs
✔ Pipeline hardening completed with action pinning and explicit runtime settings
✔ Comprehensive pipeline documentation added in `docs/devops/azure-devops-pipelines.md`
✔ Multi-cloud access contract baseline added for Azure/AWS/GCP mapping

---

# 🎯 Engineering Roadmap

## 🧱 Infrastructure-as-Code (Terraform)

* Expand reusable module coverage for storage/monitoring/resource-group
* Add private endpoint pattern for Key Vault + private DNS integration
* Strengthen VM hardening baseline (updates, diagnostics, policy checks)
* Extend environment strategy (dev/test/prod parity checks)
* Add policy-as-code enforcement gates (OPA/Checkov policy bundles)

---

## ☁️ Azure Cloud Architecture

* VNet segmentation (hub-spoke design)
* VM scale sets (VMSS)
* Key Vault private endpoint rollout (planned)
* Bastion subnet NSG hardening with validated Azure-required rules
* RBAC + least privilege enforcement

---

## ⚙️ DevOps Automation

* Promote current GitHub Actions plan/apply workflows to protected branch flow
* Add PR comments with Terraform plan summary and risk highlights
* Add scheduled drift detection workflow
* Add cloud matrix strategy for upcoming AWS/GCP environments

---

# 🔐 Security & Governance Focus

* No hardcoded secrets in code
* Secure remote state storage (Azure Storage)
* Role-Based Access Control (RBAC) for Key Vault
* Secure CI/CD pipeline design
* Bastion-only VM access with private networking

---

# 📈 Long-Term Vision

This project evolves toward:

* Production-grade Terraform platform
* Enterprise DevOps automation system
* Multi-environment cloud infrastructure
* Reusable infrastructure modules
* Secure cloud governance model
* Portfolio-ready engineering showcase

---

# 🧠 Core Skills Demonstrated

* Infrastructure-as-Code (Terraform)
* Azure Cloud Engineering
* Modular architecture design
* DevOps automation workflows
* CI/CD pipeline concepts
* Networking & cloud architecture
* Secure infrastructure design (RBAC model)
* Git-based collaboration workflows

---

# 💼 Portfolio Positioning

This repository demonstrates the ability to:

✔ Design scalable cloud infrastructure
✔ Build reusable Terraform modules
✔ Automate deployments using DevOps practices
✔ Operate within Azure cloud environments
✔ Implement modular, production-style IaC design

---

# 📌 Status

> The core Azure + Terraform platform is in place. The repository now serves as a working DevOps portfolio with completed infrastructure, security, and pipeline foundations, plus a roadmap for expansion.

