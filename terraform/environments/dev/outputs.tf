# =========================================================
# RESOURCE GROUP
# =========================================================

output "resource_group_name" {
  value = azurerm_resource_group.dev_rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.dev_rg.location
}

# =========================================================
# VM ACCESS
# =========================================================

output "vm_public_ip" {
  value = module.compute.public_ip
}

output "vm_private_ip" {
  value = module.compute.private_ip
}

output "ssh_command" {
  value = module.compute.ssh_command
}

output "vm_id" {
  value = module.compute.vm_id
}