# Create a resource group
resource "azurerm_resource_group" "multiple_env_test" {
  name     = "multiple-env-${var.environment}"
  location = var.location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "multiple_env_test" {
  name                = "multiple-env-${var.environment}-network"
  resource_group_name = azurerm_resource_group.multiple_env_test.name
  location            = azurerm_resource_group.multiple_env_test.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "multiple_env_test" {
  name                 = "${var.environment}-management-zone"
  resource_group_name  = azurerm_resource_group.multiple_env_test.name
  virtual_network_name = azurerm_virtual_network.multiple_env_test.name
  address_prefixes     = ["10.0.1.0/24"]
}