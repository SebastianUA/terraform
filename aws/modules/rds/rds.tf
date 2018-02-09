#---------------------------------------------------
# Create AWS RDS instance(s)
#---------------------------------------------------
resource "aws_db_instance" "db_instance" {
    count                       = "${var.create_rds_cluster ? 0 : var.number_of_instances_in_the_cluster}"

    identifier                  = "${lower(var.name)}-rds-${lower(var.environment)}-${count.index+1}"
    allocated_storage           = "${var.allocated_storage}"
    storage_type                = "${var.storage_type}"
    iops                        = "${var.iops}"
    engine                      = "${var.engine}"
    engine_version              = "${var.engine_version}"
    instance_class              = "${var.instance_class}"
    replicate_source_db         = "${var.replicate_source_db}"
    backup_retention_period     = "${var.backup_retention_period}"
    backup_window               = "${var.backup_window}"
    copy_tags_to_snapshot       = "${var.copy_tags_to_snapshot}"
    skip_final_snapshot         = "${var.skip_final_snapshot}"
    final_snapshot_identifier   = "${lower(var.name)}-rds-${lower(var.environment)}-${md5(timestamp())}"

    name                    = "${var.db_name}"
    username                = "${var.db_username}"
    password                = "${var.db_password}"
    port                    = "${lookup(var.default_ports, var.engine)}"    
    character_set_name      = "${var.character_set_name}"

    vpc_security_group_ids  = ["${var.vpc_security_group_ids}"]
    db_subnet_group_name    = "${var.db_subnet_group_name == "" ? aws_db_subnet_group.db_subnet_group.id : var.db_subnet_group_name}"
    parameter_group_name    = "${length(var.parameter_group_name) > 0 ? var.parameter_group_name : aws_db_parameter_group.db_parameter_group.id}"
    publicly_accessible     = "${var.publicly_accessible}"
    storage_encrypted       = "${var.storage_encrypted}"
    multi_az                = "${var.multi_az}"

    allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
    auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
    apply_immediately           = "${var.apply_immediately}"
    maintenance_window          = "${var.maintenance_window}"

    monitoring_interval = "${var.monitoring_interval}"             

    tags {
        Name            = "${var.name}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
    
    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = ["final_snapshot_identifier", "replicate_source_db"],
    }
                     
    depends_on  = ["aws_db_subnet_group.db_subnet_group", "aws_db_parameter_group.db_parameter_group"]
}
#---------------------------------------------------
# Create AWS RDS cluster
#---------------------------------------------------
resource "aws_rds_cluster_instance" "rds_cluster_instance" {
    count               = "${var.create_rds_cluster ? var.number_of_instances_in_the_cluster : 0}"
    
    identifier          = "${lower(var.name)}-cluster-${lower(var.environment)}-${count.index+1}"
    cluster_identifier  = "${aws_rds_cluster.rds_cluster.id}"
    instance_class      = "${var.instance_class}"

    db_subnet_group_name    = "${var.db_subnet_group_name == "" ? aws_db_subnet_group.db_subnet_group.id : var.db_subnet_group_name}"
    apply_immediately       = "${var.apply_immediately}"
    db_parameter_group_name = "${var.instance_parameter_group_name == "" ? aws_db_parameter_group.db_parameter_group.id : var.instance_parameter_group_name}"
 
    tags {
        Name            = "${lower(var.name)}-cluster-${lower(var.environment)}-${count.index+1}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    depends_on          = ["aws_rds_cluster.rds_cluster", "aws_db_subnet_group.db_subnet_group", "aws_db_parameter_group.db_parameter_group"]
}

resource "aws_rds_cluster" "rds_cluster" {
    count               = "${var.create_rds_cluster ? 1 : 0}"
    
    cluster_identifier  = "${lower(var.name)}-cluster-${lower(var.environment)}"
    engine                      = "${var.engine}"
    engine_version              = "${var.engine_version}"
    
    backup_retention_period     = "${var.backup_retention_period}"
    preferred_backup_window     = "${var.backup_window}"
    skip_final_snapshot         = "${var.skip_final_snapshot}"
    final_snapshot_identifier   = "${lower(var.name)}-cluster-${lower(var.environment)}-${md5(timestamp())}"

    db_subnet_group_name        = "${var.db_subnet_group_name == "" ? aws_db_subnet_group.db_subnet_group.id : var.db_subnet_group_name}"
    vpc_security_group_ids      = ["${var.vpc_security_group_ids}"]
     
    storage_encrypted               = "${var.storage_encrypted}"
    apply_immediately               = "${var.apply_immediately}"
    db_cluster_parameter_group_name = "${length(var.db_cluster_parameter_group_name) > 0 ? aws_db_parameter_group.db_parameter_group.id : var.db_cluster_parameter_group_name}"
    availability_zones  = ["${split(",", (lookup(var.availability_zones, var.region)))}"]
    
    database_name       = "${var.db_name}"
    master_username     = "${var.db_username}"
    master_password     = "${var.db_password}"

    tags {
        Name            = "${lower(var.name)}-cluster-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = ["final_snapshot_identifier"],
    }
    depends_on          = ["aws_db_subnet_group.db_subnet_group", "aws_db_parameter_group.db_parameter_group"]
}                                                       
#---------------------------------------------------
# Create AWS DB subnet group
#---------------------------------------------------
resource "aws_db_subnet_group" "db_subnet_group" {
    count       = "${var.db_subnet_group_name == "" ? 1 : 0}"    
                                                    
    name        = "${lower(var.name)}-db_subnet_group-for-${var.create_rds_cluster ? "cluster" : "rds"}-${lower(var.environment)}"
    description = "My ${lower(var.name)}-db_subnet_group-for-${var.create_rds_cluster ? "cluster" : "rds"}-${lower(var.environment)} group of subnets"
    subnet_ids  = ["${var.subnet_ids}"]

    tags {
        Name            = "${lower(var.name)}-db_subnet_group-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
  }
}
#---------------------------------------------------
# Create AWS DB parameter group
#---------------------------------------------------
resource "aws_db_parameter_group" "db_parameter_group" {
    count       = "${length(var.parameter_group_name) > 0 ? 0 : 1}"
        
    #name_prefix = "${lower(var.name)}-${lower(var.environment)}-"
    name        = "${lower(var.name)}-db-parameter-group-for-${var.create_rds_cluster ? "cluster" : "rds"}-${lower(var.environment)}"
    description = "RDS ${lower(var.name)}-db_parameter_group-for-${var.create_rds_cluster ? "cluster" : "rds"}-${lower(var.environment)} parameter group for ${var.engine}"
    family      = "${var.db_group_family[var.engine]}"
    parameter   = "${var.default_db_parameters[var.engine]}"

    tags {
        Name            = "${lower(var.name)}-db_parameter_group-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

}

#
# Planned to add https://www.terraform.io/docs/providers/aws/r/db_event_subscription.html in future....
#
