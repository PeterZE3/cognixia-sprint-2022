# WORDPRESS resource group
resource "azurerm_resource_group" "wordpress-rg" {
  # name = "${local.resource_name_prefix}-${var.resource_group_name}"
  name = "${var.rg1}"
  location = var.rglocation
  tags = {
    "image" = "wordpress"
    }
}