module "sg" {
    source                              = "../../modules/sg"
    name                                = "Bastion_Ukraine"
    environment                         = "PROD"
    

    enable_sg_creating                  = true
    vpc_id                              = "vpc-09f1d36e"
    enable_all_egress_ports             = "true"
    allowed_ports                       = ["22"]
    allow_cidrs_for_allowed_ports       = {
        #
        # Vitalii.Natarov's home IP - 159.224.217.0/24
        #
        "22" = [
            "159.224.217.0/24",    
        ]
    }
}

module "asg" {
    source             = "../../modules/asg"
    name               = "Bastion_Ukraine"
    region             = "us-west-2"
    environment        = "PROD"

    security_groups    = ["${module.sg.security_group_id}"]
    
    root_block_device  = [
        {
            volume_size = "8"
            volume_type = "gp2"
        },
    ]
    placement_tenancy        = "default"    

    ami = {
        us-west-2 = "ami-e761399f"
    }

    enable_associate_public_ip_address = true

    # Auto scaling group
    vpc_zone_identifier                 = ["subnet-6d099924"]
    health_check_type                   = "EC2"
    asg_min_size                        = 0
    asg_max_size                        = 1
    desired_capacity                    = 1
    wait_for_capacity_timeout           = 0
    
    monitoring                          = "true"
    # Set up the autoscaling schedule
    enable_autoscaling_schedule         = true
    asg_recurrence_scale_up             = "0 7 * * MON-FRI"
    asg_recurrence_scale_down           = "0 19 * * MON-FRI"

    # Define SSH key pair for our instances
    key_path                            = "additional_files/prod-bastion_ukraine.pub" 
        
    # Set up launch configuration
    ec2_instance_type                   = "t2.micro"
    user_data                           = "./additional_files/bootstrap.sh"
}