# Block xmpp for a single host by ip address

iptables -A FORWARD -p tcp --sport 80 -d $1 -j DROP
iptables -A FORWARD -p tcp --dport 80 -s $1 -j DROP
