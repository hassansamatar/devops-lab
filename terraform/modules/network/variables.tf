# =========================================================
# CORE CONFIGURATION
# =========================================================

variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

# =========================================================
# VIRTUAL NETWORK
# =========================================================

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

variable "vnet_address_space" {
  description = "Virtual network CIDR ranges"
  type        = list(string)
}

# =========================================================
# SUBNET
# =========================================================

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Subnet CIDR ranges"
  type        = list(string)
}

# =========================================================
# NETWORK SECURITY GROUP
# =========================================================

variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
}

# =========================================================
# SECURITY
# =========================================================

variable "admin_ip" {
  description = "Allowed SSH IP in CIDR format"
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
    module      = "network"
  }
}