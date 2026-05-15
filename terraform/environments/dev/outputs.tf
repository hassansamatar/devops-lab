# =========================================================
# RESOURCE GROUP
# =========================================================

output "resource_group_name" {
  description = "Azure Resource Group name"
  value       = azurerm_resource_group.dev_rg.name
}

output "resource_group_location" {
  description = "Azure region"
  value       = azurerm_resource_group.dev_rg.location
}

# =========================================================
# VM OUTPUTS
# =========================================================

output "vm_public_ip" {
  description = "VM public IP"
  value       = module.compute.public_ip
}

output "vm_private_ip" {
  description = "VM private IP"
  value       = module.compute.private_ip
}

output "ssh_command" {
  description = "SSH connection command"
  value       = module.compute.ssh_command
}

output "vm_id" {
  description = "Azure VM resource ID"
  value       = module.compute.vm_id
}

# =========================================================
# KEY VAULT OUTPUTS
# =========================================================

output "key_vault_name" {
  description = "Azure Key Vault name"
  value       = module.keyvault.key_vault_name
}

output "key_vault_uri" {
  description = "Azure Key Vault URI"
  value       = module.keyvault.key_vault_uri
}