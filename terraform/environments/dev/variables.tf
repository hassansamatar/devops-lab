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

variable "admin_ip" {
  type        = string
  description = "Your public IP in CIDR format (e.g. 77.18.33.196/32)"
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
  type = string
}

# =========================================================
# TAGS
# =========================================================

variable "tags" {
  type = map(string)
}