
resource "azurerm_metric_alertrule" "cpu" {
  count                     = "${var.serverscount}"
  name                      = "${var.azurename_prefix}-cpu"
  resource_group_name       = "${var.resource_group_name}"
  location                  = "${var.region}"

  description               = "An alert rule to watch the metric Percentage CPU"

  enabled                   = "${var.monitor_cpu["enabled"]}" # true

  resource_id               = "${var.resource_id}/Microsoft.Compute/virtualMachines/${var.hostname}${(count.index + var.serverinfo["startindex"])}" #${var.resource_id}/
  metric_name               = "${var.monitor_cpu["metric_name"]}"
  operator                  = "${var.monitor_cpu["operator"]}"
  threshold                 = "${var.monitor_cpu["threshold"]}"
  aggregation               = "${var.monitor_cpu["aggregation"]}"
  period                    = "${var.monitor_cpu["period"]}"

  tags {
    client                  = "${var.tags["client"]}"
    environment             = "${var.environment}"
    costcenter              = "${var.tags["costcenter"]}"
  }

  # email_action {
  #   send_to_service_owners = false
  #   custom_emails = [
  #     "some.user@example.com",
  #   ]
  # }

  # webhook_action {
  #   service_uri = "https://example.com/some-url"
  #     properties = {
  #       severity = "incredible"
  #       acceptance_test = "true"
  #     }
  # }
}
