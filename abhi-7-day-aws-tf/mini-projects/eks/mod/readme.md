# vpc architecture with eks 

- creating vpc networking architechture with private subnet networks.
- the default subnet only routes traffic from private subnets
- the public route table configured to route a public subnet cidr, which will house nat gateway.
- two distinct rt for distinct use of subnets cidr routing.