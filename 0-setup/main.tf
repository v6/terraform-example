resource "azurerm_resource_group" "main" {
  name        = "${var.tags["client"]}-RG"
  location    = "${var.region}"

  tags {
     client       = "${var.tags["client"]}"
     costcenter   = "${var.tags["costcenter"]}"
  }
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.tags["client"]}-RG"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  sku                 = "${var.sku}"
  retention_in_days   = "${var.retention_in_days}"

  tags {
     client       = "${var.tags["client"]}"
     costcenter   = "${var.tags["costcenter"]}"
  }
}

module "storage" {
  source                      = "../modules/tf-storage"
  azurename_prefix            = "${var.tags["client_lc"]}"
  region                      = "${var.region}"
  environment                 = "${var.environment}"
  resource_group_name         = "${azurerm_resource_group.main.name}"
  tags                        = "${var.tags}"
  serverinfo                  = "${var.storage}"
}

module "vault" {
  source                      = "../modules/tf-vault"
  azurename_prefix            = "${var.tags["client_lc"]}"
  region                      = "${var.region}"
  tenant_id                   = "${var.tenant_id}"
  client_id                   = "${var.client_id}"
  environment                 = "${var.environment}"
  resource_group_name         = "${azurerm_resource_group.main.name}"
  tags                        = "${var.tags}"
  serverinfo                  = "${var.vault}"
}

module "backupvault" {
  source                      = "../modules/tf-backup"
  resource_group_name         = "${azurerm_resource_group.main.name}"
  azurename_prefix            = "${var.tags["client_lc"]}"
  region                      = "${var.region}"
  tags                        = "${var.tags}"
  serverinfo                  = "${var.backupvault}"
}

module "network" {
  source                = "../modules/tf-network"
  region                = "${var.region}"
  address_space         = "${var.address_space}"
  subnet_ids            = "${var.subnet_ids}"
  subnet_names          = "${var.subnet_names}"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  dns_servers           = "${var.dns_servers}"
  tags                  = "${var.tags}"
}

module "sg_ad" {
  source                = "../modules/tf-sg/ad"
  tags                  = "${var.tags}"
  region                = "${var.region}"
  environment           = "${var.environment}"
  SG_Name               = "${var.tags["client_lc"]}-ad-nsg"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  serverinfo            = "${var.ad}"
  mgmt_subnets          = "${var.mgmt_subnets}"
}

module "sg_adfs" {
  source                = "../modules/tf-sg/adfs"
  tags                  = "${var.tags}"
  region                = "${var.region}"
  environment           = "${var.environment}"
  SG_Name               = "${var.tags["client_lc"]}-adfs-nsg"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  serverinfo            = "${var.ad}"
  mgmt_subnets          = "${var.mgmt_subnets}"
}

module "sg_publish" {
  source                = "../modules/tf-sg/publish"
  tags                  = "${var.tags}"
  region                = "${var.region}"
  environment           = "${var.environment}"
  SG_Name               = "${var.tags["client_lc"]}-${var.publish["role"]}-nsg"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  serverinfo            = "${var.publish}"
  mgmt_subnets          = "${var.mgmt_subnets}"
}

module "sg_author" {
  source                = "../modules/tf-sg/author"
  tags                  = "${var.tags}"
  region                = "${var.region}"
  environment           = "${var.environment}"
  SG_Name               = "${var.tags["client_lc"]}-${var.author["role"]}-nsg"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  serverinfo            = "${var.author}"
  mgmt_subnets          = "${var.mgmt_subnets}"
}

module "sg_dispatch" {
  source                = "../modules/tf-sg/dispatch"
  tags                  = "${var.tags}"
  region                = "${var.region}"
  environment           = "${var.environment}"
  SG_Name               = "${var.tags["client_lc"]}-${var.dispatch["role"]}-nsg"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  serverinfo            = "${var.dispatch}"
  mgmt_subnets          = "${var.mgmt_subnets}"
}
