data "azurerm_subnet" "subneet" {
  for_each = var.nat_value
  name                 = each.value.name_sub
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
}


resource "azurerm_public_ip" "nat_ip" {
  for_each = var.nat_value
  name                = each.value.name
  location            = each.value.location
  resource_group_name = "dev-rg"
  allocation_method   = "Static"
  sku                 = "Standard"
  
}

resource "azurerm_nat_gateway" "nat_gateway" {
  for_each = var.nat_value
  name                    = each.value.name
  location                = "East US"
  resource_group_name     = "dev-rg"
  sku_name                = "Standard"
  
}
resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_association" {
  for_each = var.nat_value
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway[each.key].id
  public_ip_address_id = azurerm_public_ip.nat_ip[each.key].id
}

resource "azurerm_subnet_nat_gateway_association" "nat_subnet_association" {
  for_each = var.nat_value
  subnet_id      = data.azurerm_subnet.subneet[each.key].id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway[each.key].id
}



































# data "azurerm_subnet" "target_subnet" {
#   name                 = var.subnet_name
#   virtual_network_name = var.vnet_name
#   resource_group_name  = var.resource_group_name
# }

# resource "azurerm_public_ip" "nat_pip" {
#   name                = var.nat_public_ip_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# resource "azurerm_nat_gateway" "nat" {
#   name                = var.nat_gateway_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   sku_name            = "Standard"

#   public_ip_address_ids = [azurerm_public_ip.nat_pip.id]
# }

# resource "azurerm_nat_gateway_public_ip_association" "example" {
#   nat_gateway_id       = azurerm_nat_gateway.example.id
#   public_ip_address_id = azurerm_public_ip.example.id
# }
