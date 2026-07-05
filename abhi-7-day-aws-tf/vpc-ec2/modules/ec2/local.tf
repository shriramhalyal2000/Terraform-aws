locals{
    # define a local to iterate a subnet over 4 server aong 2 az 
    web_server={
        "server1"={subnet_id = var.subnet1_id}
        "server2"={subnet_id = var.subnet1_id}
        "server3"={subnet_id = var.subnet2_id}
        "server4"={subnet_id = var.subnet2_id}
    }
    sg_name = "ssh-http-allow"
}