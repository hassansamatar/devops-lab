# =========================================================
# CORE CONFIGURATION
# =========================================================

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

# =========================================================
# NETWORK
# =========================================================

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet_name" {
  type = string
}

variable "subnet_address_prefixes" {
  type = list(string)
}

variable "nsg_name" {
  type = string
}

# =========================================================
# COMPUTE
# =========================================================

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM access"
  sensitive   = true
}

variable "key_vault_allowed_ip_rules" {
  type = list(string)

  default = []
}

variable "key_vault_default_action" {
  type = string

  default = "Deny"

  validation {
    condition     = contains(["Allow", "Deny"], var.key_vault_default_action)
    error_message = "key_vault_default_action must be either 'Allow' or 'Deny'."
  }
}

# =========================================================
# TAGGING
# =========================================================

variable "tags" {
  type = map(string)

  default = {
    environment = "dev"
    managed_by  = "terraform"
    project     = "devops-lab"
  }
}