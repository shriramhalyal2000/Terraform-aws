#creating a vpc with subnet
resource "aws_vpc" "default_vpc"{
    cidr_block = "10.0.0.0/16"
}

# resource "aws_ec2_instance" "vpc_instance"{
#     vpc_id = aws_vpc.default_vpc.id #the resource type and name fetchs the id for the said resource to be referenced
# }