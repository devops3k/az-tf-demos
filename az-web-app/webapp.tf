
# This app service plan is for the web app
resource "azurerm_service_plan" "demo_app_service_plan" {
  name                = "${random_string.prefix.result}-demo-app-service-plan"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  sku_name = "B2"
  os_type = "Linux"
}

# linux web app
resource "azurerm_linux_web_app" "demo-web-app" {
  name                = "${random_string.prefix.result}-demo-app"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_service_plan.demo_app_service_plan.location
  service_plan_id     = azurerm_service_plan.demo_app_service_plan.id

  site_config {}
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = azurerm_storage_blob.zip_blob.url
  }

#   identity {
#     type         = "UserAssigned"
#     identity_ids = [azurerm_user_assigned_identity.demo_identity.id]
#   }
}

output "website_url" {
  value = azurerm_linux_web_app.demo-web-app.default_hostname
}

output "blob_url" {
  value = azurerm_storage_blob.zip_blob.url
}