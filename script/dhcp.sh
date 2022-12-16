#!/bin/bash

again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
echo "=================================================================";
echo " 1. Update machine                                               ";
echo " 2. Install DHCP-Server                                          ";
echo " 3. Install DHCP-Relay                                           ";
echo " 4. Configure Relay                                              ";
echo " 5. Configure DHCP-Server                                        ";
echo " 6. Remove DHCP-Relay                                            ";
echo " 7. Remove DHCP-Server                                           ";
echo " 0. Exit                                                         ";
echo "=================================================================";

read -p " Enter Your Choice [0 - 7] : " choice;
echo "";
case $choice in

1)  read -p "You will update and install many dependencies? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    echo "nameserver 192.168.122.1" >> /etc/resolv.conf
    apt update -y
    apt-get install net-tools -y
    apt-get install lynx dnsutils -y
    echo "Update success"
    fi
    ;;

2)  read -p "You want install DHCP-server? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    apt-get install isc-dhcp-server -y
    echo "DHCP-Sserver is ready to use"
    fi
    ;;

3)  read -p "You want install DHCP-Relay? y/n : " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    apt-get install isc-dhcp-relay -y
    echo "DHCP Relay is ready to use"
    fi
    ;;

4)  if [ -z "$(ls -A /etc/default/isc-dhcp-relay)" ]; then
    echo "DHCP is not installed before, Please install it!"
    else
    echo "Create new relay"
    service isc-dhcp-relay stop
    cat > /etc/default/isc-dhcp-relay <<- EOF
# Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS="192.192.7.142" # IP WISE

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth0 eth1 eth2 eth3"

# Additional options that are passed to the DHCP relay daemon?
#OPTIONS="" /etc/default/isc-dhcp-relay
EOF
    cat /etc/default/isc-dhcp-relay
    service isc-dhcp-relay start
    service isc-dhcp-relay restart
    echo "Enable IP forward"
    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
    cat /proc/sys/net/ipv4/ip_forward
    echo "Done..."
    fi
    ;;

5)  if [ -z "$(ls -A /etc/dhcp/dhcpd.conf)" ]; then
    echo "DHCP is not installed before, Please install it!"
    else
    echo "Create new DHCP-Server"
    service isc-dhcp-server stop
    cat > /etc/dhcp/dhcpd.conf <<- EOF
# Forger
subnet 192.192.7.0 netmask 255.255.255.128 {
    range 192.192.7.2 192.192.7.126;
    option routers 192.192.7.1;
    option broadcast-address 192.192.7.127;
    option domain-name-servers 192.192.7.141;
    default-lease-time 600;
    max-lease-time 7200;
}

subnet 192.192.7.136 netmask 255.255.255.248 {
}

# Desmond
subnet 192.192.0.0 netmask 255.255.252.0 {
    range 192.192.0.2 192.192.3.254;
    option routers 192.192.0.1;
    option broadcast-address 192.192.3.255;
    option domain-name-servers 192.192.7.141;
    default-lease-time 600;
    max-lease-time 7200;
}

#  Briar
subnet 192.192.6.0 netmask 255.255.255.0 {
    range 192.192.6.2 192.192.6.254;
    option routers 192.192.6.1;
    option broadcast-address 192.192.6.255;
    option domain-name-servers 192.192.7.141;
    default-lease-time 600;
    max-lease-time 7200;
}

#  BlackBell
subnet 192.192.4.0 netmask 255.255.254.0 {
    range 192.192.4.2 192.192.5.254;
    option routers 192.192.4.1;
    option broadcast-address 192.192.5.255;
    option domain-name-servers 192.192.7.141;
    default-lease-time 600;
    max-lease-time 7200;
}
EOF

    cat /etc/dhcp/dhcpd.conf
    echo "Replace new interface"
    cd /etc/default
    sed -i 's/INTERFACES=""/INTERFACES="eth0"/gI' isc-dhcp-server
    service isc-dhcp-server start
    service isc-dhcp-server restart
    echo "Enable IP forward"
    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
    cat /proc/sys/net/ipv4/ip_forward
    echo "Done..."
    fi
    ;;

6)  read -p "You want  to remove DHCP and all config files? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    apt-get remove --auto-remove isc-dhchp-relay -y
    echo "DHCP-Relay is already remove"
    fi
    ;;

7)  read -p "You want  to remove DHCP and all config files? y/n :" -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then 
    apt-get remove --auto-remove isc-dhchp-server -y
    echo "DHCP-Server is already remove"
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
