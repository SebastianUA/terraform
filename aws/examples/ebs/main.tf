module "ebs" {
    source                          = "../../modules/ebs"
    name                            = "test"
    region                          = "us-west-2"
    environment                     = "PROD"
                                    
    #
    # AWS EBS volume
    #
    enable_ebs_volume               = true
    type                            = "gp2"
    size                            = 8
    
    ebs_volume_encrypted            = false
    iops                            = 100
    snapshot_id                     = ""
    kms_key_id                      = ""

    #
    # AWS EBS volume attachment
    #
    enable_ebs_volume_attachment    = false
    device_name                     = ""
    instance_id                     = ""
    volume_id                       = ""
    
    force_detach                    = false
    skip_destroy                    = false
}
