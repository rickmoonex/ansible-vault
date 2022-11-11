resource "azurerm_public_ip" "nat-pip" {
  name                = "nat-gateway-pip"
  location            = azurerm_resource_group.vault.location
  resource_group_name = azurerm_resource_group.vault.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_nat_gateway" "nat" {
  name                    = "nat-gateway"
  location                = azurerm_resource_group.vault.location
  resource_group_name     = azurerm_resource_group.vault.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_subnet_nat_gateway_association" "nat" {
  subnet_id      = azurerm_subnet.external.id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}