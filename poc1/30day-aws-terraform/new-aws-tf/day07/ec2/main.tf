resource "aws_instance" "myweb_server"{
    count = locals.instance_count #referencing variables in side locals to mask
    ami = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
    instance_type = "t3.micro"

    tags = {
        Name = "My-web-server"
    }
}

resource "aws_key_pair" "my-instance-keyPair"{
    key_name = "webserver-key"
    public_key = ""
}

variable "instance_count"{
    type = "number"
    description = "number of instances launched"
    default = 1
}

locals {
    instance_count = variable.instance_count
}
output "instance_count"{ 
    value = aws_instance.myweb_server.count
}

resource "aws_security_group" "allow_tls_"{
    name = "http&ssh"
    description = "allows ssh and http traffic to instance"

    tags={
        Name = "Http&ssh"
    }
}

variable "from_port_http"{
    default = 22
    type = number
    description = "http port number"
}

resource "aws_security_group_ingress_rule" "allow_tls_ipv4"{
    security_group_id = aws_security_group.allow_tls_.id
    from_port = {

    }
    to_port = {
        
    }
}