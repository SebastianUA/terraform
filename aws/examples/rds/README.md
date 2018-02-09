# Work with AWS RDS via terraform

A terraform module for making RDS (instances or cluster).

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region  = "us-east-1"
    # alias = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
     # access_key = "${var.aws_access_key}"
     # secret_key = "${var.aws_secret_key}"
}
module "iam" {
    source                          = "../../modules/iam"
    name                            = "TEST-AIM"
    region                          = "us-east-1"
    environment                     = "PROD"

    aws_iam_role-principals         = [
        "ec2.amazonaws.com",
        "monitoring.rds.amazonaws.com",
    ]
    aws_iam_policy-actions           = [
        "cloudwatch:GetMetricStatistics",
        "logs:DescribeLogStreams",
        "logs:GetLogEvents",
        "rds:*",
    ]
}
module "vpc" {
    source                              = "../../modules/vpc"
    name                                = "TEST-VPC"
    environment                         = "PROD"
    # VPC
    instance_tenancy                    = "default"
    enable_dns_support                  = "true"
    enable_dns_hostnames                = "true"
    assign_generated_ipv6_cidr_block    = "false"
    enable_classiclink                  = "false"
    vpc_cidr                            = "172.31.0.0/16"
    private_subnet_cidrs                = ["172.31.64.0/20"]
    public_subnet_cidrs                 = ["172.31.0.0/20"]
    availability_zones                  = ["us-east-1a", "us-east-1b"]
    enable_all_egress_ports             = "true"
    allowed_ports                       = ["80", "3306", "8080", "443"]

    map_public_ip_on_launch             = "true"

    #Internet-GateWay
    enable_internet_gateway             = "true"
    #NAT
    enable_nat_gateway                  = "false"
    single_nat_gateway                  = "false"
    #VPN
    enable_vpn_gateway                  = "false"
    #DHCP
    enable_dhcp_options                 = "false"
    # EIP
    enable_eip                          = "false"
}
module "rds" {
    source              = "../../modules/rds"
    name                = "Test-DB"
    region              = "us-east-1"
    environment         = "PROD"
    
    subnet_ids          = ["subnet-11ed234b", "subnet-34eddf51"]
    ##subnet_ids          = ["module.vpc.vpc-privatesubnet-ids"]
    # Single node(s)
    #create_rds_cluster  = false
    #engine              = "mysql"
    
    ## For cluster
    create_rds_cluster  = true
    ## aurora or aurora-postgresql. !!!!Tested just for aurora!!!!
    engine              = "aurora"
    instance_class      = "db.t2.small"
    
}
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix" (`default = "TEST"`).
- `environment` - Environment for service (`default = stage`). Just uses for tag.
- `orchestration` - Type of orchestration (`default = Terraform`). Just uses for tag.
- `createdby` - Created by (`default = Vitaliy Natarov`). Just uses for tag.
- `create_rds_cluster` - If true, then rds cluster will create (`default = false`).
- `number_of_instances_in_the_cluster` - Number of nodes in the cluster (`default = "1"`).
- `db_cluster_parameter_group_name` - A cluster parameter group to associate with the cluster (`default = ""`).
- `instance_parameter_group_name` - A instance parameter group to associate (`default = ""`).
- `subnet_ids` - subnet IDs.
- `identifier` - The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier (`default = ""`).
- `identifier_prefix` - Creates a unique identifier beginning with the specified prefix. Conflicts with identifer (`default = ""`).
- `allocated_storage` - The allocated storage in gigabytes (`default = "20"`).
- `storage_type` - One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2' (`default = "gp2"`).
- `iops` - The amount of provisioned IOPS. Setting this implies a storage_type of 'io1', default is 0 if rds storage type is not io1 (`default = "0"`).
- `engine` - The database engine to use (mysql, postgres etc) - (`default = "mysql"`).
- `engine_version` - The engine version to use (`default = "5.6.37"`).
- `instance_class` - The instance type of the RDS instance (`default = "db.t2.micro"`).
- `db_name` - The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Note that this does not apply for Oracle or SQL Server engines (`default = "db_name_test"`).
- `db_username` - Username for the master DB user (`efault = "root"`).
- `db_password` - Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file (`default  = "ROot666roOT"`).
- `db_port` - The database port (3306 etc) - (`default = "3306"`).
- `default_ports` - Default database ports (`default     = {
        mysql    = "3306"
        postgres = "5432"
        oracle   = "1521"
    }`).
