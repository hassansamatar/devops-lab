# =========================================================
# CORE CONFIGURATION
# =========================================================

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
}

# =========================================================
# NETWORK
# =========================================================

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Subnet CIDR ranges"
  type        = list(string)
}

variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
}

variable "admin_ip" {
  description = "Allowed SSH IP in CIDR format"
  type        = string
}

# =========================================================
# COMPUTE
# =========================================================

variable "vm_name" {
  description = "Virtual machine name"
  type        = string
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
}

variable "admin_username" {
  description = "VM admin username"
  type        = string
}

# =========================================================
# TAGGING
# =========================================================

variable "tags" {
  description = "Common resource tags"
  type        = map(string)

  default = {
    environment = "dev"
    managed_by  = "terraform"
  }
}