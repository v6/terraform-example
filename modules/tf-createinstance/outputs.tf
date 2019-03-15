//

output "servers_pubip_address" {
  value = ["${azurerm_public_ip.servers.*.ip_address}"]
}

output "server_pubip_id" {
  value = ["${azurerm_public_ip.servers.*.id}"]
}

output "servers_privip_address" {
  value = ["${azurerm_network_interface.nic.*.private_ip_address}"]
}

output "servers_subnet_id" {
  value = "${azurerm_network_interface.nic.0.ip_configuration.0.subnet_id}"
}

output "servers_network_security_group_id" {
  value = "${azurerm_network_interface.nic.0.network_security_group_id}"
}

output "server_names" {
  value = ["${azurerm_virtual_machine.server.*.name}"]
}

output "server_ids" {
  value = ["${azurerm_virtual_machine.server.*.id}"]
}

output "server_avset" {
  value = ["${azurerm_availability_set.avset.*.name}"]
}

output "status" {
  value      = "status"
  depends_on = ["azurerm_virtual_machine.server.*.id"]
}
