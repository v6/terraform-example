
output "lb_ip_address" {
  value = ["${azurerm_public_ip.lb.*.ip_address}"]
}

output "lb_id" {
  value = ["${azurerm_lb.lb.*.id}"]
}

output "lb_backendpool_id" {
  value = ["${azurerm_lb_backend_address_pool.backend_pool.*.id}"]
}
