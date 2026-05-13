# Terraform Functions — Most Important Functions with Full Implementation (Azure DevOps + Azure)

This document expands the quick reference into **real Terraform HCL implementations**, with explanations and practical Azure DevOps usage patterns.

---

# 🥇 Tier 1 — MUST KNOW (Production Usage)

---

## 1. length()

### 🔹 Purpose

Counts number of elements in a list or map. Used for scaling resources dynamically.

### 🔹 HCL Example

```hcl
variable "vms" {
  default = ["vm1", "vm2", "vm3"]
}

output "vm_count" {
  value = length(var.vms)
}
```

### 🔹 Real use case

Used to decide how many Azure VMs or subnets to create dynamically.

---

## 2. lookup()

### 🔹 Purpose

Fetch value from a map with fallback option.

### 🔹 HCL Example

```hcl
variable "sku_map" {
  default = {
    dev  = "B2s"
    prod = "D4s"
  }
}

output "selected_sku" {
  value = lookup(var.sku_map, "prod", "B1")
}
```

### 🔹 Real use case

Select Azure VM SKU based on environment.

---

## 3. merge()

### 🔹 Purpose

Combines multiple maps into one (commonly used for tags).

### 🔹 HCL Example

```hcl
variable "base_tags" {
  default = { env = "dev" }
}

variable "extra_tags" {
  default = { owner = "platform" }
}

output "tags" {
  value = merge(var.base_tags, var.extra_tags)
}
```

### 🔹 Real use case

Azure resource tagging strategy.

---

## 4. concat()

### 🔹 Purpose

Combines multiple lists into one.

### 🔹 HCL Example

```hcl
variable "list1" {
  default = ["web"]
}

variable "list2" {
  default = ["db"]
}

output "combined" {
  value = concat(var.list1, var.list2)
}
```

### 🔹 Real use case

Combine subnet or VM lists across modules.

---

## 5. flatten()

### 🔹 Purpose

Flattens nested lists into a single list.

### 🔹 HCL Example

```hcl
variable "nested" {
  default = [["web"], ["api"]]
}

output "flat" {
  value = flatten(var.nested)
}
```

### 🔹 Real use case

Used when modules return nested outputs (e.g., AKS node pools).

---

## 6. contains()

### 🔹 Purpose

Checks if a value exists in a list.

### 🔹 HCL Example

```hcl
variable "envs" {
  default = ["dev", "prod"]
}

output "is_valid" {
  value = contains(var.envs, "prod")
}
```

### 🔹 Real use case

Validate environment names in pipelines.

---

## 7. split()

### 🔹 Purpose

Splits string into a list.

### 🔹 HCL Example

```hcl
variable "apps" {
  default = "web,api,db"
}

output "app_list" {
  value = split(",", var.apps)
}
```

### 🔹 Real use case

Parse pipeline variables or config strings.

---

## 8. join()

### 🔹 Purpose

Joins list into string.

### 🔹 HCL Example

```hcl
variable "name_parts" {
  default = ["prod", "web"]
}

output "name" {
  value = join("-", var.name_parts)
}
```

### 🔹 Real use case

Azure resource naming conventions.

---

## 9. replace()

### 🔹 Purpose

Replace substring inside string.

### 🔹 HCL Example

```hcl
output "name" {
  value = replace("aks-dev", "-", "_")
}
```

### 🔹 Real use case

Fix naming format for Azure constraints.

---

## 10. jsonencode()

### 🔹 Purpose

Converts Terraform object into JSON string.

### 🔹 HCL Example

```hcl
output "json" {
  value = jsonencode({ env = "dev" })
}
```

### 🔹 Real use case

Azure Policy, REST APIs, ARM-like payloads.

---

## 11. templatefile()

### 🔹 Purpose

Generates dynamic configuration from template.

### 🔹 HCL Example

```hcl
output "rendered" {
  value = templatefile("app.tpl", { env = "prod" })
}
```

### 🔹 Real use case

Kubernetes manifests, config files, CI/CD templates.

---

## 12. file()

### 🔹 Purpose

Reads external file content.

### 🔹 HCL Example

```hcl
output "script" {
  value = file("script.sh")
}
```

### 🔹 Real use case

Inject startup scripts into Azure VMs.

---

## 13. try()

### 🔹 Purpose

Handles missing/null values safely.

### 🔹 HCL Example

```hcl
variable "image_tag" {
  default = null
}

output "tag" {
  value = try(var.image_tag, "latest")
}
```

### 🔹 Real use case

Default values in CI/CD pipelines.

---

## 14. can()

### 🔹 Purpose

Checks if expression is valid without error.

### 🔹 HCL Example

```hcl
output "valid" {
  value = can(regex("a", "abc"))
}
```

### 🔹 Real use case

Input validation in modules.

---

## 15. cidrsubnet()

