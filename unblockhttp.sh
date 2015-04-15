# unblock https for a single host by ip address

iptables -D FORWARD -p tcp --sport 80 -d $1 -j DROP
iptables -D FORWARD -p tcp --dport 80 -s $1 -j DROP
