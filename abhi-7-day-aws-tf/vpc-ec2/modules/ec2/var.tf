# define ingress variable for sg
variable ingress{
    description = "ingress ports map for security group"
    type = map(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks= list(string)
    }))
    default ={
        "http"={
            from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"]
        }
        "ssh"={
            from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"]
        }
    }
}
variable "instance_type" {
  description = "instance type for ec2 server"
  type = string
}
variable "iam_instance_profile"{
    description = "instance forile with perms configured for ec2 server"
    type = string
}
variable "key_name"{
    description = "pem ssh key for instance"
    type = string
}
variable "device_name"{
    description = "ebs root vol device name"
    type = string
}
variable "volume_size"{
    description = "eb root vol size for instance in GiB"
    type = number
}
variable "volume_type"{
    description = "ebs root volume type attache dfor instance"
    type = string
}