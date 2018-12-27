#---------------------------------------------------
# Create AWS route53 zone(s)
#---------------------------------------------------
resource "aws_route53_zone" "route53_zone_default" {
    count               = "${var.enable_route53_zone && var.route53_zone_delegation_set_id == "" && var.route53_zone_vpc_id == "" ? 1 : 0 }"
                            
    name                = "${var.domain_name_for_route53_zone == "" ? "${lower(var.name)}-route53_zone-${lower(var.environment)}" : "${var.domain_name_for_route53_zone}" }"
    comment             = "Public zone for ${var.domain_name_for_route53_zone}"

    force_destroy       = "${var.route53_zone_force_destroy}"

    tags {
        Name            = "${lower(var.name)}-route53_zone-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }
    
    depends_on  = []
}

resource "aws_route53_zone" "route53_zone_with_delegation_set" {
    count               = "${var.enable_route53_zone && var.route53_zone_delegation_set_id != "" && var.route53_zone_vpc_id == "" ? 1 : 0}"

    name                = "${var.domain_name_for_route53_zone == "" ? "${lower(var.name)}-route53_zone-${lower(var.environment)}" : "${var.domain_name_for_route53_zone}" }"
    comment             = "Public zone for ${var.domain_name_for_route53_zone}"

    delegation_set_id   = "${var.route53_zone_delegation_set_id}"

    force_destroy       = "${var.route53_zone_force_destroy}"

    tags {
        Name            = "${lower(var.name)}-route53_zone-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}

resource "aws_route53_zone" "route53_zone_with_vpc" {
    count               = "${var.enable_route53_zone && var.route53_zone_delegation_set_id == "" && var.route53_zone_vpc_id != "" ? 1 : 0}"

    name                = "${var.domain_name_for_route53_zone == "" ? "${lower(var.name)}-route53_zone-${lower(var.environment)}" : "${var.domain_name_for_route53_zone}" }"
    comment             = "Public zone for ${var.domain_name_for_route53_zone}"

    vpc {
        vpc_id      = "${var.route53_zone_vpc_id}"
        vpc_region  = "${var.route53_zone_vpc_region}"
    }

    force_destroy       = "${var.route53_zone_force_destroy}"

    tags {
        Name            = "${lower(var.name)}-route53_zone-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}
#---------------------------------------------------
# Create AWS route53 delegation set
#---------------------------------------------------
resource "aws_route53_delegation_set" "route53_delegation_set" {
    count           = "${var.enable_route53_delegation_set}"
    
    reference_name  = "${var.reference_name}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }
  
    depends_on  = []

}
#---------------------------------------------------
# Create AWS route53 zone association
#---------------------------------------------------
resource "aws_route53_zone_association" "route53_zone_association" {
    count       = "${var.enable_route53_zone_association}"

    zone_id     = "${var.route53_zone_association_zone_id}"
    vpc_id      = "${var.route53_zone_association_vpc_id}"
    vpc_region  = "${var.route53_zone_association_vpc_region}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}
#---------------------------------------------------
# Create AWS Route53 record(s)
#---------------------------------------------------
resource "aws_route53_record" "route53_record_default" {
    count   = "${var.enable_route53_record && !var.evaluate_target_health && var.weighted_routing_policy_weight == "" ? "${length(compact(var.route53_record_names))}" : 0}"
                                                                            
    name    = "${element(compact(var.route53_record_names), count.index)}"
    zone_id = "${var.enable_route53_zone && var.parent_zone_id == "" ? aws_route53_zone.route53_zone_default.zone_id : var.parent_zone_id}"
    type    = "${var.route53_record_type}"
    ttl     = "${var.route53_record_ttl}"
    records = ["${var.route53_record_names}"]
    
    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}

resource "aws_route53_record" "route53_record_alias" {
    count   = "${var.enable_route53_record && var.evaluate_target_health && var.weighted_routing_policy_weight == "" ? "${length(compact(var.route53_record_names))}" : 0}"
    
    name    = "${element(compact(var.route53_record_names), count.index)}"
    zone_id = "${var.enable_route53_zone && var.parent_zone_id == "" ? aws_route53_zone.route53_zone_default.zone_id : var.parent_zone_id}"
    type    = "${var.route53_record_type}"
    
    alias {
        name                   = "${var.target_dns_name}" 
        zone_id                = "${var.target_zone_id}" 
        evaluate_target_health = "${var.evaluate_target_health}"
    }

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}

resource "aws_route53_record" "route53_record_weighted_routing_policy" {
    count   = "${var.enable_route53_record && !var.evaluate_target_health && var.weighted_routing_policy_weight != "" ? "${length(compact(var.route53_record_names))}" : 0}"

    name    = "${element(compact(var.route53_record_names), count.index)}"
    zone_id = "${var.enable_route53_zone && var.parent_zone_id == "" ? aws_route53_zone.route53_zone_default.zone_id : var.parent_zone_id}"
    type    = "${var.route53_record_type}"

    weighted_routing_policy {
        weight = "${var.weighted_routing_policy_weight}"
    }
    
    set_identifier = "${var.set_identifier}"
    records = ["${var.route53_record_names}"]

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}
#---------------------------------------------------
# Create AWS route53 health check(s)
#---------------------------------------------------
resource "aws_route53_health_check" "http_route53_health_check" {
    count             = "${var.create_http_route53_health_check ? 1 : 0}"
    
    fqdn              = "${var.fqdn_for_http_route53_health_check}"
    port              = "${var.port_for_http_route53_health_check}"
    type              = "${var.type_for_http_route53_health_check}"
    resource_path     = "${var.resource_path_for_http_route53_health_check}"
    failure_threshold = "${var.failure_threshold_for_http_route53_health_check}"
    request_interval  = "${var.request_interval_for_http_route53_health_check}"
    measure_latency   = "${var.measure_latency_for_http_route53_health_check}"

    tags {
        Name            = "${lower(var.name)}-http_route53_health_check-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }
    
    depends_on  = []
}

resource "aws_route53_health_check" "https_route53_health_check" {
    count             = "${var.create_https_route53_health_check ? 1 : 0}"

    fqdn              = "${var.fqdn_for_https_route53_health_check}"
    port              = "${var.port_for_https_route53_health_check}"
    type              = "${var.type_for_https_route53_health_check}"
    resource_path     = "${var.resource_path_for_https_route53_health_check}"
    failure_threshold = "${var.failure_threshold_for_https_route53_health_check}"
    request_interval  = "${var.request_interval_for_https_route53_health_check}"
    measure_latency   = "${var.measure_latency_for_https_route53_health_check}"

    tags {
        Name            = "${lower(var.name)}-https_route53_health_check-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }
    
    depends_on  = []
}

resource "aws_route53_health_check" "calculated_route53_health_check" {
    count                   = "${var.create_calculated_route53_health_check}"
                                
    type                    = "${var.type_for_calculated_route53_health_check}"
    child_health_threshold  = "${var.child_health_threshold_for_calculated_route53_health_check}"
    child_healthchecks      = ["${var.child_healthchecks_for_calculated_route53_health_check}"]
    
    tags {
        Name            = "${lower(var.name)}-calculated_route53_health_check-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}

resource "aws_route53_health_check" "cloudwatch_route53_health_check" {
    count                           = "${var.create_cloudwatch_route53_health_check}"
                            
    type                            = "${var.type_for_cloudwatch_route53_health_check}"
    cloudwatch_alarm_name           = "${var.cloudwatch_alarm_name_for_cloudwatch_route53_health_check}"
    cloudwatch_alarm_region         = "${var.cloudwatch_alarm_region_for_cloudwatch_route53_health_check}"
    insufficient_data_health_status = "${var.insufficient_data_health_status_for_cloudwatch_route53_health_check}"

    tags {
        Name            = "${lower(var.name)}-calculated_route53_health_check-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}
#---------------------------------------------------
# Create route53 query log
#---------------------------------------------------
resource "aws_route53_query_log" "route53_query_log" {
    count                           = "${var.enable_route53_query_log}"
    
    cloudwatch_log_group_arn        = "${var.cloudwatch_log_group_arn}"
    zone_id                         = "${var.route53_query_log_zone_id}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }
 
    depends_on  = []
}
