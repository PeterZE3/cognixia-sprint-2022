# Input Variables
# DB Name
variable "mysql_db_name" {
  description = "Azure MySQL Database Name"
  type        = string
}

# DB Username - Enable Sensitive flag
variable "mysql_db_username" {
  description = "Azure MySQL Database Administrator Username"
  type        = string

}
# DB Password - Enable Sensitive flag
variable "mysql_db_password" {
  description = "Azure MySQL Database Administrator Password"
  type        = string
  sensitive   = true
}

# DB Schema Name
variable "mysql_db_schema" {
  description = "Azure MySQL Database Schema Name"
  type        = string
}

#################################################################################
#################################################################################



# Resource-1: Azure MySQL Server
resource "azurerm_mysql_server" "mysql_server" {
  name                = "database636342" #needs to be randomized
  location            = azurerm_resource_group.wordpress-rg.location
  resource_group_name = azurerm_resource_group.wordpress-rg.name

  administrator_login          = var.mysql_db_username
  administrator_login_password = var.mysql_db_password

  #sku_name   = "B_Gen5_2" # Basic Tier - Azure Virtual Network Rules not supported

  ## ^^^^^^^  May need to use the SKu above depending on our subscription ^^^^^^^^ ##

  sku_name   = "GP_Gen5_2" # General Purpose Tier - Supports Azure Virtual Network Rules
  storage_mb = 5120
  version    = "8.0"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  # public_network_access_enabled     = false ####was true
  ssl_enforcement_enabled           = false
  ssl_minimal_tls_version_enforced  = "TLSEnforcementDisabled"
}

# Resource-2: Azure MySQL Database / Schema
resource "azurerm_mysql_database" "wordpressdb" {
  name                = var.mysql_db_schema
  resource_group_name = azurerm_resource_group.wordpress-rg.name
  server_name         = azurerm_mysql_server.mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# Resource-3-1: Azure MySQL Firewall Rule - Allow access from Bastion Host Public IP
resource "azurerm_mysql_firewall_rule" "mysql_fw_rule" {
  name                = "allow-access-from-bastionhost-publicip"
  resource_group_name = azurerm_resource_group.wordpress-rg.name
  server_name         = azurerm_mysql_server.mysql_server.name
  start_ip_address    = azurerm_public_ip.bastion_host_publicip.ip_address
  end_ip_address      = azurerm_public_ip.bastion_host_publicip.ip_address
}

# Resource-3-2: Azure MySQL Firewall Rule - Allow access from WordPress IP
# This would either be access from the wordpress vm or the loadbalancer
# resource "azurerm_mysql_firewall_rule" "mysql_fw_rule" { ##!!!!!!!!! NEED WORDPRESS IP!!!!!!!!
#   name                = "allow-access-from-wordpressvm-publicip"
#   resource_group_name = azurerm_resource_group.wordpress-rg.name
#   server_name         = azurerm_mysql_server.mysql_server.name
#   start_ip_address    = azurerm_network_interface.web_linuxvm_nic.ip_address ##!!!!!!!!! NEED WORDPRESS IP!!!!!!!!
#   end_ip_address      = azurerm_network_interface.web_linuxvm_nic.ip_address ##!!!!!!!!! NEED WORDPRESS IP!!!!!!!!
# }

# Resource-4: Azure MySQL Virtual Network Rule ##This will allow for the server to accept communications from other subnets
resource "azurerm_mysql_virtual_network_rule" "mysql_virtual_network_rule" { 
  name                = "mysql-vnet-rule"
  resource_group_name = azurerm_resource_group.wordpress-rg.name 
  server_name         = azurerm_mysql_server.mysql_server.name 
  subnet_id           = azurerm_subnet.websubnet.id 
}

#################################################################################
#################################################################################

# Output Values
output "mysql_server_fqdn" {
  description = "MySQL Server FQDN"
  value = azurerm_mysql_server.mysql_server.fqdn
}

#################################################################################
#################################################################################