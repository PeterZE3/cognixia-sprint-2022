//creates teh load balancer resource on Azure
resource "azurerm_public_ip" "ipAddr" {
  name                = "ip_address"
  location            = azurerm_resource_group.wordpress-rg.location
  resource_group_name = azurerm_resource_group.wordpress-rg.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "load_balancer" {
  name                = "AzureLoadBalancer"
  location            = azurerm_resource_group.wordpress-rg.location
  resource_group_name = azurerm_resource_group.wordpress-rg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.ipAddr.id
  }
}

//back end address pool
resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = "BackEndAddressPool"
}

# resource "azurerm_lb_backend_address_pool_address" "backend_address_pool_address" {
#     name = "backendPoolAddresses"
#     backend_address_pool_id = azurerm_lb.load_balancer.id
#     //need the vnet setup for the virtual_network_id
#     virtual_network_id = azurerm_virtual_network.vnet.id   
#     ip_address = "10.0.0.1"
# }

# resource "azurerm_network_interface_backend_address_pool_association" "web_nic_lb_associate" {
#   network_interface_id    = azurerm_network_interface.web_linuxvm_nic.id
#   ip_configuration_name   = azurerm_network_interface.web_linuxvm_nic.ip_configuration[0].name
#   backend_address_pool_id = azurerm_lb_backend_address_pool.backend_address_pool.id
# }