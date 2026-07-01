resource "aws_instance" "webserver" {
    ami = "ami-0521cb2d60cfbb1a6"
    count = 1
    key_name = "us-east-1"

    tags={
        Name = "Task_server"
        Enviornment = "Task"
    }  
    lifecycle {
      create_before_destroy = false
      prevent_destroy = false
      ignore_changes = [ tags, key_name ]
      replace_triggered_by = [ aws_instance ]
    }
}