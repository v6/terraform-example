variable "site_dnsname" {}
variable "os_user" {}
variable "ssh_private_key_location" {}
variable "region" {}
variable "environment" {}
variable "tags" {
  default = {}
}
variable "pub_ips" {
  type = "list"
}
variable "disp_ips" {
  type = "list"
}
variable "pub_count" {}
variable "pubpriv_ips" {
  type = "list"
}
variable "disppriv_ips" {
  type = "list"
}
variable "auth_count" {}
variable "auth_ips" {
  type = "list"
}
variable "depends_list" {}
