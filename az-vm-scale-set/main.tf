# Random string of size four, all lower case letters
resource "random_string" "randomizer" {
  length  = 4
  special = false
  upper   = false
  numeric = false
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "rg-${random_string.randomizer.result}"
}


# -
# - Custom Scripts
# -
data "local_file" "script_file" {
  filename = "${path.module}/script/installweb.sh"
}

# -
# - Virtual Machine Scale Set Extension
# -
resource "azurerm_virtual_machine_scale_set_extension" "vmss_script_extension" {
  name                         = "${azurerm_linux_virtual_machine_scale_set.demo_scale_set.name}-script-extension"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.demo_scale_set.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  settings = jsonencode({
    "script" = base64encode(data.local_file.script_file.content)
  })
  auto_upgrade_minor_version = true
}