#anyevent-ping-tcp
```
[root@YFTEST1 ping]# ./pingsyn.pl 5 192.168.6.26 2003
192.168.6.26
.......192.168.6.26 is open port 2003, 0.580072402954102
192.168.6.26
.......192.168.6.26 is open port 2003, 0.349998474121094
192.168.6.26
.......192.168.6.26 is open port 2003, 0.446081161499023
192.168.6.26
.......192.168.6.26 is open port 2003, 0.339031219482422
192.168.6.26
.......192.168.6.26 is open port 2003, 0.341892242431641
loss ratio : 0
latecay: 0.411415100097656 ms
```
#hping-tcp
* 安装libpcap-devel-1.4.0-4.20130826git2dbcaa1.el6.x86_64.rpm
* 做链接
```
ln -s /usr/include/pcap-bpf.h /usr/include/net/bpf.h
```
* 安装tcl-8.5.7-6.el6.x86_64.rpm、tcl-devel-8.5.7-6.el6.x86_64.rpm 
* 安装
```
[slview@huatai hping3-20051105]$ ./configure 
[slview@huatai hping3-20051105]$ make
[slview@huatai hping3-20051105]$ make install
```
* 测试hping-tcp和ping延时数据差不多
```
//ping
[root@huatai hping3-20051105]# ping -c 2 -i 2 192.168.6.150
PING 192.168.6.150 (192.168.6.150) 56(84) bytes of data.
64 bytes from 192.168.6.150: icmp_seq=1 ttl=59 time=31.8 ms
64 bytes from 192.168.6.150: icmp_seq=2 ttl=59 time=30.7 ms
--- 192.168.6.150 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 2033ms
rtt min/avg/max/mdev = 30.704/31.264/31.824/0.560 ms

//hping
[root@huatai hping3-20051105]# hping -c 2 -i 2 192.168.6.150
HPING 192.168.6.150 (eth0 192.168.6.150): NO FLAGS are set, 40 headers + 0 data bytes
len=46 ip=192.168.6.150 ttl=59 DF id=0 sport=0 flags=RA seq=0 win=0 rtt=31.0 ms
len=46 ip=192.168.6.150 ttl=59 DF id=0 sport=0 flags=RA seq=1 win=0 rtt=31.5 ms
--- 192.168.6.150 hping statistic ---
2 packets tramitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 31.0/31.2/31.5 ms
```
* 测试tcp-ping， 192.168.6.26开启了apache的2003端口，2004端口是关闭的
```
//flags= SA 回复了syn
[root@huatai hping3-20051105]# hping -c 3 -i 2 -p 2003 -S 192.168.6.26
HPING 192.168.6.26 (eth0 192.168.6.26): S set, 40 headers + 0 data bytes
len=46 ip=192.168.6.26 ttl=59 DF id=0 sport=2003 flags=SA seq=0 win=14600 rtt=31.0 ms
len=46 ip=192.168.6.26 ttl=59 DF id=0 sport=2003 flags=SA seq=1 win=14600 rtt=31.5 ms
len=46 ip=192.168.6.26 ttl=59 DF id=0 sport=2003 flags=SA seq=2 win=14600 rtt=30.6 ms
--- 192.168.6.26 hping statistic ---
3 packets tramitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 30.6/31.1/31.5 ms

//flags= RA 连接RST，端口不通
[root@huatai hping3-20051105]# hping -c 3 -i 2 -p 2004 -S 192.168.6.26
HPING 192.168.6.26 (eth0 192.168.6.26): S set, 40 headers + 0 data bytes
len=46 ip=192.168.6.26 ttl=59 DF id=0 sport=2004 flags=RA seq=0 win=0 rtt=31.2 ms
len=46 ip=192.168.6.26 ttl=59 DF id=0 sport=2004 flags=RA seq=1 win=0 rtt=30.8 ms
len=46 ip=192.168.6.26 ttl=59 DF id=0 sport=2004 flags=RA seq=2 win=0 rtt=31.0 ms
--- 192.168.6.26 hping statistic ---
3 packets tramitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 30.8/31.0/31.2 ms
```

fork antirez@invece.org

have fun,
antirez
