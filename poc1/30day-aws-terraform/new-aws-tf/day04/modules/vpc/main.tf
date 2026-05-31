resource "aws_vpc" "my-dev_vpc"{
    cidr_block = "10.0.0.0/16"
    
    tags ={
        Name        = "My_Vpc:1.0"
        Enviornment = "var.Enviorment"
    }
}