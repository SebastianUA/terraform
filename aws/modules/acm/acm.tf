#---------------------------------------------------
# Create AWS ACM (Amazon Certificate Manager) certificate
#---------------------------------------------------
resource "aws_acm_certificate" "acm_certificate" {
    count                       = "${var.acm_certificate && !var.import_existing_certificate ? 1 : 0}"

    domain_name                 = "${var.domain_name !="" ? var.domain_name : "${lower(var.name)}-acm-cert-${lower(var.environment)}" }"
    validation_method           = "${upper(var.validation_method)}"
                        
    subject_alternative_names   = "${var.subject_alternative_names}"

    tags = {
        Name            = "${var.domain_name !="" ? var.domain_name : "${lower(var.name)}-acm-cert-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy = true
    }

    depends_on = []
}

resource "aws_acm_certificate" "acm_certificate_exist" {
    count                       = "${var.acm_certificate && var.import_existing_certificate ? 1 : 0}"

    domain_name                 = "${var.domain_name !="" ? var.domain_name : "${lower(var.name)}-acm-cert-${lower(var.environment)}" }"
    validation_method           = "DNS"

    subject_alternative_names   = "${var.subject_alternative_names}"
    
    private_key                 = "${var.private_key}"
    certificate_body            = "${var.certificate_body}"
    certificate_chain           = "${var.certificate_chain}"

    tags = {
        Name            = "${var.domain_name !="" ? var.domain_name : "${lower(var.name)}-acm-cert-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy = true
    }

    depends_on = []
}

#---------------------------------------------------
# Create AWS ACM (Amazon Certificate Manager) certificate validation
#--------------------------------------------------- 
resource "aws_acm_certificate_validation" "acm_certificate_validation" {
    count                       = "${length(var.validation_record_fqdns) ==0 && var.acm_certificate_validation ? 1 : 0}"
                                                                   
    certificate_arn             = "${var.certificate_arn}"
    
    timeouts {
        create  = "${var.timeouts_create}"
    }

    lifecycle {
        create_before_destroy = true
    }

    depends_on = []
}

resource "aws_acm_certificate_validation" "acm_certificate_validation_with_validation_record_fqdns" {
    count                       = "${length(var.validation_record_fqdns) >0 && var.acm_certificate_validation ? 1 : 0}"
                                    
    certificate_arn             = "${var.certificate_arn}"
    validation_record_fqdns     = "${var.validation_record_fqdns}"

    timeouts {
        create  = "${var.timeouts_create}"
    }

    lifecycle {
        create_before_destroy = true
    }

    depends_on = []
}
