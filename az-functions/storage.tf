resource "azurerm_storage_account" "demo_sa" {
  name                     = "${random_string.prefix.result}sa"
  resource_group_name      = azurerm_resource_group.demo_rg.name
  location                 = azurerm_resource_group.demo_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# resource "azurerm_storage_container" "demo_sc" {
#   name                  = "${random_string.prefix.result}sc"
#   storage_account_name  = azurerm_storage_account.demo_sa.name
#   container_access_type = "blob"

# }