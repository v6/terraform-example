
output "backup_vault_id" {
  value = ["${azurerm_recovery_services_vault.backup.id}"]
}

output "backup_vault_name" {
  value = "${azurerm_recovery_services_vault.backup.name}"
}
