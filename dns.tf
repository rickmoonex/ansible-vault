resource "azurerm_private_dns_zone" "dns" {
  name                = "vault.cloudshaperstest.nl"
  resource_group_name = azurerm_resource_group.vault.name
}

resource "azurerm_private_dns_a_record" "vault" {
  count               = 3
  name                = "vault${count.index + 1}"
  zone_name           = azurerm_private_dns_zone.dns.name
  resource_group_name = azurerm_resource_group.vault.name
  ttl                 = 300
  records             = ["10.0.2.${count.index + 20}"]
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  name                  = "vnet-link"
  resource_group_name   = azurerm_resource_group.vault.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vault-vnet.id
}