module "vpc" {
  source       = "../modules/vpc"
  vpc1_cidr    = "10.1.0.0/16"
  subnet1_cidr = "10.1.1.0/24"
  vpc2_cidr    = "10.2.0.0/16"
  subnet2_cidr = "10.2.1.0/24"
  providers = {
    aws.primary = aws.primary
    aws.secondary= aws.secondary
  }
  instance_tenancy_vpc1 = "default"
  instance_tenancy_vpc2 = "default"
}
module "ec2"{
  source = "../modules/ec2"
  instance_key = "vpc-peeding-demo"
  instance_key2 = "vpc-peeding-demo-west"
  instance_type = "t3.micro"
  volume_size = 8
  volume_type = "gp3"
  device_name = "/dev/sdb"
  iam_instance_role = "ec2-ssm-role"
    providers = {
    aws.primary = aws.primary
    aws.secondary= aws.secondary
  }
  ingress2 = {
    ssh = {from_port = 22, to_port =22, cidr_block = ["0.0.0.0/0"], protocol = "tcp"},
    http = { from_port = 80, to_port = 80, cidr_block = ["0.0.0.0/0"], protocol = "tcp" },
    icmp = {from_port = -1, to_port = -1, cidr_block = ["10.1.0.0/16"], protocol = "icmp"},
    vpc2_traffic = { from_port = 0, to_port = 65535, cidr_block = ["10.1.0.0/16"], protocol =-1}
  }
  ingress1 = {
    ssh = {from_port = 22, to_port =22, cidr_block = ["0.0.0.0/0"], protocol = "tcp"},
    http = { from_port = 80, to_port = 80, cidr_block = ["0.0.0.0/0"], protocol = "tcp" },
    icmp = {from_port = -1, to_port = -1, cidr_block = ["10.2.0.0/16"], protocol = "icmp"},
    vpc2_traffic = { from_port = 0, to_port = 65535, cidr_block = ["10.2.0.0/16"], protocol =-1}
  }
}