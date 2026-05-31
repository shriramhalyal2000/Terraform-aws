resource "aws_vpc" "my-dev_vpc"{
    cidr_block = "10.0.0.0/16"
    
    tags ={
        Name        = local.Name
        Enviornment = local.Enviornment
    }
}