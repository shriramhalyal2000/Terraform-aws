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