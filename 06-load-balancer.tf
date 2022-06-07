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

 resource "azurerm_lb_backend_address_pool_address" "backend_address_pool_address" {
     name = "backendPoolAddresses"
     backend_address_pool_id = azurerm_lb.load_balancer.id
     //need the vnet setup for the virtual_network_id
     virtual_network_id = azurerm_virtual_network.vnet.id   
     ip_address = "10.0.0.1"
 }

 //NAT rules for access to the load balancer
 resource "azurerm_lb_nat_rule" "nat_rules" {
   resource_group_name = azurerm_resource_group.wordpress-rg.name
   loadbalancer_id = azurerm_lb.load_balancer.id
   name = "NAT_connection_rules"
   protocol = "Tcp"
   frontend_port = 8080
   backend_port = 80
   frontend_ip_configuration_name = azurerm_lb.load_balancer.frontend_ip_configuration[0]
 }

 //outbound rules for the load balancer
 resource "azurerm_lb_outbound_rule" "outbound_rules" {
   loadbalancer_id = azurerm_lb.load_balancer.id
   name = "OutboundRule"
   protocol = "Tcp"
   backend_address_pool_id = azurerm_lb_backend_address_pool.backend_address_pool.id

   frontend_ip_configuration {
     name = azurerm_lb.load_balancer.frontend_ip_configuration[0]
   }
 }

 //load blancer rules
 resource "azurerm_lb_rule" "lb_rule" {
   loadbalancer_id = azurerm_lb.load_balancer.id
   name = "LoadBalancerRule"
   protocol = "Tcp"
   frontend_port = 80
   backend_port = 80
   frontend_ip_configuration_name = azurerm_lb.load_balancer.frontend_ip_configuration[0]
   load_distribution = "Default"
 }