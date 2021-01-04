resource "azurerm_virtual_machine" "main" {
  name                  = "sample-vm"
  location              = azurerm_resource_group.samplevmgroup.location
  resource_group_name   = azurerm_resource_group.samplevmgroup.name
  network_interface_ids = [azurerm_network_interface.samplevmnic.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "sample-vm1"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_windows_config{

  }
#  os_profile_linux_config {
#    disable_password_authentication = false
#  }
  tags = {
    environment = "sample-vm"
  }
}

resource "azurerm_public_ip" "samplepublicip" {
    name                         = "sample-vm-public-ip"
    location                     = "japaneast"
    resource_group_name          = azurerm_resource_group.samplevmgroup.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "sample-vm"
    }
}


resource "azurerm_network_interface" "samplevmnic" {
    name                        = "sample-vm-network-interface"
    location                    = "japaneast"
    resource_group_name         = azurerm_resource_group.samplevmgroup.name

    ip_configuration {
        name                          = "sample-vm-ip-configuration"
        subnet_id                     = azurerm_subnet.samplesubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.samplepublicip.id
    }

    tags = {
        environment = "sample-vm"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "samplevmnic" {
    network_interface_id      = azurerm_network_interface.samplevmnic.id
    network_security_group_id = azurerm_network_security_group.samplensg.id
}
