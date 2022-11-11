resource "azurerm_virtual_network" "vault-vnet" {
  name                = "vault-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.vault.location
  resource_group_name = azurerm_resource_group.vault.name
}

resource "azurerm_subnet" "raft" {
  name                 = "raft"
  resource_group_name  = azurerm_resource_group.vault.name
  virtual_network_name = azurerm_virtual_network.vault-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "external" {
  name                 = "external"
  resource_group_name  = azurerm_resource_group.vault.name
  virtual_network_name = azurerm_virtual_network.vault-vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_interface" "nic-raft" {
  count               = 3
  name                = "vault-raft-nic${count.index}"
  location            = azurerm_resource_group.vault.location
  resource_group_name = azurerm_resource_group.vault.name

  ip_configuration {
    name                          = "raft"
    subnet_id                     = azurerm_subnet.raft.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.${count.index + 20}"
  }
}

resource "azurerm_network_interface" "nic-external" {
  count               = 3
  name                = "vault-external-nic${count.index}"
  location            = azurerm_resource_group.vault.location
  resource_group_name = azurerm_resource_group.vault.name

  ip_configuration {
    name                          = "external"
    subnet_id                     = azurerm_subnet.external.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.3.${count.index + 20}"
  }
}