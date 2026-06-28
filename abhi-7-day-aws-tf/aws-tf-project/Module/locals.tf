locals {
  task_name            = "tf_vpc_task"
  task_enviornment     = "tf_vpc_task_enviornment"
  igw_name             = "task_vpc_igw"
  public_sbn_name      = "task_public_subnet"
  public_sbn_rt_name   = "public_subnet_rt_task_vpc"
  public_sbn_2_rt_name = "public_sbn_2_rt_task_vpc"
  public_sbn_2_name    = "public_sbn_2_task_vpc"
  lb_name              = "task_lb"
  lb_env               = "task_vpc_env"
}