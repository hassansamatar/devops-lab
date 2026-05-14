# =========================================================
# Virtual Network Outputs
# =========================================================

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "Virtual Network ID"
}

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Virtual Network name"
}

output "vnet_address_space" {
  value       = azurerm_virtual_network.vnet.address_space
  description = "Virtual Network address space"
}

# =========================================================
# Subnet Outputs
# =========================================================

output "subnet_id" {
  value       = azurerm_subnet.subnet.id
  description = "Subnet ID"
}

output "subnet_name" {
  value       = azurerm_subnet.subnet.name
  description = "Subnet name"
}

output "subnet_address_prefixes" {
  value       = azurerm_subnet.subnet.address_prefixes
  description = "Subnet CIDR ranges"
}

# =========================================================
# NSG Outputs
# =========================================================

output "nsg_id" {
  value       = azurerm_network_security_group.nsg.id
  description = "NSG ID"
}

output "nsg_name" {
  value       = azurerm_network_security_group.nsg.name
  description = "NSG name"
}

# =========================================================
# Security Reference Output
# =========================================================

output "allowed_ssh_ip" {
  value       = var.admin_ip
  description = "Allowed SSH IP"
}