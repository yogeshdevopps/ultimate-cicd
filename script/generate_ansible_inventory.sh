#!/bin/bash

echo -e "\nCreating inventory file for ansible ....\n"

cat <<EOF > ../ansible_config/inventory.ini
jenkins ansible_host=  ansible_user=ubuntu ansible_connection=ssh
k8s-master ansible_host=  ansible_user=ubuntu ansible_connection=ssh
sonar ansible_host=  ansible_user=ubuntu ansible_connection=ssh
nexus ansible_host=  ansible_user=ubuntu ansible_connection=ssh
node1 ansible_host=  ansible_user=ubuntu ansible_connection=ssh
EOF

echo -e "Populating inventory file for ansible ....\n"

jenkins_ip=`VBoxManage guestproperty get jenkins "/VirtualBox/GuestInfo/Net/1/V4/IP" | sed -e 's/Value: //g'`
k8s_ip=`VBoxManage guestproperty get k8s-master "/VirtualBox/GuestInfo/Net/1/V4/IP" | sed -e 's/Value: //g'`
nexus_ip=`VBoxManage guestproperty get nexus "/VirtualBox/GuestInfo/Net/1/V4/IP" | sed -e 's/Value: //g'`
sonar_ip=`VBoxManage guestproperty get sonar "/VirtualBox/GuestInfo/Net/1/V4/IP" | sed -e 's/Value: //g'`
node_ip=`VBoxManage guestproperty get node1 "/VirtualBox/GuestInfo/Net/1/V4/IP" | sed -e 's/Value: //g'`
sed -i "s/^jenkins.*ansible_host=.*/jenkins ansible_host=${jenkins_ip} ansible_user=ubuntu ansible_connection=ssh/" ../ansible_config/inventory.ini
sed -i "s/^k8s-master.*ansible_host=.*/k8s-master ansible_host=${k8s_ip} ansible_user=ubuntu ansible_connection=ssh/" ../ansible_config/inventory.ini
sed -i "s/^sonar.*ansible_host=.*/sonar ansible_host=${sonar_ip} ansible_user=ubuntu ansible_connection=ssh/" ../ansible_config/inventory.ini
sed -i "s/^nexus.*ansible_host=.*/nexus ansible_host=${nexus_ip} ansible_user=ubuntu ansible_connection=ssh/" ../ansible_config/inventory.ini
sed -i "s/^node1.*ansible_host=.*/node1 ansible_host=${node_ip} ansible_user=ubuntu ansible_connection=ssh/" ../ansible_config/inventory.ini
echo -e "Done!!!\n"
