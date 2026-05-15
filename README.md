# DevOps Lab — Azure + Terraform Engineering Portfolio

Enterprise-grade DevOps and Infrastructure-as-Code (IaC) learning repository built to simulate real-world cloud engineering workflows using Microsoft Azure and Terraform.

This project demonstrates practical skills in:
- Cloud infrastructure design
- Infrastructure-as-Code (Terraform)
- Modular architecture (network + compute separation)
- CI/CD automation
- DevOps engineering practices
- Security-first cloud architecture

> ⚠️ Status: Active learning + production-style portfolio build

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
* git-workflow.md
* testing-strategy.md

---

# 🚀 Current Engineering Progress

✔ WSL2 DevOps environment configured
✔ Azure CLI authenticated
✔ Terraform installed and validated
✔ Modular architecture implemented (network + compute + Key vault)
✔ First VM successfully deployed
✔ Bastion-only SSH access working (no VM public IP)
✔ Infrastructure state management validated
✔ CI/CD scripts and workflows implemented (plan/apply + quality gates)
✔ Azure Key Vault deployed
✔ RBAC-based Key Vault access implemented
✔ Key Vault firewall rules enabled (default deny + allow list)
✔ Key Vault purge protection enabled
✔ Terraform validation, Checkov security scan, and TFLint checks passing
✔ Multi-cloud access contract baseline added (Azure/AWS/GCP mapping)

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

> Actively evolving DevOps engineering portfolio focused on real-world cloud architecture, automation, and infrastructure design.