- `default_db_parameters` - Default db parameters (`default = {
        mysql = [
            {
                name  = "slow_query_log"
                value = "1"
            },
            {
                name  = "long_query_time"
                value = "1"
            },
            {
                name  = "general_log"
                value = "0"
            },
            {
                name  = "log_output"
                value = "FILE"
            },
            {
                name  = "character_set_server"
                value = "utf8"
            },
            {
                name  = "character_set_client"
                value = "utf8"
            },
        ]
        postgres = []
        oracle   = `).
- `character_set_name` - The character set name to use for DB encoding in Oracle instances. This can't be changed (`default = ""`).
- `db_subnet_group_name` - Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC, or in EC2 Classic, if available (`default = ""`).
- `parameter_group_name` - Name of the DB parameter group to associate (`efault = "default.mysql5.6"`).
- `publicly_accessible` - Bool to control if instance is publicly accessible. Default is false (`default = "false"`).
- `storage_encrypted` - Specifies whether the DB instance is encrypted. The default is false if not specified (`default  = "false"`).
- `vpc_security_group_ids` - List of VPC security groups to associate (`default = []`).
- `iam_database_authentication_enabled` - Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled (`default = []`).
- `availability_zones` - Availability zones for AWS ASG (`default     = {
        us-east-1      = "us-east-1b,us-east-1a"
        us-east-2      = "us-east-2a,eu-east-2b,eu-east-2c"
        us-west-1      = "us-west-1a,us-west-1c"
        us-west-2      = "us-west-2a,us-west-2b,us-west-2c"
        ca-central-1   = "ca-central-1a,ca-central-1b"
        eu-west-1      = "eu-west-1a,eu-west-1b,eu-west-1c"
        eu-west-2      = "eu-west-2a,eu-west-2b"
        eu-central-1   = "eu-central-1a,eu-central-1b,eu-central-1c"
        ap-south-1     = "ap-south-1a,ap-south-1b"
        sa-east-1      = "sa-east-1a,sa-east-1c"
        ap-northeast-1 = "ap-northeast-1a,ap-northeast-1c"
        ap-southeast-1 = "ap-southeast-1a,ap-southeast-1b"
        ap-southeast-2 = "ap-southeast-2a,ap-southeast-2b,ap-southeast-2c"
        ap-northeast-1 = "ap-northeast-1a,ap-northeast-1c"
        ap-northeast-2 = "ap-northeast-2a,ap-northeast-2c"
    }`).
- `backup_retention_period` - The backup retention period (in days) - (`default = "0"`).
- `backup_window` - The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window (`default = "09:00-09:30"`).
- `maintenance_window` - The daily time range (in UTC) during which maintenance window are enabled. Must not overlap with backup_window (`default = "sun:04:30-sun:05:30"`).
- `monitoring_interval` - To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60 (`default = "0"`).
- `replicate_source_db` - Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate (`default = ""`).
- `skip_final_snapshot` - Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier. Default is false (`default  = "false"`).
- `copy_tags_to_snapshot` - On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified). Default is false (`default  = "false"`).
- `multi_az` - If the RDS instance is multi AZ enabled (`default  = "false"`).
- `allow_major_version_upgrade` - Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible (`default  = "true"`).
- `auto_minor_version_upgrade` - Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true (`default  = "false"`).
- `apply_immediately` - Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false (`default  = "false"`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
