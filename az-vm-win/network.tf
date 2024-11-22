resource "azurerm_virtual_network" "demo_network" {
  name                = "demo-vnet"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  address_space       = ["10.0.0.0/16"]

  tags = {
    "Name" = "Demo Virtual Network"
  }
}

resource "azurerm_subnet" "demo_subnet" {
  address_prefixes     = ["10.0.0.0/24"]
  name                 = "demo-subnet"
  resource_group_name  = azurerm_resource_group.demo_rg.name
  virtual_network_name = azurerm_virtual_network.demo_network.name
}

# Network Interface
resource "azurerm_network_interface" "demo_nic" {
  name                = "demo-nic"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.demo_subnet.id
    private_ip_address_allocation = "Dynamic"

    # optionally, associate a public IP address with the NIC
    # this requires a separate resource for the public IP address
    public_ip_address_id = azurerm_public_ip.demo_public_ip.id
  }
}

# Public IP to be associated with the VM Nic
resource "azurerm_public_ip" "demo_public_ip" {
  name                = "demo-public-ip"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name
  allocation_method   = "Dynamic"
}

# Network Security Group that allows inbound RDP and Web access
resource "azurerm_network_security_group" "demo_nsg" {
  name                = "demo-nsg"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name

  security_rule {
    name                       = "RDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate the NSG with the NIC
resource "azurerm_network_interface_security_group_association" "demo_nsg_association" {
  network_interface_id      = azurerm_network_interface.demo_nic.id
  network_security_group_id = azurerm_network_security_group.demo_nsg.id
}