output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = "${azurerm_virtual_network.network.id}"
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = "${azurerm_virtual_network.network.address_space}"
}

output "vnet_subnets" {
  description = "The ids of subnets created inside the newl vNet"
  value       = "${azurerm_subnet.subnet.*.id}"
}
