resource "aws_instance" "my_tf_server"{
    ami = locals.ami_id

    tags = {
        Nmae = local.instance_name
        Enviornment = local.instance_enviornment
    }   
}

resource "aws_vpc_security_group_ingress_rule" "allow_http"{
    
}