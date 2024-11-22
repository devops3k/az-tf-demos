terraform {
  required_version = "~>1.8"
  required_providers {

    # No need for azurerm provider as we are only creating ad users
    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "~>3.0"
    # }
    
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.41"
    }
  }
}

provider "azurerm" {
  features {}
}

# No need for resource group as we are only creating ad users
# resource "azurerm_resource_group" "demo_rg" {
#   name     = "demo_rg_web_app"
#   # central us location as code
#   location = "centralus"
# }