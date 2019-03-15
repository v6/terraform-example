terraform {
  backend "azurerm" {
    key                  = "EXAMPLE/setup/terraform.tfstate"
    storage_account_name = "storageacct"
    container_name       = "terraform-state"
    access_key           = "11111111111111111111111111111111111111111111111111111111111111111111"
  }
}
