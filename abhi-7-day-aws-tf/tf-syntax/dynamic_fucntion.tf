resource "aws_instance" "server1"{
    ami = "ami-0521cb2d60cfbb1a6"
    subnet_id = "us-east-1a"
    key_name = "us-east-1"
    security_groups = ""

    tags={
        Name = "DevServer"
        Enviornment = "Dev"
    }
}

resource "aws_security_group" "http_ssh"{
    name = "http-ssh"
    description = "inbound http, ssh traffic"

    dynamic "ingress" {
      for_each = var.ingress

      content {
        from_port = ingress.value.from_port
        to_port = ingress.value.to_port
        protocol =  ingress.value.protocol
        cidr_blocks = ingress.value.cidr_blocks
      }
    }
    dynamic "egress"{
        for_each = var.egress

        content {
          from_port = egress.value.from_port
          to_port = egress.value.to_port
          protocol = egress.value.protocol
          cidr_blocks = egress.value.cidr_blocks
        }
    }
}

variable "ingress"{
    description = "configuring ssh and http ingress with ports and protocol, and cidr"
    type = map(objects({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks= list(string)
    }))
    default = [
        { #http ingress
            from_port = 80,
            to_port = 80,
            protocol = "tcp",
            cidr_blocks = ["0.0.0.0/0"]
        },
        { #ssh ingress
            from_port = 22,
            to_port = 22,
            cidr_blocks = ["0.0.0.0/0"],
            protocol = "tcp"
        }
    ]
}

variable "egress"{
    description = "egress value for security group"
    type = map(objects({
        from_port = number
        to_port = number
        protocol = number
        cidr_blocks = list(string)
    }))
    default =[
        {#egress
            from_port = 0
            to_port = 0
            protocol = -1
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]
}