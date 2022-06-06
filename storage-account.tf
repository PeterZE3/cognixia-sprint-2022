# Terraform configuration
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "{ResourceGroupName}" {
  name = "{ResourceGroupName}"
  location = "centralus"
}
# Config Storage account
resource "azurerm_storage_account" "{StorageAccountName}" {
  name                     = "{StorageAccountName}"
  resource_group_name      = azurerm_resource_group.{ResourceGroup}.name
  location                 = azurerm_resource_group.{ResourceGroup}.location
  account_tier             = "Standard"
  account_replication_type = "LRS" # Locally Redundant Storage(backup storage)
}

resource "azurerm_storage_container" "{ContainerName}" {
  name                  = "{logs}"
  storage_account_name  = azurerm_storage_account.{StorageAccountName}.name
  container_access_type = "private"
}
/**
* Azure Queue Storage is a service for storing large numbers/messages, enables
* communication between componenets of a distibuted app. Each queue maintains a
* list of messages that can be added by a sender component and processed by a
* reciever component.
*/
resource "azurerm_storage_queue" "{QueueName}" {
  name                 = "{messasges}"
  storage_account_name = azurerm_storage_account.{StorageAccountName}.name
}