# A VM based on Windows Server 2019 Datacenter

resource "random_password" "password" {
  length  = 16
  special = true
  lower   = true
  upper   = true
  numeric = true
}

resource "azurerm_windows_virtual_machine" "demo-vm" {
  name                  = "demo-vm"
  resource_group_name   = azurerm_resource_group.demo_rg.name
  location              = azurerm_resource_group.demo_rg.location
  size                  = "Standard_B2s"
  admin_username        = "adminuser"
  admin_password        = random_password.password.result
  network_interface_ids = [azurerm_network_interface.demo_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  tags = {
    "Name" = "Demo Virtual Machine"
  }


  # a script to run when the VM is created.
  # Let's inline a simle script using base64 encoding
  custom_data = base64encode("echo 'Hello, World!' > c:\\hello.txt")


  # associate the VM with an availability set
  # adding this line after you've already created the vm will
  # lead Terraform to destroy and recreate the VM

  # availability_set_id = azurerm_availability_set.demo-availability-set.id
}

# We can make this VM a part of an availability set
# This is a way to ensure high availability

# resource "azurerm_availability_set" "demo-availability-set" {
#     name = "demo-availability-set"
#     resource_group_name = azurerm_resource_group.demo_rg.name
#     location = azurerm_resource_group.demo_rg.location
#     managed = true
#     platform_update_domain_count = 3
#     platform_fault_domain_count = 3
# }

# Install IIS on the VM
resource "azurerm_virtual_machine_extension" "demo-vm-iis" {
  name                 = "demo-vm-iis"
  virtual_machine_id   = azurerm_windows_virtual_machine.demo-vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    }
    SETTINGS

}