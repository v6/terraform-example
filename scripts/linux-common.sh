#!/bin/bash -x

#########################################################################
## Starting Common Script
#########################################################################

touch /tmp/testing.log

missingmount="true"
drives="${device_name}"
drivenames="${mount_name}"
count=0
IFS=',' read -r -a array <<< "$drivenames"
echo $a
for i in $(echo $drives | sed "s/,/ /g"); do
    missingmount="true"
    echo y | mkfs.ext4 /dev/$i
    chattr -i /etc/fstab
    echo "/dev/$i /home/$drivenames ext4 defaults 1 1" >> /etc/fstab
    chattr +i /etc/fstab
    mkdir /home/$drivenames
    mount /home/$drivenames
    while [ "$missingdrive" != "false" ]
    do
        info=$(echo "$a" | lsblk |grep $drivenames)
        echo "missing $drivenames drive"
        sleep 2
        if [[ $info == *"$drivenames"* ]]
        then
            missingdrive="false";
            echo "drive avaiable"
        fi
    done
    count=$count+1
done
setsebool httpd_can_network_connect 1

#########################################################################
## Finished Common Script
#########################################################################
