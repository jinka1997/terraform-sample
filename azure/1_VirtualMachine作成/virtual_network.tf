resource "azurerm_virtual_network" "samplenetwork" {
    name                = "sample-vm-network"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.samplevmgroup.location
    resource_group_name = azurerm_resource_group.samplevmgroup.name

    tags = {
        environment = "sample-vm"
    }
}

resource "azurerm_subnet" "samplesubnet" {
    name                 = "sample-vm-public1"
    resource_group_name  = azurerm_resource_group.samplevmgroup.name
    virtual_network_name = azurerm_virtual_network.samplenetwork.name
    address_prefixes       = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "samplensg" {
    name                = "sample-vm-network-security-group"
    location            = azurerm_resource_group.samplevmgroup.location
    resource_group_name = azurerm_resource_group.samplevmgroup.name

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

    tags = {
        environment = "sample-vm"
    }
}


