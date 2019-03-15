output "nsg_dispatch_id" {
  value = "${azurerm_network_security_group.nsg.name}"
}
