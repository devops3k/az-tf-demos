terraform {
    required_version = "~>1.8"
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "~>3.0"
      }
    }
}

provider "azurerm" {
  features {}
}

# resource "azurerm_resource_group" "demo_rg" {
#   name     = "demo_rg"
#   location = "centralus"
# }