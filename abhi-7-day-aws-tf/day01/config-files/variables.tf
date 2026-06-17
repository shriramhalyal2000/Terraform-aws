variable "ami" {
  description = "ami id of the in stanc eto be provisioned"
  type        = string
}

variable "instance_type" {
  description = "instance type of the ec2"
  type        = string
}

variable "aws_security_group" {
  description = "security group name for instance ingress of http and ssh kind"
  type        = string
}

variable "key_name" {
  description = ".pem key for aws cli access"
  type        = string
}

variable "availability_zone"{
    description = "availability zone of the ebs vol"
    type = string
}

variable "device_name"{
    description = "file path to be attached to the instance"
    type = string
}

variable "size"{
    description = "size of the ebs vol"
    type = number
}

variable "type"{
    description = "type of ebs vol gp3 or gp2"
    type = string
}