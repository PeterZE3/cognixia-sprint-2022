# WORDPRESS resource group
resource "azurerm_resource_group" "wordpress-rg" {
  # name = "${local.resource_name_prefix}-${var.resource_group_name}"
  name = "${var.rg1}"
  location = var.rglocation
  tags = {
    "image" = "wordpress"
    }
}
# #  MySQL resource group
# resource "azurerm_resource_group" "mysql-rg" {
#   # name = "${local.resource_name_prefix}-${var.resource_group_name}"
#   name = "${var.rg2}"
#   location = var.rglocation
# }
# # Word press resource group
# resource "azurerm_resource_group" "storageacct-rg" {
#   # name = "${local.resource_name_prefix}-${var.resource_group_name}"
#   name = "${var.rg3}"
#   location = var.rglocation
# }