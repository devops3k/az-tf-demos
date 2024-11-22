# Fetch existing resource group details for reference in other resources
data "azurerm_resource_group" "example" {
  name = "existing-rg"
}

# Retrieve subnet information for network configuration
data "azurerm_subnet" "example" {
  name                 = "subnet1"
  virtual_network_name = "vnet1"
  resource_group_name  = "rg1"
}

# Access secrets stored in Azure Key Vault
data "azurerm_key_vault_secret" "example" {
  name         = "secret-name"
  key_vault_id = azurerm_key_vault.example.id
}

# Get storage account properties for configuration or validation
data "azurerm_storage_account" "example" {
  name                = "storageaccountname"
  resource_group_name = "rg1"
}

# Retrieve Azure AD group details for role assignments
data "azuread_group" "example" {
  display_name = "Group Name"
}

# Find latest VM image for deployment
data "azurerm_platform_image" "example" {
  location  = "East US"
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "18.04-LTS"
}

# Get App Service Plan details for web app configuration
data "azurerm_service_plan" "example" {
  name                = "app-service-plan"
  resource_group_name = "rg1"
}

# Retrieve available AKS versions for cluster deployment
data "azurerm_kubernetes_service_versions" "example" {
  location = "East US"
}