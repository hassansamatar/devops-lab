
````markdown
# 📦 Compute Module (Azure Linux VM)

This Terraform module provisions an Azure Linux Virtual Machine along with its required Network Interface (NIC). It is designed to work as part of a modular Infrastructure-as-Code (IaC) architecture with a separate networking module.

---

# 🧠 Purpose

This module is responsible for:

- Creating a Linux Virtual Machine in Azure
- Creating and attaching a Network Interface (NIC)
- Connecting the VM to an existing subnet
- Configuring VM size, OS image, and authentication
- Exposing VM outputs for other modules or environments

---

# 🏗️ Architecture Flow

```text
Network Module → Subnet ID → Compute Module → VM + NIC
````

* Network module creates VNet and Subnet
* Subnet ID is passed into this module
* Compute module deploys VM inside that subnet

---

# 📁 Module Structure

```text
compute/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

---

# ⚙️ Resources Created

This module provisions:

## Network Interface (NIC)

* Private network interface
* Attached to the provided subnet

## Linux Virtual Machine

* Ubuntu 22.04 LTS
* Configurable VM size
* SSH or password authentication (configurable)
* Managed OS disk

---

# 📥 Inputs

| Name                | Description                   | Type   | Required |
| ------------------- | ----------------------------- | ------ | -------- |
| resource_group_name | Resource group name           | string | Yes      |
| location            | Azure region                  | string | Yes      |
| subnet_id           | Subnet ID from network module | string | Yes      |
| vm_name             | Virtual machine name          | string | No       |
| vm_size             | VM size SKU                   | string | No       |
| admin_username      | Admin username                | string | Yes      |
| admin_password      | Admin password (if used)      | string | Optional |

---

# 📤 Outputs

| Name       | Description                  |
| ---------- | ---------------------------- |
| vm_id      | ID of the virtual machine    |
| nic_id     | ID of the network interface  |
| private_ip | Private IP address of the VM |

---

# 🚀 Example Usage

```hcl
module "compute" {
  source = "../../modules/compute"

  resource_group_name = azurerm_resource_group.dev_rg.name
  location            = azurerm_resource_group.dev_rg.location

  subnet_id = module.network.subnet_id

  vm_name        = "dev-vm-01"
  vm_size        = "Standard_B2ms"

  admin_username = var.admin_username
  admin_password = var.admin_password
}
```

---

# 🔐 Authentication Notes

## Recommended (Production)

* SSH key authentication
* Password authentication disabled

## Development Mode

* Password authentication enabled (not recommended for production)

---

# ⚠️ Important Notes

* VM size availability depends on Azure region capacity
* Subnet must exist before deploying this module
* Avoid using `terraform destroy -target` in production
* Prefer SSH authentication over password-based login

---

# 🧪 Validation Commands

```bash
terraform fmt
terraform validate
terraform plan
```

Optional tools:

* tflint (linting)
* checkov (security scanning)

---

# 🧭 Design Principles

* Modular Infrastructure-as-Code
* Separation of network and compute layers
* Reusable and environment-agnostic design
* Cloud-native Azure architecture pattern

---

# 📌 Status

✔ Functional
✔ Modular
✔ Terraform best-practice aligned
⚠ Needs SSH-only hardening for production use

```
```
