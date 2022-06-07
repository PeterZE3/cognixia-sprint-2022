# Config Storage account
resource "azurerm_storage_account" "storage2022sprint" {
  name                     = "storage2022sprint"
  resource_group_name      = azurerm_resource_group.wordpress-rg.name
  location                 = azurerm_resource_group.wordpress-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS" # Locally Redundant Storage(backup storage)
}

resource "azurerm_storage_container" "storagecontainer" {
  name                  = "logs"
  storage_account_name  = azurerm_storage_account.storage2022sprint.name
  container_access_type = "private"
}
/**
* Azure Queue Storage is a service for storing large numbers/messages, enables
* communication between componenets of a distibuted app. Each queue maintains a
* list of messages that can be added by a sender component and processed by a
* reciever component.
*/
resource "azurerm_storage_queue" "queue" {
  name                 = "messages"
  storage_account_name = azurerm_storage_account.storage2022sprint.name
}