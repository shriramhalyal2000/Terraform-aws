variable "instace_tags"{
    type = map(string)
    description = "name and enviornmental tags of aws instance"
    default = {
        Name = "My-Server"
        Environment = "Task-1"
    }
}