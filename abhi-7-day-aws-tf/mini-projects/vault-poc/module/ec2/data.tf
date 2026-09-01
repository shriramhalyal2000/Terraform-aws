data "aws_ami" "ubuntu"{
    most_recent = true
    owners = ["099720109477"]


    filter{
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
    filter{
        name = "virtualization-type"
        values = ["hvm"]
    }

}
data "aws_availability_zones" "available"{
    state= "available"
}
data "aws_subnet" "available"{
    vpc_id = data.aws_vpc.main.id
    availability_zone = "us-east-1a"
}
data "aws_vpc" "main"{
    default = true
}