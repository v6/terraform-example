variable "os_user" {}
variable "ssh_public_key" {}
variable "hostname" {}
variable "azurename_prefix" {}
variable "subnet_id" {}
variable "subnet_ids" {
  default = {}
}
variable "region" {}
variable "tags" {
  default = {}
}
variable "serverinfo" {
  default = {}
}
variable "serverscount" {}
variable "environment" {}
variable "resource_group_name" {}
variable "network_resource_group_name" {}
variable "network_security_group_name" {}
variable "network_security_group_id" {}
