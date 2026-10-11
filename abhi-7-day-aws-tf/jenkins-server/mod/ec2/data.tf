data "aws_ami" "ama_lnx" {
    most_recent = true
    owners = ["137112412989"]

    filter{
        name = "name"
        values = ["al2023-ami-2023.*-x86_64"]
    }
    filter{
        name = "virtualization-type"
        values= ["hvm"]
    }
}
data "aws_subnet" "selected"{
    filter{
        name = "tag:Name"
        values = ["poc_subnet"]
    }
}

data "aws_key_pair" "selected"{

    key_name = "us-east-1"
    include_public_key = true
    filter{
        name = "tag:Name"
        values = ["us-east-1"]
    }
}

data "aws_iam_role" "ssm_role"{
    name = "ec2-ssm-role"
}

data "aws_vpc" "poc_vpc"{
    filter{
        name = "tag:Name"
        values = ["Jenkins-vpc"]
    }
}