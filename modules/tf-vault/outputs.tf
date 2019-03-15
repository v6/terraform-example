output "keyvault_name" {
  value = ["${azurerm_key_vault.main.name}"]
}

output "keyvault_id" {
  value = ["${azurerm_key_vault.main.id}"]
}
