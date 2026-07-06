module "vpc"{
    source = "../modules/vpc"
    vpc1_cidr = "10.1.0.0/16"
    subnet1_cidr = "10.1.1.0/24"
    vpc2_cidr = "10.2.0.0/16"
    subnet2_cidr = "10.2.1.0/24"
}