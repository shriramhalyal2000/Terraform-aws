data "aws_availability_zones" "vpc1sbn1"{
    state = "available"
    provider = aws.primary
}
data "aws_availability_zones" "vpc2sbn2"{
    state = "available"
    provider = aws.secondary
}
# fetch data of vpc1 region
data "aws_region" "primary"{
    provider = aws.primary
}
# fetch data of vpc2 region
data "aws_region" "secondary"{
    provider = aws.secondary
}