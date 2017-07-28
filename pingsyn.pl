#!/usr/local/bin/perl
=pod
/**
 * [AnyEvent ping test for single ip]
 * zhangqi 20170728 10513 tcp ping 工具实现
 * @type {[type]}
 */
=cut
use AnyEvent::Ping::TCP;
my $a_all;
my $a;
my $c = $ARGV[0] || 5;
my $ip = $ARGV[1];
my $port = $ARGV[2];
my $timeout = $ARGV[3] || 5;
if ($ip eq '' || $port eq ''){
    print "usage : pingsyn.pl 5 192.168.6.26 2003 10
                          package ip port tiemout\n";
    exit(1);
}
my $loss;
for (my $i=0;$i<$c;$i++){
    print "$ip\n";
    tcp_ping_syn $ip ,$port;
    $a = tcp_ping_ack $ip,$port;
    if ($a ne "") {
        $a_all += $a;
        print ".......$ip is open port $port, $a\n";
    }
    else{
        $loss++;
    }
    select(undef,undef,undef,$timeout)
}
$a_all = $a_all/($c - $loss);
my $lossrat = $loss/$c;
print "loss ratio : $lossrat\nlatecay: $a_all ms\n";
exit(0);