#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~>0.12.2"
}

provider "aws" {
    region                  = "us-west-2"
    profile                 = "profile_here"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
}

# AWS VPC

# AWS SG
 
# AWS KMS
#module "kms" {
#    source               = "../../modules/kms"
#    name                 = "TEST-KMS"
#    environment          = "STAGE"
#
#    aws_account_id       = "3432432433253"
#}

# AWS ACM
#module "acm_certificate" {
#    source                      = "../../modules/acm"
#                        
#    acm_certificate             = "true"
#
#    domain_name                 = "domain.com"
#    subject_alternative_names   = ["www.domain.com", "domain.com"]
#    validation_method           = "EMAIL"
#
#    import_existing_certificate = "false"
#    #private_key                 = ""
#    #certificate_body            = ""
#    #certificate_chain           = ""
#}
#
#module "acm_certificate_validation" {
#    source                      = "../../modules/acm"
#    
#    acm_certificate_validation  = "true"
#    certificate_arn             = "${module.acm_certificate.aws_acm_certificate_arn}"
#    validation_record_fqdns     = []
#}

module "msk" {
    source                                          =  "../../modules/msk"


    enable_msk_cluster                              = "true"
    kafka_version                                   = "2.1.0"
    number_of_broker_nodes                          = "3"
    

    broker_node_group_info_instance_type            = "kafka.m5.large"
    broker_node_group_info_ebs_volume_size          = "100"
    broker_node_group_info_client_subnets           = ["subnet-02697458", "subnet-02e9c549", "subnet-289d9e51"] 
    #, "subnet-6548dd4e"]
    broker_node_group_info_security_groups          = ["sg-014100db4cdff3e0a", "sg-038b8bd5f9120f3c3", "sg-044c87b82fc0fa439", "sg-0eb59e471c3d5a87b", "sg-7f501633"]
    
    #encryption_info_encryption_at_rest_kms_key_arn  = "${module.kms.}"

    #client_authenication_certificate_authority_arns = ["${module.acm_certificate.aws_acm_certificate_arn}"]
                                                    
}                       
