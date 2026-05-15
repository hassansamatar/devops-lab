# =========================================================
# VIRTUAL NETWORK OUTPUTS
# =========================================================

output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Virtual Network name"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_address_space" {
  description = "Virtual Network address space"
  value       = azurerm_virtual_network.vnet.address_space
}

# =========================================================
# SUBNET OUTPUTS
# =========================================================

output "subnet_id" {
  description = "Subnet ID"
  value       = azurerm_subnet.subnet.id
}

output "subnet_name" {
  description = "Subnet name"
  value       = azurerm_subnet.subnet.name
}

output "subnet_address_prefixes" {
  description = "Subnet CIDR ranges"
  value       = azurerm_subnet.subnet.address_prefixes
}

# =========================================================
# NETWORK SECURITY GROUP OUTPUTS
# =========================================================

output "nsg_id" {
  description = "Network Security Group ID"
  value       = azurerm_network_security_group.nsg.id
}

output "nsg_name" {
  description = "Network Security Group name"
  value       = azurerm_network_security_group.nsg.name
}

# =========================================================
# SECURITY REFERENCE OUTPUT
# =========================================================

output "allowed_ssh_ip" {
  description = "Allowed SSH IP (from tfvars)"
  value       = var.admin_ip
}