#!/bin/env bash
set -x

function create_config {
cat <<- _EOF_
#       sec.name  source          community
com2sec notConfigUser  default       a9uMLbdo

####
# Second, map the security name into a group name:
#       groupName      securityModel securityName
group   notConfigGroup v1           notConfigUser
group   notConfigGroup v2c           notConfigUser

####
# Third, create a view for us to let the group have rights to:
# Make at least  snmpwalk -v 1 localhost -c public system fast again.
#       name           incl/excl     subtree         mask(optional)
view    systemview    included   .1.3.6.1.2.1.1
view    systemview    included   .1.3.6.1.2.1.25.1.1
view    systemview    included   .1.3.6.1.4.1.2021

####
# Finally, grant the group read-only access to the systemview view.
#       group          context sec.model sec.level prefix read   write  notif
access  notConfigGroup ""      any       noauth    exact  systemview none none

mibs +UCD-SNMP-MIB

syslocation Azure Canada Central
syscontact helpdesk@fakecompany.com
_EOF_
}

yum install net-snmp net-snmp-utils -y

if [ -f "/home/vault/snmpd.conf.orig" ]
then
	echo "snmpd.conf.orig already exists, skipping..."
else
  cp /etc/snmp/snmpd.conf /home/vault/snmpd.conf.orig
  create_config > /etc/snmp/snmpd.conf
  service snmpd restart
  systemctl enable snmpd.service
fi

snmpwalk -v 2c -c a9uMLbdo -O e localhost
snmpwalk -v 2c -c a9uMLbdo -O e localhost .1.3.6.1.4.1.2021
