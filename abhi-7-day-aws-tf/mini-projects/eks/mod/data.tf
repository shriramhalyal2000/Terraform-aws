data "aws_availability_zones" "available"{
    state = "available"
}
# using data source is only acceptable if lookup resource already exists, if not then the tf returns error.