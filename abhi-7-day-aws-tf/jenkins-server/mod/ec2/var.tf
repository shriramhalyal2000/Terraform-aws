variable "instance_type"{
    description = "ec2 instance type"
    type = string
}

variable "ebs_vol_size"{
    description = "root vol size for instance in GiB"
    type = number
}
variable "ebs_vol_type"{
    description = "ebs root vol type for instance"
    type = string
}
variable "ebs_encryption"{
    description = "ebs root vol encryption"
    type = bool
}
variable "ebs_termination"{
    description = "ebs root vol delete on termination"
    type = bool
}

variable "ingress"{
    description = "Ingress security for jeniins ec2"
    type = map(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
    }))
    default = {
        "http" = {
            from_port = 80,
            to_port = 80,
            protocol = "tcp",
            cidr_blocks = ["0.0.0.0/0"]
        }
        "ssh" = {
            from_port = 22,
            to_port = 22,
            protocol = "tcp",
            cidr_blocks = ["0.0.0.0/0"]
        }
        "jenkins" = {
            from_port = 8080,
            to_port = 8080,
            protocol = "tcp",
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}