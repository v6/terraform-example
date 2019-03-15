resource "azurerm_key_vault_access_policy" "spi" {
  vault_name           = "${azurerm_key_vault.main.name}"
  resource_group_name  = "${var.resource_group_name}"

  tenant_id = "${var.tenant_id}"
  object_id = "${var.client_id}"

  key_permissions = [
    "create",
    "get",
    "list",
  ]

  secret_permissions = [
    "set",
    "get",
    "delete",
    "list",
  ]

}
