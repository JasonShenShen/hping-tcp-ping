hping3 README file
antirez@invece.org

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

DESCRIPTION

	hping3 is a network tool able to send custom TCP/IP
	packets and to display target replies like ping do with
	ICMP replies. hping3 can handle fragmentation, and
	almost arbitrary packet size and content, using the
	command line interface.

	Since version 3, hping implements scripting capabilties,
	read the API.txt file under the /docs directory to know
	more about it.

	As a command line utility, hping is useful to test at
	many kind of networking devices like firewalls, routers,
	and so. It can be used as a traceroute alike program over all
	the supported protocols, firewalk usage, OS fingerprinting,
	port-scanner (see the --scan option introduced with hping3),
	TCP/IP stack auditing.

	It's also really a good didactic tool to learn TCP/IP.

	Using Tcl/Tk scripting much more can be done, because
	while the hping3 packet generation code is actually the
	hping2 put there mainly for compatibility with the command
	line interface, all the real news are about scripting.

	See the libs directory for example scripts. To run
	the example scripts type:

		hping3 exec ScriptName.htcl <arguments, if required>

	hping3 is developed and manteined by antirez@invece.org
	with the help of other hackers, and comes under GPL version
	2 of license. Development is open so you can send me
	patches/suggestions/affronts without inhibitions.

	Please check the AUTHORS file for a list of people that
	contribued with code, ideas, bug reports.

	Also vim developer, ee.lbl.gov for tcpdump and GNU in general.

DOCUMENTATION

	For the hping3 API check docs/API.txt

	You can find documentation about hping3 specific functions
	at http://wiki.hping.org

	Make sure to check the page at http://wiki.hping.org/34

DOWNLOAD

	The hping3 primary download site is the following:

		http://www.hping.org

	----------------------------------------------------------------
	How to get the hping3 source code from the anonymous CVS server
	----------------------------------------------------------------

	$ cvs -d :pserver:anonymous@cvs.hping2.sourceforge.net:/cvsroot/hping2 login   

	CVS will ask for the password, just press enter, no password is required

	than type the following to download the full source code.

	$ cvs -z8 -d :pserver:anonymous@cvs.hping2.sourceforge.net:/cvsroot/hping2 checkout hping3s

	-----------------------------------
	How to update your source code tree
	-----------------------------------

	change the current directory to /somewhere/hping2, than just type:

	$ cvs update

REQUIREMENTS

	A supported unix-like OS, gcc, root access.

	Libpcap.

	Tcl/Tk is optional but strongly suggested.

INSTALLATION

	see INSTALL file.

have fun,
antirez
