resource "aws_instance" "my_task_server"{
    ami = ""
    region = ""

    tags = local.aws_instance_tags #tags are mapped inside variable and local value map
}