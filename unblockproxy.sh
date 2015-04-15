# unblock https for a single host by ip address

iptables -D OUTPUT -p tcp --sport 3128 -d $1 -j DROP
iptables -D OUTPUT -p tcp --sport 3129 -d $1 -j DROP
iptables -D OUTPUT -p tcp --sport 8080 -d $1 -j DROP

iptables -D INPUT -p tcp --dport 3128 -s $1 -j DROP
iptables -D INPUT -p tcp --dport 3129 -s $1 -j DROP
iptables -D INPUT -p tcp --dport 8080 -s $1 -j DROP
