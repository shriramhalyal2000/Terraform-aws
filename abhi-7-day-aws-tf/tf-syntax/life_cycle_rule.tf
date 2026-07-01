resource "aws_instance" "webserver" {
    ami = ""
    count = 1
    key_name = "us-east-1"

    tags={
        Name = "Task_server"
        Enviornment = "Task"
    }  
    lifecycle {
      create_before_destroy = 
      prevent_destroy = 
      ignore_changes = [ tags, key_name ]
      replace_triggered_by = [ aws_instance ]
    }
}