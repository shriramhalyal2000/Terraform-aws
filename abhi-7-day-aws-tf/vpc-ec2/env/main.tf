module "vpc"{
    source = "../modules/vpc"
    vpc_cidr = "10.0.0.0/16"
    subnet1_cidr = "10.0.1.0/24"
    subnet2_cidr = "10.0.2.0/24"
}
module "ec2"{
    source = "../modules/ec2"
    vpc_id = module.vpc.vpc_id
    subnet1_id = module.vpc.subnet1_id
    subnet2_id = module.vpc.subnet2_id
    instance_type = "t3.micro"
    iam_instance_profile = "ec2-ssm-role"
    key_name = "us-east-1"
    device_name = "/dev/xvda"
    volume_size = 8
    volume_type = "gp3"

}