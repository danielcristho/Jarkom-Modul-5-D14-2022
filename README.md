# Jarkom-Modul-5-D14-2022

Lapres Praktikum Jarkom Modul 5 Kelompok D-14

| Nama                      | NRP      |
|---------------------------|----------|
|Gloriyano C. Daniel Pepuho |5025201121|

## Cara Pengerjaan

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

* BlackBell

```bash
auto eth0
iface eth0 inet static
        address 192.192.5.254
        netmask 255.255.254.0
        gateway 192.192.4.1
```

* Brian

```bash
auto eth0
iface eth0 inet static
        address 192.192.6.254
        netmask 255.255.255.0
        gateway 192.192.6.1
```

* Desmond

```bash
auto eth0
iface eth0 inet static
        address 192.192.3.254
        netmask 255.255.252.0
        gateway 192.192.0.1
```

* Forger

```bash
auto eth0
iface eth0 inet static
        address 192.192.7.126
        netmask 255.255.255.128
        gateway 192.192.7.1
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


