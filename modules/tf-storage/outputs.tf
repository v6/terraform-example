
output "storageacct_id" {
  value = ["${azurerm_storage_account.storageacct.id}"]
}

output "storageacct_primary_blob_endpoint" {
  value = ["${azurerm_storage_account.storageacct.primary_blob_endpoint}"]
}
