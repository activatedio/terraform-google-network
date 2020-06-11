# Network Firewall Module - Proxy

The Network Firewall module is used to configure a standard set of [firewall rules](https://cloud.google.com/vpc/docs/firewalls)
for a set of proxy only subnets for your network created using the [vpc-network](../vpc-network) module.

Firewall rules on Google Cloud Platform (GCP) are created at the network level but act on each instance; if traffic is
restricted between instances by the rule, they will be unable to communicate even if they're in the same network or
subnetwork.

The default firewall rules on GCP block inbound traffic and allow outbound traffic. Firewall rules are stateful; if a
connection is allowed between a source and a target or a target and a destination, all subsequent traffic in either
direction will be allowed as long as the connection is active.

This module adds rules for 1 [network `tag`](https://cloud.google.com/vpc/docs/add-remove-network-tags) that can be
applied to instances, similar to the division between subnetworks.

* `private` - allow inbound traffic from the proxy subnetworks

