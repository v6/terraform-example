output "nsg_ad_id" {
  value = "${azurerm_network_security_group.nsg.name}"
}
