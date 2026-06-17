variable "ami_id"{
    type = string
    description = "amazon machine image for the instance to launch"
}

variable "instance_count" {
    description = "number of instances being launced"
    type = number
}

variable "instance_type" {
    description = "what type of instance being launched"
    type = string
}

variable "key_name" {
    description = "ssh key for aws instance thats being launched"
    type = string
}

variable "instance_name" {
    description = "Instance name"
    type = string
}

variable "instance_env"{
    description = "enviornment in which instance is being launched"
    type = string
}

variable "aws_security_group_name"{
    description = "security group name"
    type = string
}