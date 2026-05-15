# =========================================================
# Core configuration
# =========================================================

variable "resource_group_name" {
  description = "Resource group for Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Key Vault (must be globally unique)"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

# =========================================================
# TAGS
# =========================================================

variable "tags" {
  description = "Tags for Key Vault"
  type        = map(string)
  default     = {}
}