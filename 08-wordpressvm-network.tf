# # Create Subnet
# resource "azurerm_subnet" "subnet" {
#   name                 = "present-subnet"
#   resource_group_name  = azurerm_resource_group.wordpress-rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.3.0/24"]
# }

# # Create NSG
# resource "azurerm_network_security_group" "subnet_nsg" {
#   name                = "present-subnet-nsg"
#   location            = azurerm_resource_group.wordpress-rg.location
#   resource_group_name = azurerm_resource_group.wordpress-rg.name
# }

# # Associate NSG and Subnet
# resource "azurerm_subnet_network_security_group_association" "subnet_nsg_associate" {
#   depends_on                = [azurerm_network_security_rule.nsg_rule_inbound]
#   subnet_id                 = azurerm_subnet.subnet.id
#   network_security_group_id = azurerm_network_security_group.subnet_nsg.id
# }

# # Security Rules
# locals {
#   inbound_ports_map = {
#     "100" : "80",
#     "110" : "443",
#     "120" : "22",
#     "130" : "8080"
#   }
# }

# # NSG Inbound Rule
# resource "azurerm_network_security_rule" "nsg_rule_inbound" {
#   for_each                    = local.inbound_ports_map
#   name                        = "Rule-Port-${each.value}"
#   priority                    = each.key
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = each.value
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.wordpress-rg.name
#   network_security_group_name = azurerm_network_security_group.subnet_nsg.name
# }