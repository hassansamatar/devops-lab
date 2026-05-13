output "vnet_id" {
  description = "Virtual network ID"

  value = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  description = "Subnet ID"

  value = azurerm_subnet.subnet.id
}

output "nsg_id" {
  description = "Network Security Group ID"

  value = azurerm_network_security_group.nsg.id
}