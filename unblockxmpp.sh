# unblock xmpp for a single host by ip address

iptables -D FORWARD -p tcp --sport 5222 -d $1 -j DROP
iptables -D FORWARD -p tcp --dport 5222 -s $1 -j DROP
