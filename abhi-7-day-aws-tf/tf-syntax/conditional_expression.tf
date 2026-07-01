# conditional expressions

resource "aws_instance" "webserver1"{
    ami = "ami-0521cb2d60cfbb1a6"
    key_name = "us-east-1"
    subnet_id = "us-east-1a"
    instance_type = var.Enviornment == "dev" ? "t2.micro" : "t3.icro" # if enviornment is dev t2.micro, else t3.micro ":" else condition, == mathes var default value if condition
    iam_instance_profile = "ec2-ssm-role"
}

variable "tags"{
    description = "common tags used in resource"
    type = map(string)
    default = {
        Enviornment = "terraform_env"
        Name = "Tf_instance"
        createdBy = "terraform"
    }
}

variable "instance_type"{
    description = "instance type for aws_instance"
    type = list(string)
    default = ["t2.micro", "t3.micro"]
}

variable "Enviornment" {
    type = string
    description = "Enviornment name"
    default = "dev"
}

# dynamic blocks

variable "ingress"{
    description = "ingress rule for http and ssh"
    type = list(object({
        port = number
        protocol = string
        cidr_block = list(string)
    }))
    default = [
        {from_port = 80,
        to_port = 80, 
        protocol = "tcp", 
        cidr_block = ["0.0.0.0/0"]},

        {from_port = 22,
        to_port = 22, 
        protocol = "tcp", 
        cidr_block = ["0.0.0.0/0"]}
    ]
}


resource "aws_security_group" "server-sg"{
    name = "aws_security_group_http_ssh"
    description = "allows http and ssh trafic inbound to instance form internet"

    # use dynamic now for http and ssh ingress

    dynamic "ingress"{
        for_each = var.ingress
        #iterator = rule # can use custom name herer

        content {
          from_port = ingress.value.from_port
          to_port = ingress.value.to_port
          protocol = ingress.value.protocol
          cidr_blocks = ingress.value.cidr_block
        }
    }
}