# Locals Block for custom data
locals {
webvm_custom_data = <<CUSTOM_DATA
!/bin/sh
sudo yum install wget
sudo mkdir -p /var/www/html
cd /var/www/html
sudo wget http://wordpress.org/latest.tar.gz
sudo tar xzvf latest.tar.gz
sudo rm latest.tar.gz
sudo chown -R nginx: /var/www/html/wordpress
cd wordpress
sudo mv wp-config-sample.php wp-config.php
sudo nano wp-config.php
CUSTOM_DATA
 }

# resource "azurerm_network_interface" "web_linuxvm_nic" {
#   name = "wordpress-web-linuxvm-nic"
#   location = azurerm_resource_group.wordpress-rg.location
#   resource_group_name = azurerm_resource_group.wordpress-rg.name

#   ip_configuration {
#     name = "web-linuxvm-ip-1"
#     subnet_id = azurerm_lb_backend_address_pool.backend_address_pool.id
#     private_ip_address_allocation = "Dynamic"
#     # public_ip_address_id = azurerm_public_ip.web_linuxvm_public_ip.id
#   }
# }

resource "azurerm_public_ip" "web_linuxvm_publicip" {
  name = "wordpressvm-publicip"
  resource_group_name = azurerm_resource_group.wordpress-rg.name
  location = azurerm_resource_group.wordpress-rg.location
  sku = "Standard"
  allocation_method = "Static"
  domain_name_label = "app1-vm"
}

resource "azurerm_network_interface" "web_linuxvm_nic" {
  name                = "wordpress-linuxvm-nic"
  location            = azurerm_resource_group.wordpress-rg.location
  resource_group_name = azurerm_resource_group.wordpress-rg.name

  ip_configuration {
    name                          = "web-linuxvm-ip-1"
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.websubnet.id
    public_ip_address_id = azurerm_public_ip.web_linuxvm_publicip.id 
  }
}


# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  name = "wordpress-web-linuxvm"
  # computer_name = 
  resource_group_name = azurerm_resource_group.wordpress-rg.name
  location = azurerm_resource_group.wordpress-rg.location
  size = "Standard_B1s"

  admin_username = "azureuser"
#   admin_password = "Password1234"
#   disable_password_authentication = false

  admin_ssh_key {
    username = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  network_interface_ids = [ azurerm_network_interface.web_linuxvm_nic.id ]

  

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "18.04-LTS"
    version = "latest"
  }
#   custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")
   custom_data = base64encode(local.webvm_custom_data)
}