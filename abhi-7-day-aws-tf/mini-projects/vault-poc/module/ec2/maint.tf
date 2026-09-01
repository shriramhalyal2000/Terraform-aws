resource "aws_instance" "vault"{
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    associate_public_ip_address = true
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.vault_sg.id]
    iam_instance_profile = aws_iam_instance_profile.vault_profile.name
    ebs_block_device {
      device_name = var.ebs_name
      volume_size = var.ebs_vol
      volume_type = var.ebs_type
      delete_on_termination = true
      encrypted = var.ebs_encryption
    }
    tags={
        Name = local.instance_name
        Environment = local.Environment
    }
}
# just iam role without policy
resource "aws_iam_role" "tf_role"{
    name = "tf-vault-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {Service = "ec2.amazonaws.com"}
        }
        ]
    })
}
# creating iam policy for the role
resource "aws_iam_role_policy" "tf_role_policy"{
    name = "tf-vault-policy"
    role = aws_iam_role.tf_role.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:DescribeKey",
                "ec2:DescribeInstances",
                "iam:GetInstanceProfile",
                "iam:GetRole",
                "sts:GetCallerIdentity"
                ]
                Effect = "Allow"
                Sid = "tf-server-vault-policy"
                Resource = "*"
            }
        ]
    })
}
# attach iam role profile to instance not polocies directly
resource "aws_iam_instance_profile" "vault_profile"{
    name = "tf-vault-vm-profile"
    role = aws_iam_role.tf_role.name
}
# adding ssm login method to policy to role.
resource "aws_iam_role_policy_attachment" "ssm_attach" {
    role = aws_iam_role.tf_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
# defining egress and ingress ecurity group rule for this instance
resource "aws_security_group" "vault_sg"{
    name = "${local.instance_name}-sg"
    description = "allow ingress traffic from http and ssh port"
    vpc_id = data.aws_vpc.main.id

    dynamic "ingress" {
      for_each = var.ingress
      content {
        description = ingress.value.description
        from_port = ingress.value.from_port
        to_port = ingress.value.to_port
        cidr_blocks = ingress.value.cidr_blocks
        protocol = ingress.value.protocol
      }
    }
    dynamic "egress" {
      for_each = var.egress
      content{
        description = egress.value.description
        from_port = egress.value.from_port
        to_port = egress.value.to_port
        cidr_blocks = egress.value.cidr_blocks
        protocol = egress.value.protocol
      }
    }
    tags={
        Name = "${local.instance_name}-sg"
    }
}