# Block xmpp for a single host by ip address

iptables -A FORWARD -p tcp --sport 443 -d $1 -j DROP
iptables -A FORWARD -p tcp --dport 443 -s $1 -j DROP
