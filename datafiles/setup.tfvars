subscription_id           = "88888888-1111-2222-2222-111111111111"
client_id                 = "88888888-2222-2222-2222-111111111111"
client_secret             = "88888888-3333-2222-2222-111111111111"
tenant_id                 = "88888888-4444-2222-2222-111111111111"

storage_access_key        = "111111111111111111111111111111111111111111111111111111111111111111111"
storage_account_name      = "storageacct"
container_name            = "terraform-state"
backend                   = "azurerm"

## Log Analytics
sku                       = "PerGB2018"
retention_in_days         = 30

environment               = "setup"
ressourcegroupname        = "exampleresourcegroup"
region                    = "Canada Central"
os_user                   = "azureuser"

ssh_private_key_location  = "../../datafiles/id_rsa"
ssh_public_key_location   = "../../datafiles/id_rsa.pub"

chef_project              = "project-example"

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

backupvault {
  timezone                          = "Eastern Standard Time" # https://docs.microsoft.com/en-us/previous-versions/windows/embedded/gg154758(v=winembedded.80)
  dailyretention                    = 7 # in days
  weeklyyretention                  = 4 # in days
  monthlyretention                  = 3 # in days
  backuptime                        = "23:00" # Time of day must match the format HH:mm where HH is 00-23 and mm is 00 or 30
}

ad {
  mount_names                        = "aem"
  name_suffix                        = "ad"
  role                               = "ad"
  count                              = 1
  startindex                         = 0
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
  storage_disk_size_gb               = "20"
  storage_account_tier               = "Standard"
  storage_account_replication_type   = "LRS"
  device_names                       = "sdc"
  mount_names                        = "aem"
  name_suffix                        = "pub"
  role                               = "publish"
  count                              = 1
  size                               = "Standard_DS3_v2"
  startindex                         = 0
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
  storage_disk_size_gb               = "20"
  storage_account_tier               = "Standard"
  storage_account_replication_type   = "LRS"
  device_names                       = "sdc"
  mount_names                        = "aem"
  name_suffix                        = "auth"
  role                               = "author"
  count                              = 1
  size                               = "Standard_DS3_v2"
  startindex                         = 0
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
  storage_disk_size_gb               = "20"
  storage_account_tier               = "Standard"
  storage_account_replication_type   = "LRS"
  device_names                       = "sdc"
  mount_names                        = "aem"
  name_suffix                        = "disp"
  role                               = "dispatch"
  count                              = 2
  size                               = "Standard_DS3_v2"
  startindex                         = 0
}
