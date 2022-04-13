module "key_pair" {
  source = "../../modules/key_pair"

  enable_key_pair          = true
  key_pair_key_name        = "test"
  key_pair_key_name_prefix = null
  key_pair_public_key      = file("/Users/captain/.ssh/id_rsa.pub")

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "lt" {
  source      = "../../modules/asg"
  name        = "my-first"
  region      = "us-west-2"
  environment = "test"

  enable_lt      = true
  lt_name        = ""
  lt_description = null
  lt_user_data   = null
  lt_image_id    = "ami-08f72eed8a0d9f8e8"

}

module "asg" {
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

  lc_key_name  = module.key_pair.aws_key_id
  lc_user_data = null #file("./additional_files/bootstrap.sh")

  lc_enable_monitoring = "true"
  lc_placement_tenancy = "default"

  lc_root_block_device = {
    volume_size = 8
    volume_type = "gp3"
  }

  lc_ebs_block_device = [
    {
      device_name = "/dev/sdm"
      volume_size = 50
      volume_type = "gp3"

      delete_on_termination = null
      encrypted             = null
      iops                  = null
    }
  ]


  lc_associate_public_ip_address = null

  # asg
  enable_asg                    = true
  asg_vpc_zone_identifier       = ["subnet-0e2b323b731655057", "subnet-0ffa47878036f1641", "subnet-096406cfdf907ee11"]
  asg_max_size                  = 1
  asg_min_size                  = 0
  asg_desired_capacity          = 1
  asg_wait_for_capacity_timeout = 0

  enable_autoscaling_policy = true
  autoscaling_policy_stack = [
    {
      name                   = "scale_up"
      scaling_adjustment     = 4
      adjustment_type        = "ChangeInCapacity"
      cooldown               = 300
      autoscaling_group_name = ""

      target_tracking_configuration    = []
      predictive_scaling_configuration = []
    },
    {
      name                   = "scale_down"
      scaling_adjustment     = 2
      adjustment_type        = "ChangeInCapacity"
      cooldown               = 300
      autoscaling_group_name = ""

      target_tracking_configuration    = []
      predictive_scaling_configuration = []
    },
    {
      name                   = "test"
      adjustment_type        = "ChangeInCapacity"
      cooldown               = 300
      autoscaling_group_name = ""

      step_adjustment = [
        {
          scaling_adjustment          = 1
          metric_interval_lower_bound = 1.0
          metric_interval_upper_bound = 2.0
        }
      ]

      target_tracking_configuration    = []
      predictive_scaling_configuration = []
    }
  ]

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

  enable_autoscaling_schedule = true
  autoscaling_schedule_stack = [
    {
      scheduled_action_name  = "scale_out"
      min_size               = 0
      max_size               = 0
      desired_capacity       = 0
      recurrence             = "0 9 * * *"
      autoscaling_group_name = ""
    },
    {
      scheduled_action_name  = "scale_in"
      min_size               = 0
      max_size               = 0
      desired_capacity       = 0
      recurrence             = "0 17 * * *"
      autoscaling_group_name = ""
    }
  ]

}