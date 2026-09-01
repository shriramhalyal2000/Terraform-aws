variable "instance_type"{
    description = "instance type of ec2"
    type = string
}
variable "key_name"{
    description = "ec2 instance key pair name of extn *.pem"
    type = string
}
variable "ebs_vol"{
    description = "ebs vol size in GB"
    type = string
}
variable "ebs_encryption"{
    description = "enable encrytion of ebs vol"
    type = bool
}
variable "ebs_name"{
    description = "ebs vol name"
    type = string
}
variable "ebs_type"{
    description = "ebs vol type, gp3 or gp2"
    type = string
}
# using dynamic variable blocks in tf to accomadate more and iterate in loops
variable "ingress"{
    description = "ingress traffic def for tf-vault vm"
    type = map(object({
        description = string
        from_port = number
        to_port = number
        cidr_blocks = list(string)
        protocol = string
    }))
    default = {
      "vault" = {
        description = "tf vault main port", from_port = 8200, to_port = 8200, cidr_blocks = ["0.0.0.0/0"], protocol = "tcp"
      },
      "ha"={
        description = "tf vault ha port",from_port = 8201, to_port = 8201, cidr_blocks = ["0.0.0.0/0"], protocol = "tcp"
      },
      "ssh"={
        description = "ssh port for ingress",from_port = 22, to_port = 22, cidr_blocks = ["0.0.0.0/0"], protocol = "tcp"
      }
    }
}
variable "egress"{
    description = "egress traffic from tf vault instance"
    type = map(object({
        description = string
        from_port = number
        to_port = number
        cidr_blocks = list(string)
        protocol = string 
    }))
    default = {
        "outbound" = {description = "tf vault instance egress ports", from_port = 0, to_port = 0, cidr_blocks = ["0.0.0.0/0"], protocol = "-1"}
    }
}