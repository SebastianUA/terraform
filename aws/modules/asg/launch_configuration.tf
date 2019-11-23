#---------------------------------------------------
# Launch AWS configuration
#---------------------------------------------------
resource "aws_launch_configuration" "lc" {
    count                       = "${var.enable_lc == "true" && var.name_prefix =="" ? 1 : 0}"
    
    name                        = "${var.launch_configuration_name != "" ? var.launch_configuration_name : "${lower(var.name)}-lc-${lower(var.environment)}" }"
    image_id                    = "${lookup(var.ami, var.region)}"
    instance_type               = "${var.ec2_instance_type}"
    security_groups             = ["${var.security_groups}"]
    iam_instance_profile        = "${var.iam_instance_profile}"
    
    key_name                    = "${var.key_name}"    
    user_data                   = "${data.template_file.user_data.rendered}"
              
    #associate_public_ip_address = "${var.enable_associate_public_ip_address}"
    associate_public_ip_address = "${!var.enable_asg_azs ? var.enable_associate_public_ip_address : "false" }"
    enable_monitoring           = "${var.enable_monitoring}"
    placement_tenancy           = "${var.placement_tenancy}" 
    
    ebs_optimized               = "${var.ebs_optimized}"
    ebs_block_device            = "${var.ebs_block_device}"
    ephemeral_block_device      = "${var.ephemeral_block_device}"
    root_block_device           = "${var.root_block_device}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = ["user_data"]
    }
    
    depends_on = []
}

resource "aws_launch_configuration" "lc_spot" {
    count                       = "${var.enable_lc_spot == "true" && var.name_prefix =="" ? 1 : 0}"
    
    name                        = "${var.launch_configuration_name != "" ? var.launch_configuration_name : "${lower(var.name)}-lc-${lower(var.environment)}" }"
    image_id                    = "${lookup(var.ami, var.region)}"
    instance_type               = "${var.ec2_instance_type}"
    security_groups             = ["${var.security_groups}"]
    iam_instance_profile        = "${var.iam_instance_profile}"
    
    key_name                    = "${var.key_name}"    
    user_data                   = "${data.template_file.user_data.rendered}"
              
    #associate_public_ip_address = "${var.enable_associate_public_ip_address}"
    associate_public_ip_address = "${!var.enable_asg_azs ? var.enable_associate_public_ip_address : false }"   
    enable_monitoring           = "${var.enable_monitoring}"
    spot_price                  = "${var.spot_price}"  
    
    ebs_optimized               = "${var.ebs_optimized}"
    ebs_block_device            = "${var.ebs_block_device}"
    ephemeral_block_device      = "${var.ephemeral_block_device}"
    root_block_device           = "${var.root_block_device}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = ["user_data"]
    }
    
    depends_on = []
}

resource "aws_launch_configuration" "lc_prefix" {
    count                       = "${var.enable_lc == "true" && var.name_prefix !="" ? 1 : 0}"
    
    name_prefix                 = "${var.name_prefix}"
    image_id                    = "${lookup(var.ami, var.region)}"
    instance_type               = "${var.ec2_instance_type}"
    security_groups             = ["${var.security_groups}"]
    iam_instance_profile        = "${var.iam_instance_profile}"
    
    key_name                    = "${var.key_name}" 
    user_data                   = "${data.template_file.user_data.rendered}"
    
    associate_public_ip_address = "${!var.enable_asg_azs ? var.enable_associate_public_ip_address : false }"   

    enable_monitoring           = "${var.enable_monitoring}"
    placement_tenancy           = "${var.placement_tenancy}"
    
    ebs_optimized               = "${var.ebs_optimized}"
    ebs_block_device            = "${var.ebs_block_device}"
    ephemeral_block_device      = "${var.ephemeral_block_device}"
    root_block_device           = "${var.root_block_device}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = ["user_data"]
    }
    
    depends_on = []
}

resource "aws_launch_configuration" "lc_spot_prefix" {
    count                       = "${var.enable_lc_spot == "true" && var.name_prefix !="" ? 1 : 0}"
    
    name_prefix                 = "${var.name_prefix}"
    image_id                    = "${lookup(var.ami, var.region)}"
    instance_type               = "${var.ec2_instance_type}"
    security_groups             = ["${var.security_groups}"]
    iam_instance_profile        = "${var.iam_instance_profile}"
    
    key_name                    = "${var.key_name}" 
    user_data                   = "${data.template_file.user_data.rendered}"
    
    associate_public_ip_address = "${!var.enable_asg_azs ? var.enable_associate_public_ip_address : false }"   
    enable_monitoring           = "${var.enable_monitoring}"
    spot_price                  = "${var.spot_price}"  
    
    ebs_optimized               = "${var.ebs_optimized}"
    ebs_block_device            = "${var.ebs_block_device}"
    ephemeral_block_device      = "${var.ephemeral_block_device}"
    root_block_device           = "${var.root_block_device}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = ["user_data"]
    }
    
    depends_on = []
}

data "template_file" "user_data" {
    template = "${var.user_data}"

    vars {
      region = "${var.region}"
    }
}