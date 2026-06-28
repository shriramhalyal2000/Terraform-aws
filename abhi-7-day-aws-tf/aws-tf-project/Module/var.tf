variable "vpc_block" {
  description = "vpc default cir block"
  type        = string
}

variable "public_subnet_cidr" {
  description = "public subnet operation cidr block"
  type        = string
}
variable "public_sbn_2_cidr" {
  description = "public subnet 2 cidr"
  type        = string
}
variable "sbn1_az" {
  description = "availability zone of subnet"
  type        = string
}
variable "sbn2_az" {
  description = "availability zone of sbnet2"
  type        = string
}
variable "http_ingress_from_port" {
  description = "http ingress from port of client to serverfor sg"
  type        = number
}
variable "http_ingress_to_port" {
  description = "http ingress to port of server from client port for sg"
  type        = number
}
variable "ssh_ingress_from_port" {
  description = "ssh ingress port from client port to server for sg"
  type        = number
}
variable "ssh_ingress_to_port" {
  description = "ssh  ingress to port of server from client for sg"
  type        = number
}
variable "protocol" {
  description = "ingress protocol for sg"
  type        = string
}
variable "ingress_cidr" {
  description = "from public internet cidr to access server"
  type        = list(string)
}
variable "task_bucket_name" {
  description = "bucket name for the task"
  type        = string
}
variable "task_server_ami" {
  description = "ami id for server 1"
  type        = string
}
variable "instance_key" {
  description = "instance key for server1"
  type        = string
}
variable "instance_type" {
  description = "instance type for server"
  type        = string
}
variable "instance_iam_role" {
  description = "instance iam role "
  type        = string
}
variable "lb_name" {
  description = "loadblancer name"
  type        = string
}
variable "lb_type" {
  description = "load balancer type, application or network"
  type        = string
}
variable "lb_tg_name" {
  description = "target group name for alb"
  type        = string
}
variable "alb_tg_port" {
  description = "target group listing port"
  type        = number
}
variable "alb_tg_protocol" {
  description = "target group protocol"
  type        = string
}
variable "lb_target_grp_attch_port" {
  description = "target group attachment port for lb"
  type        = number
}
variable "alb_listener_port" {
  description = "alb listener group port"
  type        = number
}