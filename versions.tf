terraform{
  required_version = ">=1.5.1"
  cloud {
    organization = var.tfc_organization_name

    workspaces {
      name = var.tfc_workspace_name
    }
  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.85.0"
    }

    azuread = {
      source = "hashicorp/azuread"
      version = "2.47.0"
    }
  }
} 
