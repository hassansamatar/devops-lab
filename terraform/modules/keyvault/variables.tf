# =========================================================
# CORE SETTINGS
# =========================================================

variable "resource_group_name" {
  description = "Resource group where Key Vault will be created"
  type        = string
}

variable "location" {
  description = "Azure region (e.g. westeurope)"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

# =========================================================
# KEY VAULT CONFIG
# =========================================================

variable "key_vault_name" {
  description = "Globally unique Key Vault name"
  type        = string

  validation {
    condition     = length(var.key_vault_name) <= 24
    error_message = "Key Vault name must be 24 characters or less."
  }
}

# =========================================================
# RBAC OPTION (FUTURE PROOFING)
# =========================================================

variable "enable_rbac" {
  description = "Enable RBAC authorization for Key Vault"
  type        = bool
  default     = true
}

# =========================================================
# TAGGING
# =========================================================

variable "tags" {
  description = "Tags applied to Key Vault"
  type        = map(string)

  default = {
    environment = "dev"
    managed_by  = "terraform"
    service     = "keyvault"
  }
}