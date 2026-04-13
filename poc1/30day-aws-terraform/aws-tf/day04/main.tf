terraform{
    backend "s3" {
    bucket = "ultron-tfstate-081374579218-us-east-1-an"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true

  }
    required_providers{
        aws={
            source = "hashicorp/aws"
            version = "~> 6.0"
        }
    }
}

provider "aws"{
    region = "us-east-1"
}

#create a s3 bucket

resource "aws_s3_bucket" "tf-bucket"{
    bucket = local.bucket_name #referencing local variable which inturn referenceds custom variables inside it

    tags = {
        Name = "My Tf Bucket"
        Enviornment = "Practice"
    }
    # versioning{ # depricated practice       
        # enabled = true
    # }
}
variable "enviornment"{
    default = "dev"
    type = "string"
}

variable "bucket_prefix"{
    default = "ultron-s3-tf"
}

locals{
    bucket_name = "${var.bucket_prefix}-${var.enviornment}"
}

#create a vpc

resource "aws_vpc" "sample"{
    cidr_block = "10.0.0.0/24"

    tags = {
        Enviornment = var.enviornment
        Nmae = "${var.enviornment}-vpc"
    }
}

resource "aws_ec2_instance" "demo"{
    ami = ami-01b14b7ad41e17ba4 #amazon linux ami id fromec2 console
    instance_type = "t3.micro"
    subnet_id = aws_vpc.sample.id

    tags={
        Enviornment = var.enviornment
        Name = "${var.enviornment}-Ec2-instance" #using shell values for local variable reference
    }
}
