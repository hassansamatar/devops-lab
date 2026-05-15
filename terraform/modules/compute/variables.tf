# =========================================================
# CORE SETTINGS
# =========================================================

variable "resource_group_name" {
  type        = string
  description = "Resource group where VM will be deployed"
}

variable "location" {
  type        = string
  description = "Azure region (e.g. westeurope)"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID from network module"
}

# =========================================================
# VM CONFIGURATION
# =========================================================

variable "vm_name" {
  type        = string
  description = "Virtual machine name"
  default     = "dev-vm"
}

variable "vm_size" {
  type        = string
  description = "Azure VM SKU (must start with Standard_)"

  validation {
    condition     = can(regex("^Standard_", var.vm_size))
    error_message = "VM size must start with 'Standard_' (Azure requirement)."
  }
}

# =========================================================
# ADMIN USER (SECURITY HARDENED)
# =========================================================

variable "admin_username" {
  type        = string
  description = "Admin username for VM"

  validation {
    condition = !contains(
      ["admin", "root", "administrator"],
      lower(var.admin_username)
    )

    error_message = "Username not allowed for security reasons"
  }
}

# =========================================================
# SSH AUTHENTICATION
# =========================================================

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM authentication"
}

# =========================================================
# TAGGING
# =========================================================

variable "tags" {
  type        = map(string)
  description = "Tags applied to compute resources"

  default = {
    environment = "dev"
    managed_by  = "terraform"
    module      = "compute"
  }
}