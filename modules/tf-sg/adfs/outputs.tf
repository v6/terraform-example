output "nsg_adfs_id" {
  value = "${azurerm_network_security_group.nsg.name}"
}
