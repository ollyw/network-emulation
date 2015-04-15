iptables -A OUTPUT -p tcp --sport 3128 -d $1 -j DROP
iptables -A OUTPUT -p tcp --sport 3129 -d $1 -j DROP
iptables -A OUTPUT -p tcp --sport 8080 -d $1 -j DROP

iptables -A INPUT -p tcp --dport 3128 -s $1 -j DROP
iptables -A INPUT -p tcp --dport 3129 -s $1 -j DROP
iptables -A INPUT -p tcp --dport 8080 -s $1 -j DROP

echo "Blocked Proxy Ports"
