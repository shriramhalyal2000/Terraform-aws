# define a vpc
resource "aws_vpc" "task_vpc" {
  cidr_block = var.vpc_block

  tags = {
    Name        = local.task_name
    Enviornment = local.task_enviornment
  }
}
# define a public subnet with cidr blcok
resource "aws_subnet" "my_public_sbn" {
  vpc_id                  = aws_vpc.task_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.sbn1_az
  map_public_ip_on_launch = true

  tags = {
    Name = local.public_sbn_name
  }
}

# define a igw for the vpc public subnet
resource "aws_internet_gateway" "task_vpc_igw" {
  vpc_id = aws_vpc.task_vpc.id

  tags = {
    Nmae = local.igw_name
  }
}

# define a route table for public subnet
resource "aws_route_table" "public_sbn_rt" {
  vpc_id     = aws_vpc.task_vpc.id
  depends_on = [aws_internet_gateway.task_vpc_igw]

  route {
    # show public subnet cidr block where is igw through this rt
    cidr_block = "0.0.0.0/0" # show route to public internet access not subnet cidr
    gateway_id = aws_internet_gateway.task_vpc_igw.id

  }
  tags = {
    Name = local.public_sbn_rt_name
  }
}

resource "aws_route_table_association" "vpc_task_rt_assoc" {
  subnet_id      = aws_subnet.my_public_sbn.id
  route_table_id = aws_route_table.public_sbn_rt.id
}

# define another publc subnet named subnet2

resource "aws_subnet" "public_sbn_2" {
  vpc_id                  = aws_vpc.task_vpc.id
  cidr_block              = var.public_sbn_2_cidr
  availability_zone       = var.sbn2_az
  map_public_ip_on_launch = true #any instance launched in this have public ip mapped to it by default 

  tags = {
    Name = local.public_sbn_2_name
  }
}

resource "aws_route_table" "public_sbn_2_rt" {
  vpc_id = aws_vpc.task_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.task_vpc_igw.id # single gateway per vpc, so both subnet share same igw

  }

  tags = {
    Name = local.public_sbn_2_rt_name
  }
}
# every route table needs route{} and route table association 
resource "aws_route_table_association" "vpc_task_sbn_2_rt" {
  subnet_id      = aws_subnet.public_sbn_2.id
  route_table_id = aws_route_table.public_sbn_2_rt.id
}

# creating security group for the ec2 and load balalcer  

resource "aws_security_group" "sg_resource" {
  name_prefix = "allow_http_ssh"
  description = "allows ssh and http trffic into instances"
  vpc_id      = aws_vpc.task_vpc.id

  # hhtp traffic inbound rule
  ingress {
    description = "allows http traffic inbound"
    from_port   = var.http_ingress_from_port
    to_port     = var.http_ingress_to_port
    protocol    = var.protocol
    cidr_blocks = var.ingress_cidr
  }

  ingress {
    description = "allow ssh inbound traffic"
    from_port   = var.ssh_ingress_from_port
    to_port     = var.ssh_ingress_to_port
    protocol    = var.protocol
    cidr_blocks = var.ingress_cidr
  }

  # intsnace outbound rule
  egress {
    description = "allows traffic from instance to internet"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"] # allows internet access to server from sg
  }

  tags = {
    Name = "allowSSH_HTTP"
  }

}
# define a s3 bucket resource
resource "aws_s3_bucket" "task_bucket" {
  bucket = var.task_bucket_name

  tags = {
    Name        = "task_bucket"
    Enviornment = "task_vpc"
  }
}

# dfine ec2 instances
resource "aws_instance" "task_server_1" {
  ami                    = var.task_server_ami
  vpc_security_group_ids = [aws_security_group.sg_resource.id]
  key_name               = var.instance_key
  instance_type          = var.instance_type
  iam_instance_profile   = var.instance_iam_role
  subnet_id              = aws_subnet.my_public_sbn.id
  user_data_base64       = base64encode(file("../Module/userdata1.sh"))

  tags = {
    Name = "server1"
  }
}
# define ec2 instancer server
resource "aws_instance" "task_server_2" {
  ami                    = var.task_server_ami
  vpc_security_group_ids = [aws_security_group.sg_resource.id]
  key_name               = var.instance_key
  instance_type          = var.instance_type
  iam_instance_profile   = var.instance_iam_role
  subnet_id              = aws_subnet.public_sbn_2.id
  user_data_base64       = base64encode(file("../Module/userdata2.sh")) # userdata is not getting 
  #updated or instanctiated with both instances
  tags = {
    Name = "server2"
  }
}

# create an alb
resource "aws_lb" "task_alb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.sg_resource.id]
  subnets            = [aws_subnet.my_public_sbn.cidr_block, aws_subnet.public_sbn_2.cidr_block]

  tags = {
    Name        = local.lb_name
    Enviornment = local.lb_env
  }
}
# defined resource target group
resource "aws_lb_target_group" "lb_tg" {
  name     = var.lb_tg_name
  port     = var.alb_tg_port
  protocol = var.alb_tg_protocol
  vpc_id   = aws_vpc.task_vpc.id

}

# like subnet assc, target groups need to be associated 
resource "aws_lb_target_group_attachment" "attch_server1" {
  target_group_arn = aws_lb_target_group.lb_tg.arn
  target_id        = aws_instance.task_server_1.id
  port             = var.lb_target_grp_attch_port
}

# attach server 2 to target group 
resource "aws_lb_target_group_attachment" "attach_server2" {
  target_group_arn = aws_lb_target_group.lb_tg.arn
  target_id        = aws_instance.task_server_2.id
  port             = var.lb_target_grp_attch_port
}

# attach loadbalancer to listen to port , and attach target group
resource "aws_lb_listener" "listen" {
  load_balancer_arn = aws_lb.task_alb.arn
  port              = var.alb_listener_port
  protocol          = "HTTP"

  # attach target group
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}