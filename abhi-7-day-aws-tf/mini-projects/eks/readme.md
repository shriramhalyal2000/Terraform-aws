# creating a multinode eks with tf, aws provider

- create a vpc with cidr of choise.
- create 2 private subnets with same rt, but in different az.
- create a rt association resource and igw, for public subnet and public rt.

- create eks
  - configure eks architecture.