 resource "aws_instance" "jenkins"{
    ami = data.aws_ami.ama_lnx.id
    instance_type = var.instance_type
    key_name = data.aws_key_pair.selected.key_name
    subnet_id = data.aws_subnet.selected.id
    iam_instance_profile = data.aws_iam_role.ssm_role.name
    security_groups = [aws_security_group.jenkins_sg.id]
    root_block_device {
      volume_size = var.ebs_vol_size
      volume_type = var.ebs_vol_type
      encrypted = var.ebs_encryption
      delete_on_termination = var.ebs_termination
    }
    tags = {
        Name = local.vm_name
        Enviornment = local.env
    }
}

resource "aws_security_group" "jenkins_sg"{
    name = "jenkins-sg"
    description = "Security group for jenkins server ports"
    vpc_id = data.aws_vpc.poc_vpc.id

    dynamic "ingress"{
        for_each = var.ingress
        content{
            from_port = ingress.value.from_port
            to_port = ingress.value.to_port
            protocol = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
        }
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${local.vm_name}-sg"
    }
}