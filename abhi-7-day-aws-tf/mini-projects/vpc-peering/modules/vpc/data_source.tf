data "aws_availability_zones" "vpc1sbn1"{
    state = "available"
    provider = aws.primary
}
data "aws_availability_zones" "vpc2sbn2"{
    state = "available"
    provider = aws.secondary
}
data "aws_ami" "vpc1ami"{
    provider = aws.primary
    most_recent = true
    owners = ["099720109477"]# ubuntu canonical owners

    filter{
        name = "name"
        values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
    }
    filter{
        name = "virtualization-type"
        values = ["hvm"]
    }
    filter{
        name = "architecture-type"
        values = ["x86_64"]
    }
}
# for secondary vpc in secondary region
data "aws_ami" "vpc2ami"{
    provider = aws.secondary
    most_recent = true
    owners = ["099720109477"]# ubuntu canonical owners

    filter{
        name = "name"
        values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
    }
    filter{
        name = "virtualization-type"
        values = ["hvm"]
    }
    filter{
        name = "architecture-type"
        values = ["x86_64"]
    }
}