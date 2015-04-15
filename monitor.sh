echo `cat /proc/sys/net/ipv4/netfilter/ip_conntrack_count` active connections in conntrack

echo Load balancer statistics
ipvsadm -l -c

echo Bandwidth Statistics
tc -s qdisc
