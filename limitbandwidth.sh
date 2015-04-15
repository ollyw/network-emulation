#!/bin/bash

# This script uses Classful Queuing Disciples and Netem to provide bandwidth limiting, packet corruption and loss.
# See http://www.linuxfoundation.org/en/Net:Netem for details
# This script will NOT WORK unless the packets are marked by iptables, and currently that is setup by lb-enable script

source ./vars

# delete old qdiscs
tc qdisc del dev $out_if root  2> /dev/null > /dev/null
tc qdisc del dev $in_if root  2> /dev/null > /dev/null

# attach the route HTB queue (Hash Token Bucket), to allow bandwidth restriction
tc qdisc add dev $in_if root handle 1: htb default 12

# limit the total bandwidth allocation
tc class add dev $in_if parent 1: classid 1:1 htb rate 1gbit ceil 1gbit quantum 1500 

# class for default (i.e. non-filtered traffic)
tc class add dev $in_if parent 1:1 classid 1:12 htb rate 1gbit ceil 1gbit quantum 1500
# class for filtered traffic
tc class add dev $in_if parent 1:1 classid 1:11 htb rate $netem_rate ceil $netem_rate quantum 1500

# cascading queue disciplines for netem delay, etc
tc qdisc add dev $in_if parent 1:11 handle 10: netem loss $loss
tc qdisc add dev $in_if parent 10:1 handle 100: netem corrupt $corrupt 
tc qdisc add dev $in_if parent 100:1 handle 1000: netem delay $delay $delay_var $delay_percentdist
tc qdisc add dev $in_if parent 1000:1 handle 10000: pfifo limit 1000

# filter to categorise the filtered traffic into the correct class in the qdisc
tc filter add dev $in_if parent 1: protocol ip prio 1 handle 2 fw flowid 1:11

# print out the config
echo -e '\n$in_if qdisc setup:\n'
tc qdisc show dev $in_if
echo -e '\n$in_if class setup:\n'
tc class show dev $in_if
echo -e '\n$in_if filter setup:\n'
tc filter show dev $in_if

# attach the route HTB queue (Hash Token Bucket), to allow bandwidth restriction
tc qdisc add dev $out_if root handle 1: htb default 12

# limit the total bandwidth allocation
tc class add dev $out_if parent 1: classid 1:1 htb rate 1gbit ceil 1gbit quantum 1500

# class for default (i.e. non-filtered traffic)
tc class add dev $out_if parent 1:1 classid 1:12 htb rate 1gbit ceil 1gbit quantum 1500
# class for filtered traffic
tc class add dev $out_if parent 1:1 classid 1:11 htb rate $netem_rate ceil $netem_rate quantum 1500 

# cascading queue disciplines for netem delay, etc
tc qdisc add dev $out_if parent 1:11 handle 10: netem loss $loss
tc qdisc add dev $out_if parent 10:1 handle 100: netem corrupt $corrupt
tc qdisc add dev $out_if parent 100:1 handle 1000: netem delay $delay $delay_var $delay_percentdist
tc qdisc add dev $out_if parent 1000:1 handle 10000: pfifo limit 1000

# filter to categories the filtered traffic into the correct class in the qdisc
tc filter add dev $out_if parent 1: protocol ip prio 1 handle 1 fw flowid 1:11

# print out the config
echo -e '\n$out_if qdisc setup:\n'
tc qdisc show dev $out_if
echo -e '\n$out_if class setup:\n'
tc class show dev $out_if
echo -e '\n$out_if filter setup:\n'
tc filter show dev $out_if

