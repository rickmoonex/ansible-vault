data "azuread_client_config" "current" {}

resource "azuread_application" "app" {
  display_name = "vaultautounseal"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "app" {
  application_object_id = azuread_application.app.object_id
}

resource "azuread_service_principal" "vault" {
  application_id               = azuread_application.app.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}