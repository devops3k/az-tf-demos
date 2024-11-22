resource "azurerm_storage_account" "demo_sa" {
    name                     = "demosa${random_string.storage-suffix.result}"
    resource_group_name      = azurerm_resource_group.demo_rg_storage.name
    location                 = azurerm_resource_group.demo_rg_storage.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
}

# A container in the storage account for storing txt files
resource "azurerm_storage_container" "demo_container" {
    name                  = "democontainer"
    storage_account_name  = azurerm_storage_account.demo_sa.name

    # this access level is private by default
    # but here we are explicitly setting it to blob
    container_access_type = "blob"
}

# this is how we can upload the hello.txt file to the container
resource "azurerm_storage_blob" "demo_blob" {
    name                   = "hello.txt"
    storage_account_name   = azurerm_storage_account.demo_sa.name
    storage_container_name = azurerm_storage_container.demo_container.name
    type                   = "Block"
    source                 = "hello.txt"
}


# random string of size 8, alphanumeric for storage account name
resource "random_string" "storage-suffix" {
    length  = 8
    special = false
    upper   = false
}