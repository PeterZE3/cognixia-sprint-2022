#  NSG for vnet
resource "azurerm_network_security_group" "security-group" {
  name                = "security-group"
  location            = var.rglocation
  resource_group_name = "mysql-rg"
}
#   virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "virtual-network"
  location            = var.rglocation
  resource_group_name = "mysql-rg"
  address_space       = ["10.0.0.0/16"]
# Subnet
subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }
}
  ## Locals Block for Security Rules
/*locals {
  web_inbound_ports_map = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443",
    "120" : "22"
  } 
}
## NSG Inbound Rule for WebTier Subnets
resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each = local.web_inbound_ports_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value 
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}*/