resource "azurerm_virtual_network" "demo" {
  name                = "existing-vnet1"
  resource_group_name = "demo-rg"
  location = "centralus"
  address_space = ["10.0.0.0/16"]
}

import {
  to = azurerm_virtual_network.demo

  # To find this string, use the Azure CLI:
  # az network vnet show --n existing-vnet1 -g demo-rg --query id -o tsv 
  id = "<vnet_id>"
}