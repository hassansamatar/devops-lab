variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
}

variable "location" {
  description = "Azure region (e.g. westeurope)"
  type        = string
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet CIDR address space"
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
  description = "Allowed SSH IP in CIDR format (e.g. 77.18.33.196/32)"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    environment = "dev"
    managed_by  = "terraform"
  }
}