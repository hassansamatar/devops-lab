variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Azure resource group name"
}

# KEY VAULT
variable "key_vault_name" {
  type        = string
  description = "Azure Key Vault name"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID for Key Vault"
}

# TAGS
variable "tags" {
  type = map(string)

  default = {
    environment = "dev"
    managed_by  = "terraform"
    project     = "devops-lab"
  }
}