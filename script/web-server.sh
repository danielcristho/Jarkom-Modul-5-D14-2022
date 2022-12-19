#!/bin/bash

again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
echo "=================================================================";
echo " 1. Update machine                                               ";
echo " 2. Install dependencies                                         ";
echo " 3. Install Apache2                                              ";
echo " 4. Config Web Server                                            ";
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

3)  read -p "You want install Apache2? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    apt install apache2  -y    
    echo "Apache2 is ready to use"
    fi
    ;;

4)  if [ -z "$(ls -A /var/www/html)" ]; then
    echo "File not found"
    else
    echo "Configure..."
    cat > /var/www//html/index.html <<- EOF
Welcome to "$HOSTNAME"
EOF
    service apache2 restart
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