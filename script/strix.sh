#!/bin/bash

again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
echo "=================================================================";
echo " 1. Update machine                                               ";
echo " 2. Install dependencies                                         ";
echo " 3. Config routing(Strix)                                        ";
echo " 4. Set up iptables                                              ";
echo " 5. Set resolv.conf                                              ";
echo " 0. Exit                                                         ";
echo "=================================================================";

read -p " Enter Your Choice [0 - 11] : " choice;
echo "";
case $choice in

1)  read -p "You will update this machine? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    apt-get update -y
    echo "Update success"
    fi
    ;;

2)  read -p "You want install many dependecies? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    apt-get install nano net-tools dnsutils iputils-ping openssh-server vim iproute2 iptables git curl lynx netcat -y
    echo "Install success"
    fi
    ;;

3)  read -p "You want config routing(Strix)? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    route add -net 192.192.4.0 netmask 255.255.254.0 gw 192.192.7.146
route add -net 192.192.7.128 netmask 255.255.255.248 gw 192.192.7.146
route add -net 192.192.0.0 netmask 255.255.252.0 gw 192.192.7.150
route add -net 192.192.7.0 netmask 255.255.255.128 gw 192.192.7.150
route add -net 192.192.7.136 netmask 255.255.255.248 gw 192.192.7.150
    fi
    ;;


4)  read -p "You want set up iptables? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    iptables -t nat -A POSTROUTING -j MASQUERADE -o eth0 -s 192.192.0.0/21
    echo "iptables -t nat -A POSTROUTING -j MASQUERADE -o eth0 -s 192.192.0.0/21" >> /root/.bashrc
    fi
    ;;

5) read -p "You want resolv.conf? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    #echo "nameserver 192.168.122.1" >> /etc/resolv.conf
    echo "nameserver 192.168.122.1" >> /etc/resolv.conf
    fi
    ;;

0)  exit
    ;;
*)    echo "sorry, menu is not found"
esac
echo -n "Back again? [y/n]: ";
read again;
while [[ $again != 'Y' ]] && [[ $again != 'y' ]] && [[ $again != 'N' ]] && [[ $again != 'n' ]];
do
echo "Your input is not correct";
echo -n "back again? [y/n]: ";
read again;
done
done