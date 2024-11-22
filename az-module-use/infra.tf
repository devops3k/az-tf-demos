# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-az-module-demo"
  location = "centralus"
}

# Use the demo-network-module
module "demo_network" {
  source              = "./modules/demo-network-module"
  resource_group_name = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

# Output the VNet ID and Subnet IDs
output "module_vnet_id" {
  value = module.demo_network.vnet_id
}
output "module_subnet_ids" {
  value = module.demo_network.subnet_ids
}

#vnet
resource "azurerm_virtual_network" "hello_vnet" {
  name                = "hello-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.1.0.0/16"]
}

# Use the demo-network-module with existing vnet
module "demo_network_existing_vnet" {
  source              = "./modules/demo-network-module"
  resource_group_name = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
  vnet_name           = azurerm_virtual_network.hello_vnet.name #vnet!
  subnet_prefixes     = ["10.1.1.0/24","10.1.2.0/24"]
}

#output the vnet id and subnet ids
output "module_vnet_id_existing_vnet" {
  value = module.demo_network_existing_vnet.vnet_id
}
output "module_subnet_ids_existing_vnet" {
  value = module.demo_network_existing_vnet.subnet_ids
}