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
provider "azurerm" {
  alias = "prod"
  features {
    virtual_machine {
      delete_os_disk_on_deletion = false
    }
  }
}

resource "azurerm_resource_group" "demo_rg" {
  provider = azurerm # could have also been azurerm.prod
  name     = "demo-rg"
  location = "centralus"
}