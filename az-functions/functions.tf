# create a function app that uses the storage account already created
resource "azurerm_linux_function_app" "demo_fa" {
  name                       = "${random_string.prefix.result}fa"
  resource_group_name        = azurerm_resource_group.demo_rg.name
  location                   = azurerm_resource_group.demo_rg.location
  service_plan_id            = azurerm_service_plan.demo_app_service_plan.id
  storage_account_name       = azurerm_storage_account.demo_sa.name
  storage_account_access_key = azurerm_storage_account.demo_sa.primary_access_key
  site_config {

  }
}

# A service plan with sku B2 and Linux OS
resource "azurerm_service_plan" "demo_app_service_plan" {
  name                = "${random_string.prefix.result}-demo-app-service-plan"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  sku_name            = "B2"
  os_type             = "Linux"
}