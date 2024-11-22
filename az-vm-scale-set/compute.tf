resource "azurerm_linux_virtual_machine_scale_set" "demo_scale_set" {
    name                = "vmss-${random_string.randomizer.result}"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location

    # Using the cheapest sku possible for the demo
    sku                 = "Standard_B1s"
    instances           = 2
    
    admin_username = var.username

    admin_ssh_key {
        username   = var.username
        public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
    }
    
    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }
    
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    
    network_interface {
        name    = "vmss-nic-${random_string.randomizer.result}"
        primary = true
    
        ip_configuration {
            name                          = "vmss-ip-cfg"
            primary                       = true
            subnet_id                     = azurerm_subnet.demo_subnet.id
            load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.demo_lb_pool.id]
        }
    }

    # Ensuring that extensions are installed after the VM is created
    # Without this, you will need to manually "upgrade"
    # each VM in the scale set
    upgrade_mode = "Automatic"
}