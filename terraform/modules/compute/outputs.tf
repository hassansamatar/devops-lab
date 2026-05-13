output "vm_id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "Virtual Machine ID"
}

output "private_ip" {
  value       = azurerm_network_interface.nic.private_ip_address
  description = "Private IP address of VM"
}

output "nic_id" {
  value       = azurerm_network_interface.nic.id
  description = "Network Interface ID"
}