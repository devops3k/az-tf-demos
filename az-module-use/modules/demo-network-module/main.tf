resource "random_string" "random_prefix" {
    length = 4
    special = false
    upper = false
}

locals {
    vnet_name = var.vnet_name == null ? "${random_string.random_prefix.id}-vnet" : var.vnet_name
}

resource "azurerm_virtual_network" "vnet" {
    # if vnet_name is not provided, create a new VNet
    count               = var.vnet_name == null ? 1 : 0
    name                = local.vnet_name
    resource_group_name = var.resource_group_name
    location            = var.resource_group_location
    address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
    count               = length(var.subnet_prefixes)
    name                = "${local.vnet_name}-subnet-${count.index+1}"
    resource_group_name = var.resource_group_name
    # if vnet_name is provided, use the existing VNet
    # Note, re: dependency: using local.vnet_name does not create implicit
    # dependency on azurerm_virtual_network.vnet. And given we cannot use
    # explicit dependency against a resource in parent module, we need to
    # have a conditional below.
    virtual_network_name = var.vnet_name == null ? azurerm_virtual_network.vnet[0].name : var.vnet_name
    address_prefixes    = [var.subnet_prefixes[count.index]]
}