output "nsg_publish_id" {
  value = "${azurerm_network_security_group.nsg.name}"
}
