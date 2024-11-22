# Query Marketplace for Ubuntu 20.04 LTS
data "azurerm_platform_image" "linux_image" {
  location  = "West Europe"
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-focal"
  sku       = "20_04-lts"
}

output "linux_id" {
  value = data.azurerm_platform_image.linux_image.id
}

data "azurerm_platform_image" "win_image" {
  location  = "centralus"
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2022-datacenter-azure-edition-core"
  version = "20348.2402.240607"
}

output "win_id" {
  value = data.azurerm_platform_image.win_image.id
}
# AZ CLI Equivalent
# az vm image show  --location "centralus" --publisher "MicrosoftWindowsServer" --offer "WindowsServer" --sku "2022-datacenter-azure-edition-core" --version "20348.2402.240607" --query "id"

