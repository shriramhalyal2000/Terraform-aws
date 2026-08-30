# vpc architecture with eks 

- creating vpc networking architechture with private subnet networks.
- the default subnet only routes traffic from private subnets
- the public route table configured to route a public subnet cidr, which will house nat gateway.
- two distinct rt for distinct use of subnets cidr routing.

- this needs a natgateway to route private subnets which dont have internet access , 
  so their trafic is routed.
  - involves registering or provisoning an eip for nateway.
  - then associate natgtw with public subnet, and then amend routes in pvt_rt to have 
    internet traffic routed through natgtw.