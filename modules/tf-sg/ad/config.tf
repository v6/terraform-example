resource "azurerm_network_security_rule" "RDP" {
  name                        = "RDP"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

## AD Non-SSL TCP/UDP
resource "azurerm_network_security_rule" "AD389" {
  name                        = "AD389"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "389"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

resource "azurerm_network_security_rule" "ADSSL" {
  name                        = "ADSSL"
  priority                    = 1003
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "636"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

## Global catalog
resource "azurerm_network_security_rule" "GCLDAP" {
  name                        = "GCLDAP"
  priority                    = 1004
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3268"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

resource "azurerm_network_security_rule" "GCLDAPSSL" {
  name                        = "GCLDAPSSL"
  priority                    = 1005
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3269"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

## RPC TCP/UDP
resource "azurerm_network_security_rule" "RPC" {
  name                        = "RPC"
  priority                    = 1006
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "135"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

## NetBIOSName TCP/UDP
resource "azurerm_network_security_rule" "NetBIOSName" {
  name                        = "NetBIOSName"
  priority                    = 1007
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "137"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

## NetBIOSData TCP/UDP
resource "azurerm_network_security_rule" "NetBIOSData" {
  name                        = "NetBIOSData"
  priority                    = 1008
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_range      = "138"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

## NetBIOSSession TCP/UDP
resource "azurerm_network_security_rule" "NetBIOSSession" {
  name                        = "NetBIOSSession"
  priority                    = 1009
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "139"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

## MicrosoftDS TCP/UDP
resource "azurerm_network_security_rule" "MicrosoftDS" {
  name                        = "MicrosoftDS"
  priority                    = 1010
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "445"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

## Kerberos
resource "azurerm_network_security_rule" "Kerberos" {
  name                        = "Kerberos"
  priority                    = 1011
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "88"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

## DNS
resource "azurerm_network_security_rule" "DNS" {
  name                        = "DNS"
  priority                    = 1012
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

## WINS
resource "azurerm_network_security_rule" "WINSResolution" {
  name                        = "WINSResolution"
  priority                    = 1013
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "1512"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

resource "azurerm_network_security_rule" "WINSReplication" {
  name                        = "WINSReplication"
  priority                    = 1014
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "42"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

## WinRM
resource "azurerm_network_security_rule" "WinRM" {
  name                        = "WinRM"
  priority                    = 1015
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5985-5986"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

## SMTP
resource "azurerm_network_security_rule" "FTP" {
  name                        = "SMTPOutgoing"
  priority                    = 1016
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "25"
  destination_port_range      = "*"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

resource "azurerm_network_security_rule" "SNMP" {
  name                        = "SNMP"
  priority                    = 1017
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_range      = "161"
  source_address_prefixes     = "${var.mgmt_subnets}"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}
