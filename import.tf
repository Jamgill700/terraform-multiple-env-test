import {
    to = azurerm_resource_group.name
    id = "/subscriptions/346d97ac-7492-4061-9e58-122ed54e373b/resourceGroups/import-test-rg"
}

resource "azurerm_resource_group" "name" {
  name = "import-test-rg"
  location = "East US 2"
}