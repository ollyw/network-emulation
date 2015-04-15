# Network Emulation
This repositories contain a set of scripts to provide:
* Load balancing
* Packet delay, with jitter
* Packet re-ordering
* Packet loss
* Bandwidth restrictions, which can be applied on a per-port basis to a farm of servers

The scripts use the following Linux technologies to provide this:

* [Linux Virtual Server](http://www.linuxvirtualserver.org/whatis.html)
* [Netem](http://www.linuxfoundation.org/collaborate/workgroups/networking/netem)
* [IP Tables](http://ipset.netfilter.org/iptables.man.html)

It provides VERY high performance kernel level emulation. The scripts are only examples, and haven't been tested in a while, but when they were used, they could easily saturate the network adapters with a modest CPU

To set it up, you ideally need a box with two network adapters.

These scripts come with no warranty, and may be out of date.
