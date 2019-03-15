variable "serverinfo" {
  default = {
    role                        = "pub"
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

variable "publish" {
  default = {
    role                        = "pub"
  }
}
variable "resource_group_name" {}
