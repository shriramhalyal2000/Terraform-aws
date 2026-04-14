variable "bucket_name"{
    type = string
    default = "ultrons3-tf-"
}

variable "region" {
    default = "us-east-1"
    type = string  
}

variable "Enviornment" {
    default = "Test"
    type = string
}

variable "instance_count"{
    description = "Number of ec2 instance to create"
    type = number
    default = 1
}

variable "monitoring"{
    default = true
    description = "monitoring enabled for resource"
    type = bool
}

variable "associate_public_ip"{
    default = true
    type = bool
    description = "where to allow public ip allocation ot resouce"
}

variable "tags" {
    type = map(string)
    default = {
        Enviornment = "Dev"
        Name = "dev"
    }
}

variable "config" {
  type = object({
    region = string,
    monitoring = bool,
    instance_count = number
  })
  default = {
    region = "us-east-1"
    monitoring = true
    instance_count = 1
  }
}

variable "server_config" {
    type = object({
        name = string
        instance_type = string
        monitoring = bool
        storage_gb = number
        backup_enabled = bool
    })
    description = "Complete server configuration object"
    default = {
        name = "web-server"
        instance_type = "t2.micro"
        monitoring = true
        storage_gb = 20
        backup_enabled = false
    }
    # KEY BENEFITS:
    # - Self-documenting structure
    # - Type safety for each attribute
    # - Access: var.server_config.name, var.server_config.monitoring
    # - All attributes must be provided (unless optional)
}

variable "allowed_cidr_blocks" {
    type = list(string)
    description = "list of allowed cidr blocks for security group"
    default = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
    # Access: var.allowed_cidr_blocks[0] = "10.0.0.0/8"
    # Can have duplicates: ["10.0.0.0/8", "10.0.0.0/8"] is valid
}

variable "allowed_instance_types" {
    type = list(string)
    description = "list of allowed ec2 instance types"
    default = ["t2.micro", "t2.small", "t3.micro"]
    # Order matters: index 0 = t2.micro, index 1 = t2.small
}

variable "network_config" {
    type = tuple([string, string, number])
    description = "Network configuration (VPC CIDR, subnet CIDR, port number)"
    default = ["10.0.0.0/16", "10.0.1.0/24", 80]
    # CRITICAL RULES:
    # - Position 0 must be string (VPC CIDR)
    # - Position 1 must be string (subnet CIDR)  
    # - Position 2 must be number (port)
    # - Cannot add/remove elements - length is fixed
    # Access: var.network_config[0], var.network_config[1], var.network_config[2]
}