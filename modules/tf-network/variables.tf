variable "tags" {
  type = "map"
}
variable "region" {}
variable "resource_group_name" {}
variable "address_space" {}
variable "dns_servers" {
  type = "list"
}
variable "subnet_ids" {
  type = "list"
}
variable "subnet_names" {
  type = "list"
}
