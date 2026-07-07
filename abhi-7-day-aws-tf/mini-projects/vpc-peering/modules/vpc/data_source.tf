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
        values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }
    filter{
        name = "virtualization-type"
        values = ["hvm"]
    }
    filter{
        name = "architecture"
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
        values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }
    filter{
        name = "virtualization-type"
        values = ["hvm"]
    }
    filter{
        name = "architecture"
        values = ["x86_64"]
    }
}
# fetch data of vpc1 region
data "aws_region" "primary"{
    provider = aws.primary
}
# fetch data of vpc2 region
data "aws_region" "secondary"{
    provider = aws.secondary
}