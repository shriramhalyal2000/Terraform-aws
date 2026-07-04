variable "key_name"{
    description = "instance key for ssh"
    type = string
}
variable "instance_type" {
    description = "instance type for ec2 server"
    type = string
}
variable "instance_profile"{
    description = "instance iam role profile"
    type = string
}
variable "mount_path"{
    description = "ebs mount path as root vol to instance"
    type = string
}
variable "volume_size" {
  description = "ebs root vol size attached to instance"
  type = number
}

variable "volume_type" {
    description = "ebs root vol type attached to instance"  
    type = string
}
