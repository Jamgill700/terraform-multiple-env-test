provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  use_cli  = false
  use_oidc = true
}

provider "azuread" {
    tenant_id = var.tenant_id
    client_id = var.oidc_client_id
    client_secret = var.oidc_client_secret
}

data "azurerm_subscription" "current" {}

resource "azuread_application" "multiple_env" {
  display_name = "multiple-env-${var.environment}"
}

resource "azuread_service_principal" "multiple_env_service_principal" {
#   application_id = azuread_application.multiple_env.application_id
  client_id = azuread_application.multiple_env.client_id
}

# Creates a role assignment which controls the permissions the service
# principal has within the Azure subscription.
#
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "tfc_role_assignment" {
  scope                = data.azurerm_subscription.current.id
  principal_id         = azuread_service_principal.multiple_env_service_principal.object_id
  role_definition_name = "Contributor"
}

resource "azuread_application_federated_identity_credential" "tfc_federated_credential_plan" {
  application_object_id = azuread_application.multiple_env.object_id
  display_name          = "multiple-env-${var.environment}-plan"
  audiences             = [var.tfc_azure_audience]
  issuer                = "https://${var.tfc_hostname}"
  subject               = "organization:${var.tfc_organization_name}:project:${var.tfc_project_name}:workspace:${var.tfc_workspace_name}:run_phase:plan"
}

resource "azuread_application_federated_identity_credential" "tfc_federated_credential_apply" {
  application_object_id = azuread_application.multiple_env.object_id
  display_name          = "multiple-env-${var.environment}-apply"
  audiences             = [var.tfc_azure_audience]
  issuer                = "https://${var.tfc_hostname}"
  subject               = "organization:${var.tfc_organization_name}:project:${var.tfc_project_name}:workspace:${var.tfc_workspace_name}:run_phase:apply"
}