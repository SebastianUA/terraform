#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
    profile                 = "default"
}
module "iam" {
    source                          = "../../modules/iam"
    name                            = "My-Security"
    region                          = "us-east-1"
    environment                     = "PROD"

    aws_iam_role-principals         = [
        "ec2.amazonaws.com",
    ]
    aws_iam_policy-actions           = [
        "cloudwatch:GetMetricStatistics",
        "logs:DescribeLogStreams",
        "logs:GetLogEvents",
        "elasticache:Describe*",
        "rds:Describe*",
        "rds:ListTagsForResource",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs",
        "ec2:Owner",
    ]
}
module "vpc" {
    source                              = "../../modules/vpc"
    name                                = "My"
    environment                         = "PROD"
    # VPC
    instance_tenancy                    = "default"
    enable_dns_support                  = "true"
    enable_dns_hostnames                = "true"
    assign_generated_ipv6_cidr_block    = "false"
    enable_classiclink                  = "false"
    vpc_cidr                            = "172.31.0.0/16"
    private_subnet_cidrs                = ["172.31.32.0/20", "172.31.48.0/20"]
    public_subnet_cidrs                 = ["172.31.80.0/20"]
    availability_zones                  = ["us-east-1a", "us-east-1e"]
    enable_all_egress_ports             = "true"
    allowed_ports                       = ["8080", "3306", "443", "80"]

    map_public_ip_on_launch             = "true"

    #Internet-GateWay
    enable_internet_gateway             = "true"
    #NAT
    enable_nat_gateway                  = "false"
    single_nat_gateway                  = "true"
    #VPN
    enable_vpn_gateway                  = "false"
    #DHCP
    enable_dhcp_options                 = "false"
    # EIP
    enable_eip                          = "false"
}
module "ec2" {
    source                              = "../../modules/ec2"
    name                                = "TEST-Machine"
    region                              = "us-east-1"
    environment                         = "PROD"
    number_of_instances                 = 1
    ec2_instance_type                   = "t2.micro"
    enable_associate_public_ip_address  = "true"
    disk_size                           = "8"
    tenancy                             = "${module.vpc.instance_tenancy}"
    iam_instance_profile                = "${module.iam.instance_profile_id}"
    subnet_id                           = "${element(module.vpc.vpc-publicsubnet-ids, 0)}"
    #subnet_id                           = "${element(module.vpc.vpc-privatesubnet-ids, 0)}"
    #subnet_id                           = ["${element(module.vpc.vpc-privatesubnet-ids)}"]
    vpc_security_group_ids              = ["${module.vpc.security_group_id}"]

    monitoring                          = "true"
}
#module "kms" {
#    source               = "../../modules/kms"
#    name                 = "TEST-KMS"
#    environment          = "PROD"
#
#    aws_account_id       = "XXXXXXXXXXXXXXXXX"
#}
#module "s3" {
#    source                              = "../../modules/s3"
#    name                                = "My-backet"
#    environment                         = "PROD"
#
#    #
#    s3_acl          = "log-delivery-write"  #"private"
#    force_destroy   = "true"
#    # Allow public web-site (Static website hosting)
#    website         = [
#    {
#        index_document = "index.html"
#        error_document = "error.html"
#        #redirect_all_requests_to = "https://s3-website.linux-notes.org"
#    },
#    ]
#    # Use cors rules
#    cors_rule       = [
#    {
#        allowed_headers = ["*"]
#        allowed_methods = ["PUT", "POST"]
#        allowed_origins = ["https://s3-website.linux-notes.org"]
#        expose_headers  = ["ETag"]
#        max_age_seconds = 3000
#    },
#    ]
#
#    kms_master_key_id = "arn:aws:kms:${module.kms.region}:${module.kms.aws_account_id}:key/${module.kms.kms_key_id}"
#}
module "alb" {
    source                  = "../../modules/alb"
    name                    = "App-Load-Balancer"
    region                  = "us-east-1"
    environment             = "PROD"
    
    load_balancer_type          = "application"
    security_groups             = ["${module.vpc.security_group_id}", "${module.vpc.default_security_group_id}"]
    subnets                     = ["${module.vpc.vpc-privatesubnet-ids}"]
    vpc_id                      = "${module.vpc.vpc_id}"   
    enable_deletion_protection  = false
    
    backend_protocol    = "HTTP"
    alb_protocols       = "HTTP"
   
    #It's not working properly when use EC2... First of all, comment the line under this text. Run playbook. Uncomment that line:
    target_ids          = ["${module.ec2.instance_ids}"]
    
    #access_logs = [
    #    {
    #        enabled         = true 
    #        bucket          = "${module.s3.bucket_name}"
    #        prefix          = "log"
    #    },
    #]

}
