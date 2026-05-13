variable "resource_group_name" {
  type        = string
  description = "Resource group where VM will be deployed"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID from network module"
}

variable "vm_name" {
  type        = string
  description = "Virtual machine name"
  default     = "dev-vm"
}

variable "vm_size" {
  type        = string
  description = "VM size SKU"
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  description = "Admin username for VM"
  default     = "azureuser"
}

variable "admin_password" {
  type        = string
  description = "Admin password for VM"
  sensitive   = true
}