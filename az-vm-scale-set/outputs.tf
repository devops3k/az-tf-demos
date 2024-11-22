
# The public key generated by the azapi_resource_action resource
output "key_data" {
  value = azapi_resource_action.ssh_public_key_gen.output.publicKey
  description = "Value of the public key for VMSS machines"
  sensitive = true
}

# The private key generated by the azapi_resource_action resource
output "private_key_data" {
  value = azapi_resource_action.ssh_public_key_gen.output.privateKey
  description = "Value of the private key for VMSS machines"
  sensitive = true
}

# Public IP of the Load Balancer
output "lb_public_ip" {
  value = azurerm_public_ip.demo_ip.ip_address
  description = "Public IP of the Load Balancer"
}