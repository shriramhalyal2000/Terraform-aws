resource "aws_instance" "my_server"{
    ami = var.ami_id
    count = var.instance_count
    instance_type = var.instance_type
    key_name = var.key_name
    tags ={
        Name=var.instance_name
        Enviornment=var.instance_env
    }
}

resource "aws_security_group" "web_sg"{
    name = "${var.aws_security_group_name}-sg"
    description = "security group to manage traffic"

    tags={
        Name = "${var.instance_name}-sg"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http"{
    security_group_id = aws_security_group.web_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh"{
    security_group_id = aws_security_group.web_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22
}