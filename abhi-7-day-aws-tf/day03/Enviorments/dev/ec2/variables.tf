variable "instance_ami" {
  description = "instance ami type with os"
  type        = string
}

variable "instance_type" {
  description = "instance type which included cpu and memeory"
  type        = string
}

variable "instance_region" {
  description = "aws region in which resource to be launched"
  type        = string
}
variable "instance_key_name" {
  description = "key name of .pem extension for secure login "
  type        = string
}

variable "aws_security_group_rule" {
  description = "security group name for the instance"
  type        = string
}

variable "cidr_blocks" {
  description = "ipv4 cidr block for the sg "
  type        = string
}

variable "to_port_ssh" {
  description = "inbound instance port number from client "
  type        = number
}

variable "from_port_ssh" {
  description = "inbound client device port number to instance port "
  type        = number
}

variable "ip_protocol" {
  description = "ip protocol to  use for sg"
  type        = string
}

variable "to_port_http" {
  description = "http port number to instance from client port"
  type        = string
}
variable "from_port_http" {
  description = "http port number from client port of instance "
  type        = string
}

variable "ebs_instance_vol_size" {
  description = "ebs vol size attached to instance"
  type        = number
}

variable "ebs_instance_vol_type" {
  description = "ebs vol tpe gp2, gp3.."
  type        = string
}

variable "ebs_attach_dir" {
  description = "dir where ebs vol attached to instance"
  type        = string
}