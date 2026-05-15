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

variable "key_vault_allowed_ip_rules" {
  type        = list(string)
  description = "CIDR IP ranges allowed to access Key Vault over public endpoint"

  default = []
}

variable "key_vault_default_action" {
  type        = string
  description = "Key Vault firewall default action (Allow or Deny)"

  default = "Deny"

  validation {
    condition     = contains(["Allow", "Deny"], var.key_vault_default_action)
    error_message = "key_vault_default_action must be either 'Allow' or 'Deny'."
  }
}

# TAGS
variable "tags" {
  type = map(string)

  default = {
    environment = "dev"
    managed_by  = "terraform"
  }
}