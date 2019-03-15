resource "azurerm_storage_account" "storageacct" {
  name                        = "${var.azurename_prefix}storageacct"
  resource_group_name         = "${var.resource_group_name}"
  location                    = "${var.region}"
  account_tier                = "${var.serverinfo["storage_account_tier"]}"
  account_replication_type    = "${var.serverinfo["storage_account_replication_type"]}"

  tags {
    role         = "${var.serverinfo["role"]}"
    client       = "${var.tags["client"]}"
    environment  = "${var.environment}"
    costcenter   = "${var.tags["costcenter"]}"
  }
}
