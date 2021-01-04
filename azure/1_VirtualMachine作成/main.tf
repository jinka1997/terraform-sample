#variable "tag_name" {}
#variable "tag_environment" {}

resource "azurerm_resource_group" "samplevmgroup" {
    name     = "sample-virtual-machine"
    location = "japaneast"

    tags = {
        environment = "sample-vm"
    }
}