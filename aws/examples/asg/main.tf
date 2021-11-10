#############################################################
# AWS key pair
#############################################################
module "key_pair" {
  source = "../../modules/key_pair"

  enable_key_pair = true
  key_name        = "test-key"
  public_key      = file("./additional_files/prod-bastion_ukraine.pub")
}

module "lt" {
  source      = "../../modules/asg"
  name        = "my-first"
  region      = "us-west-2"
  environment = "test"

  enable_lt      = true
  lt_name        = ""
  lt_description = null
  lc_user_data   = null

}

module "asg_new" {
  source      = "../../modules/asg"
  name        = "my-first"
  region      = "us-west-2"
  environment = "test"

  #lc
  enable_lc   = "true"
  lc_image_id = "ami-08f72eed8a0d9f8e8"


  lc_instance_type        = "t2.micro"
  lc_security_groups      = ["sg-07b62c0d0ea37056d"]
  lc_iam_instance_profile = ""

  lc_key_name  = element(module.key_pair.aws_key_id, 0)
  lc_user_data = null #file("./additional_files/bootstrap.sh")

  lc_enable_monitoring = "true"
  lc_placement_tenancy = "default"

  lc_root_block_device = [
    {
      volume_size = "8"
      volume_type = "gp2"
    },
  ]

  lc_associate_public_ip_address = null

  # asg
  enable_asg                    = true
  asg_vpc_zone_identifier       = ["subnet-0e2b323b731655057", "subnet-0ffa47878036f1641", "subnet-096406cfdf907ee11"]
  asg_max_size                  = 1
  asg_min_size                  = 0
  asg_desired_capacity          = 1
  asg_wait_for_capacity_timeout = 0
  asg_tags = [
    {
      key                 = "Orchestration"
      value               = "Terraform"
      propagate_at_launch = true
    },
    {
      key                 = "Env"
      value               = "stage"
      propagate_at_launch = true
    }
  ]

}
