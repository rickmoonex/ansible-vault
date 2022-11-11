data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "vault" {
  name                        = "vaultkeyvaultjemoeder"
  location                    = azurerm_resource_group.vault.location
  resource_group_name         = azurerm_resource_group.vault.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azuread_client_config.current.tenant_id
    object_id = azuread_service_principal.vault.object_id

    key_permissions = [
      "Get",
      "WrapKey",
      "UnwrapKey",
    ]
  }

  access_policy {
    tenant_id = data.azuread_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Delete",
      "Update",
    ]
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}

resource "azurerm_key_vault_key" "generated" {
  name         = "unseal"
  key_vault_id = azurerm_key_vault.vault.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "wrapKey",
    "unwrapKey",
  ]
}