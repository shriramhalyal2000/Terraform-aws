variable "ami"{
    type = list(string)
    description = "list of ami available for aws resouce instanc eto use from the range"
    default = ["t2.micro", "t2.med", "x3.large", "t3.micro"]
}

variable "region" {
  default = {
    "us-east-1" = 0
    "us-west-1" = 1
    "ap-south-1" =2
  }
}
#variable "aws_instance_eni"{
    # type = object({
    #     ami = string ,
    #     eni_id = number ,
    #     security_group_monitoring = bool
    # })
    # default ={
    #     ami = "ubuntu"
    #     ani_id = 120565
    #     security_group_monitoring = false

    # }
#}

# variable "aws_security_group"{
#     type = tuple(string, bool, number)
#     default = ["10.0.0.0/12", "false", 80]
# }

# variable "ami_map" {
#   type = map(string)
#   default = {
#     "dev" = "c3.med"
#     "prod" = "x3.large"
#   }
# }