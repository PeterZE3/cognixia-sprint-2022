# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "wordpress-rg" {
  # name = "${local.resource_name_prefix}-${var.resource_group_name}"
  name = "${var.resource_group_name}"
  location = var.resource_group_location
  tags = "wordpress"
}