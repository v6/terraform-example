output "server_pub_ips" {
  value = "${module.publish.servers_pubip_address}"
}

output "server_subnet_id" {
  value = "${module.publish.servers_subnet_id}"
}

output "servers_network_security_group_id" {
  value = "${module.publish.servers_network_security_group_id}"
}

output "server_pubip_id" {
  value = "${module.publish.server_pubip_id}"
}

output "server_priv_ips" {
  value = "${module.publish.servers_privip_address}"
}

output "server_names" {
  value = "${module.publish.server_names}"
}
