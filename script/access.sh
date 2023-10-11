#!/bin/bash
#### Store IP addresses of the  virtual machines ####
jenkins_ip=`VBoxManage guestproperty get jenkins "/VirtualBox/GuestInfo/Net/1/V4/IP" | sed -e 's/Value: //g'` 
echo "Jenkins Server Ip = $jenkins_ip"
k8s_ip=`VBoxManage guestproperty get k8s-master "/VirtualBox/GuestInfo/Net/1/V4/IP" | sed -e 's/Value: //g'`
echo "k8s Server Ip =  $k8s_ip"
nexus_ip=`VBoxManage guestproperty get nexus "/VirtualBox/GuestInfo/Net/1/V4/IP" | sed -e 's/Value: //g'`
echo "nexus Server Ip =  $nexus_ip"
sonar_ip=`VBoxManage guestproperty get sonar "/VirtualBox/GuestInfo/Net/1/V4/IP" | sed -e 's/Value: //g'`
echo "sonars Server Ip =  $sonar_ip"
node1_ip=`VBoxManage guestproperty get node1 "/VirtualBox/GuestInfo/Net/1/V4/IP" | sed -e 's/Value: //g'`
echo "node1 Server Ip =  $node1_ip"