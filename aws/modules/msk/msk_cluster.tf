#---------------------------------------------------
# Create aws msk cluster
#---------------------------------------------------
resource "aws_msk_cluster" "msk_cluster_default" {
    count                   = "${var.enable_msk_cluster_default && !var.enable_msk_cluster_encryption && !var.enable_msk_cluster_client_authentication && !var.enable_msk_cluster_configuration_info && !var.enable_msk_cluster_encryption_and_authentication && !var.enable_msk_cluster_encryption_and_configuration_info && !var.enable_msk_cluster_client_authentication_and_configuration_info && !var.enable_msk_cluster_all ? 1 : 0}"

    cluster_name           = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
    kafka_version          = "${var.kafka_version}"
    number_of_broker_nodes = "${var.number_of_broker_nodes}"

    broker_node_group_info {
        instance_type   = "${var.broker_node_group_info_instance_type}"
        ebs_volume_size = "${var.broker_node_group_info_ebs_volume_size}"
        client_subnets  = ["${var.broker_node_group_info_client_subnets}"]
        security_groups = ["${var.broker_node_group_info_security_groups}"]
        az_distribution = "${var.broker_node_group_info_az_distribution}"
    }

    tags = {
        Name            = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    depends_on  = []

}

resource "aws_msk_cluster" "msk_cluster_encryption" {
    count                   = "${!var.enable_msk_cluster_default && var.enable_msk_cluster_encryption && !var.enable_msk_cluster_client_authentication && !var.enable_msk_cluster_configuration_info && !var.enable_msk_cluster_encryption_and_authentication && !var.enable_msk_cluster_encryption_and_configuration_info && !var.enable_msk_cluster_client_authentication_and_configuration_info && !var.enable_msk_cluster_all ? 1 : 0}"

    cluster_name           = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
    kafka_version          = "${var.kafka_version}"
    number_of_broker_nodes = "${var.number_of_broker_nodes}"

    broker_node_group_info {
        instance_type   = "${var.broker_node_group_info_instance_type}"
        ebs_volume_size = "${var.broker_node_group_info_ebs_volume_size}"
        client_subnets  = ["${var.broker_node_group_info_client_subnets}"]
        security_groups = ["${var.broker_node_group_info_security_groups}"]
        az_distribution = "${var.broker_node_group_info_az_distribution}"
    }

    encryption_info {
        encryption_at_rest_kms_key_arn  = "${var.encryption_info_encryption_at_rest_kms_key_arn}"
        encryption_in_transit {
            client_broker   = "${upper(var.encryption_in_transit_client_broker)}"
            in_cluster      = "${var.encryption_in_transit_in_cluster}"    
        }
    }

    tags = {
        Name            = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    depends_on  = []

}

resource "aws_msk_cluster" "msk_cluster_client_authentication" {
    count                   = "${!var.enable_msk_cluster_default && !var.enable_msk_cluster_encryption && var.enable_msk_cluster_client_authentication && !var.enable_msk_cluster_configuration_info && !var.enable_msk_cluster_encryption_and_authentication && !var.enable_msk_cluster_encryption_and_configuration_info && !var.enable_msk_cluster_client_authentication_and_configuration_info && !var.enable_msk_cluster_all ? 1 : 0}"

    cluster_name           = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
    kafka_version          = "${var.kafka_version}"
    number_of_broker_nodes = "${var.number_of_broker_nodes}"

    broker_node_group_info {
        instance_type   = "${var.broker_node_group_info_instance_type}"
        ebs_volume_size = "${var.broker_node_group_info_ebs_volume_size}"
        client_subnets  = ["${var.broker_node_group_info_client_subnets}"]
        security_groups = ["${var.broker_node_group_info_security_groups}"]
        az_distribution = "${var.broker_node_group_info_az_distribution}"
    }

    client_authentication {
        tls {
            certificate_authority_arns  = ["${var.client_authentication_certificate_authority_arns}"]
        }    
    }

    tags = {
        Name            = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    depends_on  = []

}

resource "aws_msk_cluster" "msk_cluster_configuration_info" {
    count                   = "${!var.enable_msk_cluster_default && !var.enable_msk_cluster_encryption && !var.enable_msk_cluster_client_authentication && var.enable_msk_cluster_configuration_info && !var.enable_msk_cluster_encryption_and_authentication && !var.enable_msk_cluster_encryption_and_configuration_info && !var.enable_msk_cluster_client_authentication_and_configuration_info && !var.enable_msk_cluster_all ? 1 : 0}"

    cluster_name           = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
    kafka_version          = "${var.kafka_version}"
    number_of_broker_nodes = "${var.number_of_broker_nodes}"

    broker_node_group_info {
        instance_type   = "${var.broker_node_group_info_instance_type}"
        ebs_volume_size = "${var.broker_node_group_info_ebs_volume_size}"
        client_subnets  = ["${var.broker_node_group_info_client_subnets}"]
        security_groups = ["${var.broker_node_group_info_security_groups}"]
        az_distribution = "${var.broker_node_group_info_az_distribution}"
    }

    configuration_info {
        arn         = "${var.configuration_info_arn}"
        revision    = "${var.configuration_info_revision}"
    }

    tags = {
        Name            = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    depends_on  = []

}

resource "aws_msk_cluster" "msk_cluster_encryption_and_authentication" {
    count                   = "${!var.enable_msk_cluster_default && !var.enable_msk_cluster_encryption && !var.enable_msk_cluster_client_authentication && !var.enable_msk_cluster_configuration_info && var.enable_msk_cluster_encryption_and_authentication && !var.enable_msk_cluster_encryption_and_configuration_info && !var.enable_msk_cluster_client_authentication_and_configuration_info && !var.enable_msk_cluster_all ? 1 : 0}"

    cluster_name           = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
    kafka_version          = "${var.kafka_version}"
    number_of_broker_nodes = "${var.number_of_broker_nodes}"

    broker_node_group_info {
        instance_type   = "${var.broker_node_group_info_instance_type}"
        ebs_volume_size = "${var.broker_node_group_info_ebs_volume_size}"
        client_subnets  = ["${var.broker_node_group_info_client_subnets}"]
        security_groups = ["${var.broker_node_group_info_security_groups}"]
        az_distribution = "${var.broker_node_group_info_az_distribution}"
    }

    encryption_info {
        encryption_at_rest_kms_key_arn  = "${var.encryption_info_encryption_at_rest_kms_key_arn}"
        encryption_in_transit {
            client_broker   = "${upper(var.encryption_in_transit_client_broker)}"
            in_cluster      = "${var.encryption_in_transit_in_cluster}"    
        }
    }

     client_authentication {
        tls {
            certificate_authority_arns  = ["${var.client_authentication_certificate_authority_arns}"]
        }    
    }

    tags = {
        Name            = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    depends_on  = []

}

resource "aws_msk_cluster" "msk_cluster_encryption_and_configuration_info" {
    count                   = "${!var.enable_msk_cluster_default && !var.enable_msk_cluster_encryption && !var.enable_msk_cluster_client_authentication && !var.enable_msk_cluster_configuration_info && !var.enable_msk_cluster_encryption_and_authentication && var.enable_msk_cluster_encryption_and_configuration_info && !var.enable_msk_cluster_client_authentication_and_configuration_info && !var.enable_msk_cluster_all ? 1 : 0}"

    cluster_name           = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
    kafka_version          = "${var.kafka_version}"
    number_of_broker_nodes = "${var.number_of_broker_nodes}"

    broker_node_group_info {
        instance_type   = "${var.broker_node_group_info_instance_type}"
        ebs_volume_size = "${var.broker_node_group_info_ebs_volume_size}"
        client_subnets  = ["${var.broker_node_group_info_client_subnets}"]
        security_groups = ["${var.broker_node_group_info_security_groups}"]
        az_distribution = "${var.broker_node_group_info_az_distribution}"
    }

    encryption_info {
        encryption_at_rest_kms_key_arn  = "${var.encryption_info_encryption_at_rest_kms_key_arn}"
        encryption_in_transit {
            client_broker   = "${upper(var.encryption_in_transit_client_broker)}"
            in_cluster      = "${var.encryption_in_transit_in_cluster}"    
        }
    }

    configuration_info {
        arn         = "${var.configuration_info_arn}"
        revision    = "${var.configuration_info_revision}"
    }

    tags = {
        Name            = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    depends_on  = []

}

resource "aws_msk_cluster" "msk_cluster_client_authentication_and_configuration_info" {
    count                   = "${!var.enable_msk_cluster_default && !var.enable_msk_cluster_encryption && !var.enable_msk_cluster_client_authentication && !var.enable_msk_cluster_configuration_info && !var.enable_msk_cluster_encryption_and_authentication && !var.enable_msk_cluster_encryption_and_configuration_info && var.enable_msk_cluster_client_authentication_and_configuration_info && !var.enable_msk_cluster_all ? 1 : 0}"

    cluster_name           = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
    kafka_version          = "${var.kafka_version}"
    number_of_broker_nodes = "${var.number_of_broker_nodes}"

    broker_node_group_info {
        instance_type   = "${var.broker_node_group_info_instance_type}"
        ebs_volume_size = "${var.broker_node_group_info_ebs_volume_size}"
        client_subnets  = ["${var.broker_node_group_info_client_subnets}"]
        security_groups = ["${var.broker_node_group_info_security_groups}"]
        az_distribution = "${var.broker_node_group_info_az_distribution}"
    }

    client_authentication {
        tls {
            certificate_authority_arns  = ["${var.client_authentication_certificate_authority_arns}"]
        }    
    }

    configuration_info {
        arn         = "${var.configuration_info_arn}"
        revision    = "${var.configuration_info_revision}"
    }


    tags = {
        Name            = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    depends_on  = []

}

resource "aws_msk_cluster" "msk_cluster_all" {
    count                   = "${!var.enable_msk_cluster_default && !var.enable_msk_cluster_encryption && !var.enable_msk_cluster_client_authentication && !var.enable_msk_cluster_configuration_info && !var.enable_msk_cluster_encryption_and_authentication && !var.enable_msk_cluster_encryption_and_configuration_info && !var.enable_msk_cluster_client_authentication_and_configuration_info && var.enable_msk_cluster_all ? 1 : 0}"

    cluster_name           = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
    kafka_version          = "${var.kafka_version}"
    number_of_broker_nodes = "${var.number_of_broker_nodes}"

    broker_node_group_info {
        instance_type   = "${var.broker_node_group_info_instance_type}"
        ebs_volume_size = "${var.broker_node_group_info_ebs_volume_size}"
        client_subnets  = ["${var.broker_node_group_info_client_subnets}"]
        security_groups = ["${var.broker_node_group_info_security_groups}"]
        az_distribution = "${var.broker_node_group_info_az_distribution}"
    }

    encryption_info {
        encryption_at_rest_kms_key_arn  = "${var.encryption_info_encryption_at_rest_kms_key_arn}"
        encryption_in_transit {
            client_broker   = "${upper(var.encryption_in_transit_client_broker)}"
            in_cluster      = "${var.encryption_in_transit_in_cluster}"    
        }
    }

    client_authentication {
        tls {
            certificate_authority_arns  = ["${var.client_authentication_certificate_authority_arns}"]
        }    
    }

    configuration_info {
        arn         = "${var.configuration_info_arn}"
        revision    = "${var.configuration_info_revision}"
    }

    tags = {
        Name            = "${var.cluster_name !="" ? var.cluster_name : "${lower(var.name)}-msk-cluster-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    depends_on  = []

}
