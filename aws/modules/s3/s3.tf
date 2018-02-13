#---------------------------------------------------
# Create S3 bucket
#---------------------------------------------------
resource "aws_s3_bucket" "s3_bucket" {
    #bucket_prefix = "${var.bucket_prefix}"
    bucket = "${lower(var.name)}-s3-${lower(var.environment)}"
    region = "${var.region}"
    
    acl    = "${var.s3_acl}"
    policy = "${file("${path.module}/policies/${var.s3_acl}-policy.json")}"
    #Add website
    website     = "${var.website}"
    #Add cors rules
    cors_rule   = "${var.cors_rule}"
    #Add logging
    logging {
        target_bucket = "${lower(var.name)}-s3-${lower(var.environment)}"
        target_prefix = "/log"
    }    
    #Add versioning    
    versioning {
        enabled = "${var.enable_versioning}"
    }
    #Add lifecycle rule
    lifecycle_rule  {
        id      = "${lower(var.name)}-lifecycle_rule-${lower(var.environment)}"
        enabled = "${var.enable_lifecycle_rule}"
        
        prefix = "${var.lifecycle_rule_prefix}"
        tags {
            Name            = "${lower(var.name)}-lc_rule-${lower(var.environment)}"
            Environment     = "${var.environment}"
            Orchestration   = "${var.orchestration}"
            Createdby       = "${var.createdby}"
        }

        noncurrent_version_expiration {
            days = "${var.noncurrent_version_expiration_days}"
        }
        
        noncurrent_version_transition {
            days          = "${var.noncurrent_version_transition_days}"
            storage_class = "GLACIER"
        }
        
        transition {
            days          = "${var.standard_transition_days}"
            storage_class = "STANDARD_IA"
        }
    
        transition {
            days          = "${var.glacier_transition_days}"
            storage_class = "GLACIER"
        }
        
        expiration {
            days = "${var.expiration_days}"
        }
    }
    #Add server side encryption configuration
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                kms_master_key_id = "${var.kms_master_key_id}"
                sse_algorithm     = "aws:kms"
            }
        }
    }    

    force_destroy   = "${var.force_destroy}"
    
    tags {
        Name            = "${lower(var.name)}-s3-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
    lifecycle {
        create_before_destroy = true
    }

}
