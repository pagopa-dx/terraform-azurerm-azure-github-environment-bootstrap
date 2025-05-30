resource "azurerm_user_assigned_identity" "app_cd" {
  resource_group_name = azurerm_resource_group.main.name
  location            = local.ids.location
  name                = format(local.ids.app_name, "cd")

  tags = local.tags
}

resource "azurerm_federated_identity_credential" "github_app_cd" {
  resource_group_name = azurerm_user_assigned_identity.app_cd.resource_group_name
  name                = format(local.ids.federated_identity_name, "app", "cd")
  audience            = local.ids.audience
  issuer              = local.ids.issuer
  parent_id           = azurerm_user_assigned_identity.app_cd.id
  subject             = "repo:pagopa/${var.repository.name}:environment:${format(local.ids.app_environment_name, "cd")}"
}
