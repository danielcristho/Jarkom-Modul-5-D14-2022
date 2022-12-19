# Jarkom-Modul-5-D14-2022

Lapres Praktikum Jarkom Modul 5 Kelompok D-14

| Nama                      | NRP      |
|---------------------------|----------|
|Gloriyano C. Daniel Pepuho |5025201121|

## Cara Pengerjaan

### A & B

Metode yang saya gunakan adalah **VLSM**. 
<details>

  <summary>Content</summary>

 1. [Alokasi VLSM](https://user-images.githubusercontent.com/69733783/206819274-72476fe8-e4ff-4ae4-8d1f-d184185d691d.png)
 2. [Pohon IP](https://miro.com/app/board/uXjVP8LKLTM=/?share_link_id=250109350023)
 3. [Topologi](https://user-images.githubusercontent.com/69733783/206830128-f247a5cd-36c5-4859-a25c-c8e4629efec0.png)

</details>

### Alokasi IP

Node                        | Alokasi      |  Netmask   |
|---------------------------|--------------|------------|
|A1                         |2             |/30         |
|A2                         |256           |/23         |
|A3                         |201           |/24         |
|A4                         |3             |/29         |
|A5                         |2             |/30         |
|A6                         |701           |/22         |
|A7                         |63            |/25         |
|A8                         |3             |/29         |
|Total                      |1231          |/21         |

### Konfigurasi IP

* Strix

```bash
auto eth0
iface eth0 inet static
        addresss 192.168.122.222
        netmask 255.255.255.0
        gateway 192.168.122.1


auto eth1
iface eth1 inet static
        address 192.192.7.145
        netmask 255.255.255.252

auto eth2
iface eth2 inet static
        address 192.192.7.149
        netmask 255.255.255.252
```

* Ostanie

```bash
auto eth0
iface eth0 inet static
        address 192.192.7.146
        netmask 255.255.255.252
        gateway 192.192.7.145
        up echo nameserver 192.168.122.1 > /etc/resolv.conf

auto eth1
iface eth1 inet static
        address 192.192.4.1
        netmask 255.255.254.0

auto eth2
iface eth2 inet static
        address 192.192.6.1
        netmask 255.255.255.0
auto eth3
iface eth3 inet static
        address 192.192.7.129
        netmask 255.255.255.248

```

* Westalis

```bash
auto eth0
iface eth0 inet static
        address 192.192.7.150
        netmask 255.255.255.252
        gateway 192.192.7.149
        up echo nameserver 192.168.122.1 > /etc/resolv.conf

auto eth1
iface eth1 inet static
        address 192.192.7.137
        netmask 255.255.255.248

auto eth2
iface eth2 inet static
        address 192.192.0.1
        netmask 255.255.252.0

auto eth3
iface eth3 inet static
        address 192.192.7.1
        netmask 255.255.255.128
```

* Garden

```bash
auto eth0
iface eth0 inet static
        address 192.192.7.130
        netmask 255.255.255.248
        gateway 192.192.7.129
```

* SSS

```bash
auto eth0
iface eth0 inet static
        address 192.192.7.134
        netmask 255.255.255.248
        gateway 192.192.7.129
```

* Eden

```bash
auto eth0
iface eth0 inet static
        address 192.192.7.141
        netmask 255.255.255.248
        gateway 192.192.7.137
```

* Wise

```bash
auto eth0
iface eth0 inet static
        address 192.192.7.142
        netmask 255.255.255.248
        gateway 192.192.7.137
```

### C

### Routing (Static)

* Strix

```bash
route add -net 192.192.4.0 netmask 255.255.254.0 gw 192.192.7.146
route add -net 192.192.7.128 netmask 255.255.255.248 gw 192.192.7.146
route add -net 192.192.0.0 netmask 255.255.252.0 gw 192.192.7.150
route add -net 192.192.7.0 netmask 255.255.255.128 gw 192.192.7.150
route add -net 192.192.7.136 netmask 255.255.255.248 gw 192.192.7.150
route add -net 192.192.6.0 netmask 255.255.255.0 gw 192.192.7.146
```

### D

### DNS

* Eden

* etc/bind/named.conf.options

```bash
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
```

### Web Server

* Garden&SSS

```bash
apt install apache2 -y
```

### DHCP

* WISE (Server)

* /etc/dhcp/dhcpd.conf

```bash
# Forger
subnet 192.192.7.0 netmask 255.255.255.128 {
    range 192.192.7.2 192.192.7.126;
    option routers 192.192.7.1;
    option broadcast-address 192.192.7.127;
    option domain-name-servers 192.192.7.141;
}

subnet 192.192.7.136 netmask 255.255.255.248 {
}

# Desmond
subnet 192.192.0.0 netmask 255.255.252.0 {
    range 192.192.0.2 192.192.3.254;
    option routers 192.192.0.1;
    option broadcast-address 192.192.3.255;
    option domain-name-servers 192.192.7.141;
}

#  BlackBell
subnet 192.192.4.0 netmask 255.255.254.0 {
    range 192.192.4.2 192.192.5.254;
    option routers 192.192.4.1;
    option broadcast-address 192.192.5.255;
    option domain-name-servers 192.192.7.141;
}

#  Briar
subnet 192.192.6.0 netmask 255.255.255.0 {
    range 192.192.6.2 192.192.6.254;
    option routers 192.192.6.1;
    option broadcast-address 192.192.6.255;
    option domain-name-servers 192.192.7.141;
}
```

* /etc/default

```bash
INTERFACESv4="eth0"
```

* Ostania&Westalis

* /etc/default

```bash
# What servers should the DHCP relay forward requests to?
SERVERS="192.192.7.142"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth0 eth1 eth2 eth3"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""
```

* Client

* /etc/network/interfaces

```bash
auto eth0
iface eth0 inet dhcp
```

### Nomor 1

Agar topologi yang kalian buat dapat mengakses keluar, kalian diminta untuk mengkonfigurasi Strix menggunakan iptables, tetapi Loid tidak ingin menggunakan MASQUERADE.


* Strix
Pertama cek ip pada interface yang menuju ke internet, selanjutnya disini kita tidak menggunakan 'MASQUERADE' tapi 'SNAT' dengan source '192.168.122.222' (ip eth0 yang ke internet)

```bash
iptables -t nat -A POSTROUTING -s 192.169.0.0/21 -o eth0 -j SNAT --to-source 192.168.122.222
```

### Nomor 2

Kalian diminta untuk melakukan drop semua TCP dan UDP dari luar Topologi kalian pada server yang merupakan DHCP Server demi menjaga keamanan.

* Strix

```bash
iptables -A FORWARD -p tcp -d 192.192.7.142 -i eth0 -j DROP
iptables -A FORWARD -p udp -d 192.192.7.142 -i eth0 -j DROP

```


