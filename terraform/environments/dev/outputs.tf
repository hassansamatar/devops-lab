# =========================================================
# Resource Group Outputs
# =========================================================

output "resource_group_name" {
  description = "Name of the Azure Resource Group"
  value       = azurerm_resource_group.dev_rg.name
}

output "resource_group_location" {
  description = "Azure region where the Resource Group is deployed"
  value       = azurerm_resource_group.dev_rg.location
}