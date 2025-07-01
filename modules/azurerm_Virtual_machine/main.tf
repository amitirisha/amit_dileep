

data "azurerm_subnet" "subneet" {
  name                 = "dev-subnet"
  resource_group_name  = "dev-rg"
  virtual_network_name = "dev-vnet"
}

resource "azurerm_network_interface" "vm-nic" {
    for_each = var.vm_details
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subneet.id
    private_ip_address_allocation = "Dynamic"
    
  }
}

resource "azurerm_linux_virtual_machine" "example" {
    for_each = var.vm_details
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password       = "Password1234!" # Ensure to use a secure password or consider using SSH keys instead
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.vm-nic[each.key].id,
  ]

  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}