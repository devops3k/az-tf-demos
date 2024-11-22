
# # creating permissions for the web app to access the storage account
# resource "azurerm_user_assigned_identity" "demo_identity" {
#   name                = "${random_string.prefix.result}-identity"
#   resource_group_name = azurerm_resource_group.demo_rg.name
#   location            = azurerm_resource_group.demo_rg.location
# }

# resource "azurerm_role_assignment" "assign_role" {
#   scope                = azurerm_storage_account.demo_sa.id
#   role_definition_name = "Storage Blob Data Reader"
#   principal_id         = azurerm_user_assigned_identity.demo_identity.principal_id
# }


resource "azurerm_storage_account" "demo_sa" {
  name                     = "${random_string.prefix.result}sa"
  resource_group_name      = azurerm_resource_group.demo_rg.name
  location                 = azurerm_resource_group.demo_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "demo_sc" {
  name                  = "${random_string.prefix.result}sc"
  storage_account_name  = azurerm_storage_account.demo_sa.name
  container_access_type = "blob"

}

resource "azurerm_storage_blob" "zip_blob" {
  name                   = "site.zip"
  storage_account_name   = azurerm_storage_account.demo_sa.name
  storage_container_name = azurerm_storage_container.demo_sc.name
  type                   = "Block"
  source                 = data.archive_file.site_zip.output_path

    # to trigger update to blob when zip file's hash is updated
    
}

data "archive_file" "site_zip" {
  type        = "zip"
  source_dir  = "${path.module}/site"
  output_path = "${path.module}/site.zip"
}