# Create Public IP Address
resource "azurerm_public_ip" "bastion_host_publicip" {
  name                = "bastion-host-publicip"
  resource_group_name = azurerm_resource_group.wordpress-rg.name
  location            = azurerm_resource_group.wordpress-rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create NIC
resource "azurerm_network_interface" "bastion_host_vm_nic" {
  name                = "bastion-host-vm-nic"
  location            = azurerm_resource_group.wordpress-rg.location
  resource_group_name = azurerm_resource_group.wordpress-rg.name

  ip_configuration {
    name                          = "bastion-host-ip-1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_host_publicip.id
  }
}

# VM Bastion Host
resource "azurerm_linux_virtual_machine" "bastion_host_vm" {
  name                  = "bastion-linuxvm"
  resource_group_name   = azurerm_resource_group.wordpress-rg.name
  location              = azurerm_resource_group.wordpress-rg.location
  size                  = "Standard_DS2"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.bastion_host_vm_nic.id]
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8.1"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")
}
