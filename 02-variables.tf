# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}
# WORDPRESS Resource Group Name 
variable "rg1" {
  description = "Resource Group Name"
  type = string
  default = "wordpress"  
}
# MySQL Resource Group Name 
variable "rg2" {
  description = "Resource Group Name"
  type = string
  default = "mysql"  
}
# STORAGE ACCOUNT Resource Group Name 
variable "rg3" {
  description = "Resource Group Name"
  type = string
  default = "stgacct"  
}
# Resources Location
variable "rglocation" {
  description = "Region in which Azure Resources to be created"
  type = string
  default = "centralus"  
}