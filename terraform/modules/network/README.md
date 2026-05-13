# Terraform Azure Network Module

Reusable Azure networking module for deploying:

- Virtual Network (VNet)
- Subnet
- Network Security Group (NSG)
- NSG association

---

# Architecture

```text
VNet
 └── Subnet
       └── NSG Association
             └── Security Rules
```

---

# Resources Created

- azurerm_virtual_network
- azurerm_subnet
- azurerm_network_security_group
- azurerm_subnet_network_security_group_association

---

# Example Usage

```hcl
module "network" {
  source = "../../modules/network"

  resource_group_name = "dev-rg-terraform"
  location            = "westeurope"

  vnet_name           = "dev-vnet"
  vnet_address_space  = ["10.0.0.0/16"]

  subnet_name         = "dev-subnet"
  subnet_address_prefixes = ["10.0.1.0/24"]

  nsg_name            = "dev-nsg"
}
```

---

# Inputs

| Name | Description |
|------|-------------|
| resource_group_name | Azure resource group |
| location | Azure region |
| vnet_name | Virtual network name |
| vnet_address_space | VNet CIDR range |
| subnet_name | Subnet name |
| subnet_address_prefixes | Subnet CIDR |
| nsg_name | Network Security Group name |

---

# Outputs

| Name | Description |
|------|-------------|
| vnet_id | Virtual network ID |
| subnet_id | Subnet ID |
| nsg_id | NSG ID |

---

# Learning Goals

This module demonstrates:

- Modular Terraform design
- Azure networking fundamentals
- CIDR-based network segmentation
- Infrastructure reuse
- Enterprise Infrastructure-as-Code patterns