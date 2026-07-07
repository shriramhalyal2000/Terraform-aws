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
    filter{
        name = "tag:Name"
        values = ["subnet1"]
    }
}
data "aws_subnet" "subnet2"{
    filter {
      name = "tag:Name"
      values = ["subnet2"]
    }
}