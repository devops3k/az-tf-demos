terraform {
  required_version = "~>1.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    # azapi = {
    #   source  = "azure/azapi"
    #   version = "~>1.5"
    # }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "demo_rg" {
  name     = "demo_rg_web_app"
  # central us location as code
  location = "centralus"
}