//
output "config_status" {
  value      = "config_status"
  depends_on = ["null_resource.instancecount_server_instances.*.id"]
}
