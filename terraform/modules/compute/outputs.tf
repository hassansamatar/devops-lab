# =========================================================
# VM Outputs
# =========================================================

output "vm_id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "Virtual Machine ID"
}

output "vm_name" {
  value       = azurerm_linux_virtual_machine.vm.name
  description = "Virtual Machine name"
}

# =========================================================
# Network Interface Outputs
# =========================================================

output "private_ip" {
  value       = azurerm_network_interface.nic.private_ip_address
  description = "Private IP address"
}

output "nic_id" {
  value       = azurerm_network_interface.nic.id
  description = "Network Interface ID"
}

# =========================================================
# Public IP
# =========================================================

output "public_ip" {
  value       = azurerm_public_ip.public_ip.ip_address
  description = "Public IP address"
}

# =========================================================
# SSH Helper
# =========================================================

output "ssh_command" {
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.public_ip.ip_address}"
  description = "SSH command"
}