#!/bin/bash

again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
echo "=================================================================";
echo " 1. Update machine                                               ";
echo " 2. Install dependencies                                         ";
echo " 3. Install Bind9                                                ";
echo " 4. Config DNS Server                                            ";
echo " 5. Set resolv.conf                                              ";
echo " 0. Exit                                                         ";
echo "=================================================================";

read -p " Enter Your Choice [0 - 5] : " choice;
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

3)  read -p "You want install Bind9? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    apt install bind9  -y    
    echo "Bind9 is ready to use"
    fi
    ;;

4)  if [ -z "$(ls -A /etc/bind/named.conf.options)" ]; then
    echo "File not found"
    else
    echo "Configure..."
    # sudo su
    cat > /etc/bind/named.conf.options <<- EOF
options {
        directory "/var/cache/bind";
        forwarders {
            192.168.122.1; // IP NAT
        };
        // dnssec-validation auto;
        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
EOF
    cat /etc/bind/named.conf.options
    service bind9 restart
    echo "Done..."
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