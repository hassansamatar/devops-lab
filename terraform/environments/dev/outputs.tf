# =========================================================
# RESOURCE GROUP OUTPUTS
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
# COMPUTE OUTPUTS
# =========================================================

output "vm_private_ip" {
  description = "VM private IP address"
  value       = module.compute.private_ip
}

output "ssh_command" {
  description = "SSH command (REMOVE after Bastion migration)"
  value       = module.compute.ssh_command
}

output "vm_id" {
  description = "Azure Virtual Machine resource ID"
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

# =========================================================
# BASTION OUTPUTS (NEW - IMPORTANT)
# =========================================================

output "bastion_name" {
  description = "Azure Bastion Host name"
  value       = module.network.bastion_name
}

output "bastion_public_ip" {
  description = "Azure Bastion public IP"
  value       = module.network.bastion_public_ip
}