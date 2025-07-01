
data "azurerm_subnet" "subneet"{
  for_each = var.bastionvalue
  name                 =each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
}




resource "azurerm_public_ip" "bastion_ip" {
    for_each = var.bastionvalue
  name                = each.value.public_ip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
    for_each = var.bastionvalue
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.subneet[each.key].id
    public_ip_address_id = azurerm_public_ip.bastion_ip[each.key].id
  }
}