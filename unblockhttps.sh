# unblock https for a single host by ip address

iptables -D FORWARD -p tcp --sport 443 -d $1 -j DROP
iptables -D FORWARD -p tcp --dport 443 -s $1 -j DROP
