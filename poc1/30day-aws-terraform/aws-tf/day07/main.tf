
resource "aws_instance" "example"{
    count = var.instance_count
    ami = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
    instance_type = "t3.micro"

    region = var.region

    monitoring = var.monitoring
    associate_public_ip_address = var.associate_public_ip

    tags={
        Enviornment = var.Enviornment
        Name = "${var.Enviornment}-Ec2-Instance"
    }
}


resource "aws_security_group" "web_sg" {
  # String type: Name and description
  name        = "${var.server_config.name}-sg"  # Object type usage
  description = "Security group for web server"
  
  # HTTP access using tuple type (port number from network_config[2])
  ingress {
    from_port   = var.network_config[2]  # Tuple type: third element (number)
    to_port     = var.network_config[2]  # Tuple type: third element (number)
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks  # List type
  }
  
  # SSH access  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks  # List type
  }
  
  # Outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}