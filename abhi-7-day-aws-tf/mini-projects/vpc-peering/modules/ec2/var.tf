variable "instance_key"{
  description = "instance security key for ssh"
  type = string
}
variable "iam_instance_role"{
  description = "aws iam role attached to instance"
  type = string
}
variable "volume_size" {
  description = "volume size of ebs attched to instance"
  type = number
}
variable "volume_type"{
  description = "ebs volume type to be attached to instance"
  type = string
}
variable "device_name"{
  description = "device attached to instance path tpaccess at root"
  type = string
}
variable "instance_type"{
  description = "instance type of ec2 to be launched"
  type = string
}
variable "instance_key2"{
    description = "instance 2 *.pem key for ssh"
    type = string
}
variable "ingress1"{
  description = "security group to allow traffic from vpc1 cidr, ssh, http and imcp from vpc2 cidr"
  type = map(object({
    from_port = number
    to_port = number 
    protocol = string
    cidr_block = list(string)
  }))
}

variable "ingress2"{
  description = "security group to allow traffic from vpc1 cidr, ssh, http,and imcp ping from vpc1 cidr"
  type = map(object({
    from_port = number
    to_port = number 
    protocol = string
    cidr_block = list(string)
  }))
}