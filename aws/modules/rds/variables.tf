#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-RDS"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}

variable "create_rds_cluster" {
    description = "If true, then rds cluster will create"
    default     = false
}

variable "number_of_instances_in_the_cluster" {
    description = "Number of nodes in the cluster"
    default     = "1"
}

variable "db_cluster_parameter_group_name" {
    description = "A cluster parameter group to associate with the cluster."
    default     = ""
}

variable "instance_parameter_group_name" {
    description = "A instance parameter group to associate"
    default     = ""
}

variable "subnet_ids" {
    description = "subnet IDs"
    type        = "list"
}

variable "identifier" {
    description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier."
    default     = ""
}

variable "identifier_prefix" {
    description = "Creates a unique identifier beginning with the specified prefix. Conflicts with identifer."
    default     = ""
}

variable "allocated_storage" {
    description = "The allocated storage in gigabytes."
    default     = "20"
}

variable "storage_type" {
    description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
    default     = "gp2"
}

variable "iops" {
    description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1', default is 0 if rds storage type is not io1"
    default     = "0"
}

variable "engine" {
    description = "The database engine to use (mysql, postgres etc)"
    default     = "mysql"
}

variable "engine_version" {
    description = "The engine version to use."
    default     = "5.6.37"
}

variable "instance_class" {
    description = "The instance type of the RDS instance."
    default     = "db.t2.micro"
}

variable "db_name" {
    description = "The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Note that this does not apply for Oracle or SQL Server engines."
    default     = "db_name_test"
}

variable "db_username" {
    description = "Username for the master DB user."
    default     = "root"
}

variable "db_password" {
    description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file."
    default     = "ROot666roOT"
}

variable "default_ports" {
    description = "Default database ports"  
    type        = "map"
    default     = {
        mysql    = "3306"
        postgres = "5432"
        oracle   = "1521"
    }
}

#lookup parameters for specic RDS types
variable "default_db_parameters" {
    default = {
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
        aurora        = [
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
        ]  
        postgres      = []
        oracle        = []
    }
}
variable "db_group_family" {
    description = "Set DB group family"
    type        = "map"
    default     = {
        mysql     = "mysql5.6"
        postgres  = "postgres9.6"
        oracle    = "oracle-ee-12.1"   
        aurora    = "aurora5.6"  
    }
}
    
variable "character_set_name" {
    description = "The character set name to use for DB encoding in Oracle instances. This can't be changed"
    #default     = "utf8"
    default     = ""
}

variable "db_subnet_group_name" {
    description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC, or in EC2 Classic, if available."
    default     = ""
}

variable "parameter_group_name" {
    description = "Name of the DB parameter group to associate."
    #default     = "default.mysql5.6"
    default     = ""
}

variable "publicly_accessible" {
    description = "Bool to control if instance is publicly accessible. Default is false."
    default     = "false"
}

variable "storage_encrypted" {
    description = "Specifies whether the DB instance is encrypted. The default is false if not specified."
    default     = "false"
}

variable "vpc_security_group_ids" {
    description = "List of VPC security groups to associate."
    type        = "list"
    default     = []
}

variable "iam_database_authentication_enabled" {
    description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled."
    default     = []
}

variable "availability_zones" {
    description = "Availability zones for AWS ASG"
    type        = "map"
    default     = {
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
    }
}

variable "backup_retention_period" {
    description = "The backup retention period (in days)"
    default     = "0"
}

variable "backup_window" {
    description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window."
    ## 12:00AM-12:30AM ET
    default     = "09:00-09:30"
}

variable "maintenance_window" {
    description = "The daily time range (in UTC) during which maintenance window are enabled. Must not overlap with backup_window."
    # SUN 12:30AM-01:30AM ET
    default = "sun:04:30-sun:05:30"
}

variable "monitoring_interval" {
    description = "To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
    default     = "0"
}

variable "replicate_source_db" {
    description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate."
    default     = ""
}

variable "skip_final_snapshot" {
    description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier. Default is false."
    default     = "false"
}

variable "copy_tags_to_snapshot" {
    description = "On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified). Default is false."
    default     = "false"
}

#variable "final_snapshot_identifier" {
#    description = "The name of your final DB snapshot when this DB instance is deleted. If omitted, no final snapshot will be made."
#    default     = "2018"
#}

variable "multi_az" {
    description = "If the RDS instance is multi AZ enabled."
    default     = "false"
}

variable "allow_major_version_upgrade" {
    description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible."
    default     = "true"
}

variable "auto_minor_version_upgrade" {
    description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true."
    default     = "false"
}

variable "apply_immediately" {
    description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false"
    default     = "false"
}
