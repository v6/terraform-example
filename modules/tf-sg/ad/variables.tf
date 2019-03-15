variable "serverinfo" {
  default = {
    role                        = "ad"
  }
}
variable "tags" {
  type = "map"
}
variable "mgmt_subnets" {
  type = "list"
}
variable "region" {}
variable "SG_Name" {}
variable "environment" {}

variable "author" {
  default = {
    role  = "auth"
  }
}
variable "resource_group_name" {}
