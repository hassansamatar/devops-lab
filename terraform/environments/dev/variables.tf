# =========================================================
# Global / Environment
# =========================================================

variable "location" {
  description = "Azure region where all resources will be deployed (e.g., westeurope)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

# =========================================================
# Networking variables
# =========================================================

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "vnet_address_space" {
  description = "CIDR address space for the Virtual Network"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the subnet inside the Virtual Network"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "CIDR range for the subnet"
  type        = list(string)
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

# =========================================================
# Compute variables
# =========================================================

variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the Virtual Machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the virtual machine"
  type        = string
  sensitive   = true
}