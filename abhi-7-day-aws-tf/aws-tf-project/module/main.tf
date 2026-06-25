module "vpc"{
    source = "../env"
    vpc_block = "10.0.0.0/16"
    public_subnet_cidr = "10.0.1.0/24"
    public_sbn_2_cidr = "10.0.2.0/24"
    sbn1_az = "us-east-1a"
    sbn2_az = "us-east-1b"

}