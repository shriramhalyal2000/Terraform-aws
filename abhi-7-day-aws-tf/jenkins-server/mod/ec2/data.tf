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
data "aws_subnets" "available"{
    filter{
        name = "vpc-id"
        values = [data.aws_vpc.poc_vpc.id]
    }
}

data "aws_subnet" "selected"{
    id = data.aws_subnets.available.ids[0]
}

data "aws_key_pair" "selected"{
    filter{
        name = "tag:Name"
        values = ["dev-az"]
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