### 🔹 Purpose

Creates subnets from CIDR block.

### 🔹 HCL Example

```hcl
output "subnet" {
  value = cidrsubnet("10.0.0.0/16", 8, 1)
}
```

### 🔹 Real use case

Azure VNet subnet design.

---

# 🥈 Tier 2 — VERY IMPORTANT

## 16. distinct()

```hcl
output "unique" {
  value = distinct(["dev", "dev", "prod"])
}
```

Removes duplicates in environment lists.

---

## 17. slice()

```hcl
output "subset" {
  value = slice(["a","b","c"], 0, 2)
}
```

Used to split VM batches.

---

## 18. sort()

```hcl
output "sorted" {
  value = sort(["z","a"])
}
```

Ensures predictable deployment order.

---

## 19. keys()

```hcl
output "keys" {
  value = keys({ env = "dev", app = "web" })
}
```

Extract tag keys for Azure resources.

---

## 20. values()

```hcl
output "values" {
  value = values({ env = "dev", app = "web" })
}
```

Extract tag values.

---

## 21. format()

```hcl
output "name" {
  value = format("vm-%s", "01")
}
```

Standard VM naming.

---

## 22. substr()

```hcl
output "short" {
  value = substr("terraform", 0, 4)
}
```

Shortens resource names.

---

## 23. timestamp()

```hcl
output "time" {
  value = timestamp()
}
```

Used in deployment logs.

---

## 24. yamlencode()

```hcl
output "yaml" {
  value = yamlencode({ app = "web" })
}
```

Kubernetes manifests.

---

## 25. yamldecode()

```hcl
output "obj" {
  value = yamldecode("app: web")
}
```

Parse YAML configs.

---

# 🥉 Tier 3 — ADVANCED

## 26. zipmap()

```hcl
output "map" {
  value = zipmap(["vm1"], ["10.0.0.4"])
}
```

VM to IP mapping.

---

## 27. matchkeys()

```hcl
output "match" {
  value = matchkeys(["vm1"], ["dev"], ["dev"])
}
```

Filter resources by environment.

---

## 28. setunion()

```hcl
output "union" {
  value = setunion(["a"], ["b"])
}
```

Combine sets.

---

## 29. setintersection()

```hcl
output "common" {
  value = setintersection(["a","b"], ["b"])
}
```

Find common resources.

---

## 30. chunklist()

```hcl
output "chunks" {
  value = chunklist(["a","b","c"], 2)
}
```

Batch VM deployment.

---

## 31. compact()

```hcl
output "clean" {
  value = compact(["web", "", "api"])
}
```

Remove empty values.

---

## 32. one()

```hcl
output "single" {
  value = one(["aks-prod"])
}
```

Ensure single cluster output.

---

## 33. regex()

```hcl
output "num" {
  value = regex("[0-9]+", "vm123")
}
```

Extract numbers.

---

## 34. regexall()

```hcl
output "letters" {
  value = regexall("[a-z]", "a1b2")
}
```

Extract letters.

---

# 🚀 Enterprise Terraform Architecture (Real-World Usage)

## 📁 Folder Structure

```text
terraform/
 ├── modules/
 │    ├── vnet/
 │    ├── aks/
 │    ├── storage/
 ├── envs/
 │    ├── dev/
 │    ├── prod/
 ├── main.tf
 ├── variables.tf
 ├── outputs.tf
```

---

## ☁️ Azure VNet + AKS Example

```hcl
module "vnet" {
  source = "./modules/vnet"

  address_space = ["10.0.0.0/16"]
  subnets = {
    aks = cidrsubnet("10.0.0.0/16", 8, 1)
    db  = cidrsubnet("10.0.0.0/16", 8, 2)
  }
}
```

```hcl
module "aks" {
  source = "./modules/aks"

  name = join("-", [var.env, "aks", "cluster"])
  tags = merge({ env = var.env }, { owner = "platform" })
}
```

---

# 🔐 Remote State (Azure Storage Backend)

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateaccount"
    container_name       = "state"
    key                  = "prod.terraform.tfstate"
  }
}
```

---

# 🚀 Azure DevOps Pipeline (Terraform)

```yaml
steps:
- script: terraform init
- script: terraform validate
- script: terraform plan
- script: terraform apply -auto-approve
```

---

# 🧠 Interview Questions (Quick Prep)

### Q1: Why use lookup()?

A: To safely select values from maps with fallback.

### Q2: Why flatten()?

A: To simplify nested module outputs.

### Q3: Why cidrsubnet()?

A: To dynamically create Azure subnets.

### Q4: Why try()?

A: To avoid failures from null/missing variables.

### Q5: Why merge()?

A: To combine tags and metadata efficiently.

---

# 🎯 Final Summary

Mastering Tier 1 functions + this architecture = **production-ready Terraform engineer for Azure DevOps environments.**
