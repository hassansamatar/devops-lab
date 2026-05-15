# =========================================================
# VM OUTPUTS
# =========================================================

output "vm_id" {
  description = "Virtual Machine ID"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_name" {
  description = "Virtual Machine name"
  value       = azurerm_linux_virtual_machine.vm.name
}

# =========================================================
# NETWORK OUTPUTS
# =========================================================

output "private_ip" {
  description = "Private IP address of the VM"
  value       = azurerm_network_interface.nic.private_ip_address
}

output "nic_id" {
  description = "Network Interface ID"
  value       = azurerm_network_interface.nic.id
}

# =========================================================
# SSH ACCESS (BASTION-READY)
# =========================================================

output "ssh_command" {
  description = "SSH command (for Bastion usage or private network)"
  value       = "ssh ${var.admin_username}@<use-bastion-or-private-ip>"
}