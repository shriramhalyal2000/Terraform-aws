variable "task_region" {
  description = "vpc /task vpc deployed region"
  type        = string
}

variable "vpc_block" {
  description = "vpc default cir block"
  type        = string
}

variable "public_subnet_cidr" {
  description = "public subnet operation cidr block"
  type        = string
}
