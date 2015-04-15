iptables -A OUTPUT -t mangle -o eth2 -p tcp --sport 80 -j MARK --set-mark=1
iptables -A OUTPUT -t mangle -o eth2 -p tcp --sport 443 -j MARK --set-mark=1 
iptables -A OUTPUT -t mangle -o eth2 -p tcp --sport 3128 -j MARK --set-mark=1

