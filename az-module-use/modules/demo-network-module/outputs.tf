# output for vnet id and subnet id's
output "vnet_id" {
  description = "The ID of the VNet."
  #value depends on if we are using existing VNet or creating a new one
  value = local.vnet_name
}

output "subnet_ids" {
  description = "The IDs of the subnets."
  value       = azurerm_subnet.subnet[*].id
}