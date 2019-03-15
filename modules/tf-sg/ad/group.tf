# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.SG_Name}"
  location            = "${var.region}"
  resource_group_name = "${var.resource_group_name}"

  tags {
     client       = "${var.tags["client"]}"
     environment  = "${var.environment}"
     costcenter   = "${var.tags["costcenter"]}"
  }
}
