# VM public IP address
output "vm_public_ip" {
  value = azurerm_public_ip.demo_public_ip.ip_address
}

output "vm_admin_pwd" {
  sensitive = true
  value     = azurerm_windows_virtual_machine.demo-vm.admin_password
}