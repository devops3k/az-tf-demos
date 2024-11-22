resource "azurerm_virtual_network" "demo_network" {
    name = "demo-vnet${var.app_suffix}"
    resource_group_name = azurerm_resource_group.demo_rg.name
    location = azurerm_resource_group.demo_rg.location
    address_space = ["10.0.0.0/16"]

    tags = {
      "Name" = "Demo Virtual Network"
    }
}

# output "vnet_id" {
#     value = azurerm_virtual_network.demo_network.id
# }

resource "azurerm_subnet" "demo_subnet0" {
    address_prefixes = [ "10.0.0.0/24" ]
    name = "demo-subnet0"
    resource_group_name = azurerm_resource_group.demo_rg.name
    virtual_network_name = azurerm_virtual_network.demo_network.name
}

# a local variable called subnet_cidrs with four subnet cidr values from 10.0.1.0/24 to 10.0.4.0/24
locals {
    subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
      subnet_cidrs_map = {
        subnet1 = "10.0.1.0/24"
        subnet2 = "10.0.2.0/24"
        subnet3 = "10.0.3.0/24"
        subnet4 = "10.0.4.0/24"
      }
}

# create four subnets using the local variable subnet_cidrs. Use count to create multiple resources
# resource "azurerm_subnet" "demo_subnet" {
#     count = length(local.subnet_cidrs)
#     address_prefixes = [ local.subnet_cidrs[count.index] ]
#     name = "demo-subnet-${count.index+1}${var.app_suffix}"
#     resource_group_name = azurerm_resource_group.demo_rg.name
#     virtual_network_name = azurerm_virtual_network.demo_network.name
# }

resource "azurerm_subnet" "demo_subnet" {
    for_each = local.subnet_cidrs_map
    address_prefixes = [each.value] # each.value is the values of the map as a list
    name = "demo-subnet-${each.key}${var.app_suffix}"
    resource_group_name = azurerm_resource_group.demo_rg.name
    virtual_network_name = azurerm_virtual_network.demo_network.name
}

# when saving plan, provide the value for the variable app_suffix
# when you apply this plan file, it will use what you provided in the plan file
variable "app_suffix" {
    type = string
}