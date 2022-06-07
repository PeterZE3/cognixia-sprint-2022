# Create Null Resource and Provisioners
resource "null_resource" "name" {
  depends_on = [azurerm_linux_virtual_machine.bastion_host_vm]

  connection {
    type        = "ssh"
    host        = azurerm_linux_virtual_machine.bastion_host_vm.public_ip_address
    user        = azurerm_linux_virtual_machine.bastion_host_vm.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }

  provisioner "file" {
    source      = "ssh-keys/terraform-azure.pem"
    destination = "/tmp/terraform-key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform-key.pem"
    ]
  }
}