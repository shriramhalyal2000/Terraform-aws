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
data "aws_subnet" "subnet1"{
    provider = aws.primary
    filter{
        name = "tag:Name"
        values = ["subnet1"]
    }
}
data "aws_subnet" "subnet2"{
    provider = aws.secondary
    filter {
      name = "tag:Name"
      values = ["subnet2"]
    }
}
data "aws_vpc" "vpc1"{
    provider = aws.primary
    filter{
        name = "tag:Name"
        values = ["vpc1"]
    }
}
data "aws_vpc" "vpc2"{
    provider = aws.secondary
    filter{
        name = "tag:Name"
        values = ["vpc2"]
    }
}