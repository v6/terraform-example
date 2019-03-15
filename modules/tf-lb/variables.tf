variable "hostname" {}
variable "azurename_prefix" {}
variable "tracked_url" {}
variable "region" {}
variable "tags" {
  default = {}
}
variable "serverinfo" {
  default = {}
}
variable "environment" {}
variable "resource_group_name" {}
variable "network_security_group_id" {}
variable "server_names" {
  type = "list"
}
variable "serverscount" {}
variable "subnet_id" {}
variable "public_ip_address_id" {
  type = "list"
}
