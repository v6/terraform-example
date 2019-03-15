variable "serverinfo" {
  default = {
    role                        = "disp"
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

variable "dispatch" {
  default = {
    role                        = "disp"
  }
}
variable "resource_group_name" {}
