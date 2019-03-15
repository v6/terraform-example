subscription_id           = "88888888-1111-2222-2222-111111111111"
client_id                 = "88888888-2222-2222-2222-111111111111"
client_secret             = "88888888-3333-2222-2222-111111111111"
tenant_id                 = "88888888-4444-2222-2222-111111111111"

storage_access_key        = "111111111111111111111111111111111111111111111111111111111111111111111"
storage_account_name      = "storageacct"
container_name            = "terraform-state"
backend                   = "azurerm"

environment               = "stage"
ressourcegroupname        = "exampleresourcegroup"
region                    = "Canada Central"
os_user                   = "azureuser"
site_dnsname              = "stage.blah.com"

ssh_private_key_location  = "../../datafiles/id_rsa"
ssh_public_key_location   = "../../datafiles/id_rsa.pub"

chef_project              = "project-example"
aem_version               = "2"
tracked_url               = "/index.html"

subnet_suffix             = "1.0"
address_space             = "172.21.0.0/16"
dns_servers               = [
  "172.21.1.4",
  "1.1.1.1",
  "1.0.0.1"
]
subnet_ids                = [
  "172.21.1.0",
  "172.21.2.0",
  "172.21.3.0",
  "172.21.4.0"
]
subnet_names              = [
  "vnetmgmt",
  "vnetqa",
  "vnetstage",
  "vnetprod"
]
mgmt_subnets              = [
  "172.21.1.0/24",
  "172.21.2.0/24",
  "172.21.3.0/24",
  "172.21.4.0/24"
]

tags {
  client                  = "EXAMPLE"
  client_lc               = "example"
  costcenter              = "Fake Client"
}

storage {
  storage_managed_disk_type          = "Premium_LRS"
  storage_account_tier               = "Standard"
  storage_account_replication_type   = "LRS"
  role                               = "storage"
  count                              = 1
  startindex                         = 0
}

vault {
  storage_sku                        = "standard" # standard or premium
  role                               = "vault"
  disk_encryption_enabled            = true
}

monitor_cpu {
  metric_name                        = "Percentage CPU"
  operator                           = "GreaterThan"
  threshold                          = 75
  aggregation                        = "Average"
  period                             = "PT5M"
  enabled                            = false # true or false
}

monitor_storage {
  metric_name                        = "storage"
  operator                           = "GreaterThan"
  threshold                          = 1073741824
  aggregation                        = "Maximum"
  period                             = "PT10M"
  enabled                            = true # or false
}

# Publisher Variables
publish {
  storage_publisher                  = "OpenLogic"
  storage_offer                      = "CentOS"
  storage_sku                        = "7.5"
  storage_version                    = "latest"
  storage_name                       = "myOsDisk"
  storage_caching                    = "ReadWrite"
  storage_create_option              = "FromImage"
  storage_managed_disk_type          = "Premium_LRS"
  storage_disk_size_gb               = "100"
  storage_account_tier               = "Standard"
  storage_account_replication_type   = "LRS"
  device_names                       = "sdc"
  mount_names                        = "aem"
  name_suffix                        = "pub"
  role                               = "publish"
  count                              = 2
  size                               = "Standard_DS3_v2"
  startindex                         = 0
  backup                             = false
}

# Author Variables
author {
  storage_publisher                  = "OpenLogic"
  storage_offer                      = "CentOS"
  storage_sku                        = "7.5"
  storage_version                    = "latest"
  storage_name                       = "myOsDisk"
  storage_caching                    = "ReadWrite"
  storage_create_option              = "FromImage"
  storage_managed_disk_type          = "Premium_LRS"
  storage_disk_size_gb               = "100"
  storage_account_tier               = "Standard"
  storage_account_replication_type   = "LRS"
  device_names                       = "sdc"
  mount_names                        = "aem"
  name_suffix                        = "auth"
  role                               = "author"
  count                              = 1
  size                               = "Standard_DS3_v2"
  startindex                         = 0
  backup                             = false
}

# dispatcher Variables
dispatch {
  storage_publisher                  = "OpenLogic"
  storage_offer                      = "CentOS"
  storage_sku                        = "7.5"
  storage_version                    = "latest"
  storage_name                       = "myOsDisk"
  storage_caching                    = "ReadWrite"
  storage_create_option              = "FromImage"
  storage_managed_disk_type          = "Premium_LRS"
  storage_disk_size_gb               = "100"
  storage_account_tier               = "Standard"
  storage_account_replication_type   = "LRS"
  device_names                       = "sdc"
  mount_names                        = "aem"
  name_suffix                        = "disp"
  role                               = "dispatch"
  count                              = 2
  size                               = "Standard_DS3_v2"
  startindex                         = 0
  backup                             = false
}
