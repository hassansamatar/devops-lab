# 📘 Terraform Best Practices

This document defines standards for writing production-grade Terraform in this repository.

---

# 🧭 Core Principles

- Infrastructure must be predictable
- Code must be reusable
- State must be protected
- No hardcoded secrets
- Everything must be versioned

---

# 📁 Project Structure Rules

Always follow:

```text
environments/   → deployment logic
modules/        → reusable infrastructure
scripts/        → automation
docs/           → documentation
🏷️ Naming Conventions
Resources

Use format:

<environment>-<resource>-<purpose>

Example:

dev-rg-terraform

Variables
Use snake_case
Be descriptive

Example:

resource_group_name
location
vnet_address_space
☁️ Azure Best Practices
Always use westeurope (or agreed region)
Always tag resources:
tags = {
  environment = "dev"
  owner       = "devops-lab"
}
🔐 Security Rules
Never commit secrets
Never hardcode keys
Use Azure RBAC instead of access keys
Store secrets in Azure Key Vault (future step)
📦 State Rules
Always use remote backend
Never edit .tfstate
Never delete storage account manually
Always run:
terraform init -reconfigure
🚀 Workflow Standard
terraform fmt
terraform validate
terraform plan
terraform apply
🧠 Golden Rule

If it cannot be destroyed and recreated safely, it is not IaC-ready.


---

# 📘 `terraform-security.md`

```md
# 🔐 Terraform Security Guide

This document defines security standards for Terraform in Azure.

---

# 🧭 Security Principles

- Least privilege access
- No secrets in code
- Centralized state security
- Auditable infrastructure changes

---

# 🔑 Authentication

Preferred methods:

- Azure CLI login (dev)
- Service Principal (CI/CD future)
- Managed Identity (production future)

---

# 🔒 Secrets Handling

DO NOT:

- Hardcode passwords
- Store keys in `.tfvars`
- Commit credentials to GitHub

USE:

- Azure Key Vault (future module)
- Environment variables
- Secure CI/CD secrets

---

# ☁️ Remote State Security

- Store state in Azure Storage Account
- Enable access control (RBAC)
- Enable soft delete (recommended)
- Avoid public access

---

# 🧱 Network Security (Future Modules)

- NSG (Network Security Groups)
- Private endpoints
- Subnet segmentation

---

# 🚨 Security Anti-Patterns

- ❌ Public storage accounts
- ❌ Open inbound VM access
- ❌ Shared credentials
- ❌ No tagging or auditing

---

# 🧠 Rule

> Infrastructure security is not optional — it is part of the design.