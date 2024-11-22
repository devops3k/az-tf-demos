
# A managed disk can be added after the VM is created
# The disk can be attached while it's in the running state

# a manged disk to be used as a data disk
resource "azurerm_managed_disk" "demo-disk" {
  name                 = "demo-disk"
  location             = azurerm_resource_group.demo_rg.location
  resource_group_name  = azurerm_resource_group.demo_rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 16
}

# associate the managed disk with the VM
# resource "azurerm_virtual_machine_data_disk_attachment" "demo-disk-attachment" {
#     managed_disk_id = azurerm_managed_disk.demo-disk.id
#     virtual_machine_id = azurerm_windows_virtual_machine.demo-vm.id
#     lun = 0 # purpose of lun is to identify the disk in the VM
#     caching = "ReadWrite"
# }