variable "subscription_id" {}
variable "location" {}
variable "environment" {}

variable "tenant_id" {}

variable "tfc_hostname" {
    default = "app.terraform.io"
}
variable "tfc_azure_audience" {
  default = "api://AzureADTokenExchange"
}
variable "tfc_organization_name" {
  default = "jg-xyz"
}

variable "tfc_project_name" {
  default = "test"
}

variable "tfc_workspace_name" {}
variable "oidc_client_id" {}
variable "oidc_client_secret" {}
