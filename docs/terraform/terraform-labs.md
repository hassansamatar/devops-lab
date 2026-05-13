# 🧪 Terraform + Azure Practice Labs (Hands-on Guide)

Practical labs for learning Terraform with Azure step-by-step using real-world scenarios.
Built for DevOps + Azure + AI-200 preparation.

---

# 🟢 LAB 1 — Resource Group (FOUNDATION)

## 🎯 Goal

Create your first Azure Resource Group using Terraform.

## 📁 main.tf

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-dev-lab1"
  location = "westeurope"

  tags = {
    env   = "dev"
    owner = "you"
  }
}
```

## ▶️ Commands

```bash
terraform init
tf plan
tf apply
```

## 🧠 Learn

* Provider setup
* First Azure resource
* Tags usage

---

# 🟡 LAB 2 — Virtual Network + Subnet (NETWORKING)

## 🎯 Goal

Create Azure VNet with subnet using CIDR.

## 📁 main.tf

```hcl
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-dev"
  location            = "westeurope"
  resource_group_name = "rg-dev-lab1"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet-aks"
  resource_group_name  = "rg-dev-lab1"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet("10.0.0.0/16", 8, 1)]
}
```

## 🧠 Learn

* CIDR subnetting
* Networking in Azure
* Resource dependencies

---

# 🟠 LAB 3 — Dynamic Naming (JOIN FUNCTION)

## 🎯 Goal

Create dynamic naming conventions.

```hcl
variable "env" {
  default = "dev"
}

locals {
  name = join("-", [var.env, "aks", "cluster"])
}

output "cluster_name" {
  value = local.name
}
```

## 🧠 Learn

* join()
* locals
* naming strategy

---

# 🔵 LAB 4 — Tags with merge()

## 🎯 Goal

Build enterprise tagging strategy.

```hcl
variable "env" {
  default = "dev"
}

locals {
  base_tags = {
    env = var.env
  }

  extra_tags = {
    owner = "platform-team"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.env}"
  location = "westeurope"

  tags = merge(local.base_tags, local.extra_tags)
}
```

## 🧠 Learn

* merge()
* tagging at scale
* enterprise standards

---

# 🟣 LAB 5 — Safe Defaults (try function)

## 🎯 Goal

Avoid null errors in pipelines.

```hcl
variable "image_tag" {
  default = null
}

locals {
  tag = try(var.image_tag, "latest")
}
```

## 🧠 Learn

* try()
* CI/CD safety
* default values

---

# 🟤 LAB 6 — Azure DevOps Pipeline

## 🎯 Goal

Run Terraform in CI/CD pipeline.

```yaml
steps:
- script: terraform init
- script: terraform validate
- script: terraform plan
- script: terraform apply -auto-approve
```

## 🧠 Learn

* CI/CD flow
* automation
* DevOps pipeline structure

---

# 🔶 LAB 7 — Mini Real Architecture

## 🎯 Goal

Combine multiple Terraform concepts.

```hcl
resource "azurerm_resource_group" "rg" {
  name     = join("-", [var.env, "rg"])
  location = "westeurope"

  tags = merge(
    { env = var.env },
    { project = "terraform-lab" }
  )
}

resource "azurerm_virtual_network" "vnet" {
  name                = join("-", [var.env, "vnet"])
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  address_space = ["10.0.0.0/16"]
}
```

## 🧠 Learn

* Real architecture flow
* Dependency chaining
* Reusable patterns

---

# 🧪 LAB 8 — Challenge (Build Yourself)

## 🎯 Task

Build:

* Resource Group
* VNet
* 2 Subnets (app + db)
* Use join() for naming
* Use merge() for tags
* Use cidrsubnet() for IPs

## 🧠 Goal

Simulate real production Azure infrastructure.

---

# 🚀 What You Learn From These Labs

✔ Azure infrastructure design
✔ Terraform functions in real usage
✔ Networking (CIDR/subnets)
✔ DevOps CI/CD pipelines
✔ Production-ready patterns

---

# 💡 Next Step Options

* AKS full deployment lab
* End-to-end CI/CD project
* Azure Container Apps deployment
* AI-200 exam scenario labs
