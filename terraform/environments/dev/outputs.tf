# =========================================================
# RESOURCE GROUP
# =========================================================

output "resource_group_name" {
  description = "Name of the Azure Resource Group"
  value       = azurerm_resource_group.dev_rg.name
}

output "resource_group_location" {
  description = "Azure region of the Resource Group"
  value       = azurerm_resource_group.dev_rg.location
}

# =========================================================
# VM ACCESS
# =========================================================

output "vm_public_ip" {
  description = "Public IP address of the Virtual Machine"
  value       = module.compute.public_ip
}

output "vm_private_ip" {
  description = "Private IP address of the Virtual Machine"
  value       = module.compute.private_ip
}

output "ssh_command" {
  description = "SSH command to connect to the VM"
  value       = module.compute.ssh_command
}

output "vm_id" {
  description = "Azure Virtual Machine resource ID"
  value       = module.compute.vm_id
}