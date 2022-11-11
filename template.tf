data "template_cloudinit_config" "config1" {
  base64_encode = true
  gzip          = false

  part {
    filename     = "certs.sh"
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloud-init/certs.tftpl", {
      ca_cert  = file("${path.module}/certs/ca.pem"),
      tls_cert = file("${path.module}/certs/tls.crt"),
      tls_key  = file("${path.module}/certs/tls.key")
    })
  }

  part {
    filename     = "config.sh"
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloud-init/config.tftpl", {
      node_id             = "vault1",
      domain              = "vault.cloudshaperstest.nl",
      secondary_nodes     = ["vault2", "vault3"],
      azure_vault_name    = azurerm_key_vault.vault.name,
      azure_key_name      = azurerm_key_vault_key.generated.name,
      api_name            = "api",
      azure_tenant_id     = azuread_service_principal.vault.application_tenant_id,
      azure_client_id     = azuread_application.app.application_id,
      azure_client_secret = azuread_application_password.app.value
    })
  }
}

data "template_cloudinit_config" "config2" {
  base64_encode = true
  gzip          = false

  part {
    filename     = "certs.sh"
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloud-init/certs.tftpl", {
      ca_cert  = file("${path.module}/certs/ca.pem"),
      tls_cert = file("${path.module}/certs/tls.crt"),
      tls_key  = file("${path.module}/certs/tls.key")
    })
  }

  part {
    filename     = "config.sh"
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloud-init/config.tftpl", {
      node_id             = "vault2",
      domain              = "vault.cloudshaperstest.nl",
      secondary_nodes     = ["vault1", "vault3"],
      azure_vault_name    = azurerm_key_vault.vault.name,
      azure_key_name      = azurerm_key_vault_key.generated.name,
      api_name            = "api",
      azure_tenant_id     = azuread_service_principal.vault.application_tenant_id,
      azure_client_id     = azuread_application.app.application_id,
      azure_client_secret = azuread_application_password.app.value
    })
  }
}

data "template_cloudinit_config" "config3" {
  base64_encode = true
  gzip          = false

  part {
    filename     = "certs.sh"
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloud-init/certs.tftpl", {
      ca_cert  = file("${path.module}/certs/ca.pem"),
      tls_cert = file("${path.module}/certs/tls.crt"),
      tls_key  = file("${path.module}/certs/tls.key")
    })
  }

  part {
    filename     = "config.sh"
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/cloud-init/config.tftpl", {
      node_id             = "vault3",
      domain              = "vault.cloudshaperstest.nl",
      secondary_nodes     = ["vault2", "vault1"],
      azure_vault_name    = azurerm_key_vault.vault.name,
      azure_key_name      = azurerm_key_vault_key.generated.name,
      api_name            = "api",
      azure_tenant_id     = azuread_service_principal.vault.application_tenant_id,
      azure_client_id     = azuread_application.app.application_id,
      azure_client_secret = azuread_application_password.app.value
    })
  }
}