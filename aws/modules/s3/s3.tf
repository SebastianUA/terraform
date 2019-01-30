#---------------------------------------------------
# Create S3 bucket
#---------------------------------------------------
resource "aws_s3_bucket" "s3_bucket_default" {
    count           = "${var.enable_s3_bucket}"
    
    bucket          = "${lower(var.name)}-s3-${lower(var.environment)}"
    region          = "${var.region}"
    
    acl             = "${var.s3_acl}"
    cors_rule       = "${var.cors_rule}"
    policy          = "${length(var.policy) > 0 ? var.policy : "" }"

    website         = "${var.website}"

    versioning {
        enabled = "${var.enable_versioning}"
    }

    lifecycle_rule  {
        enabled     = "${var.enable_lifecycle_rule}"
        id          = "${lower(var.name)}-lifecycle_rule-${lower(var.environment)}"
        prefix      = "${var.lifecycle_rule_prefix}"

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

    force_destroy   = "${var.force_destroy}"

    tags {
        Name            = "${lower(var.name)}-s3-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }
}

resource "aws_s3_bucket" "s3_bucket_website" {
    count           = "${var.enable_s3_bucket_website}"    

    #bucket_prefix = "${var.bucket_prefix}"
    bucket          = "${lower(var.name)}-s3-${lower(var.environment)}"
    region          = "${var.region}"
    
    acl             = "${var.s3_acl}"
    policy          = "${file("${path.module}/policies/${var.s3_acl}-policy.json")}"
    #Add website
    website         = "${var.website}"
    #Add cors rules
    cors_rule       = "${var.cors_rule}"
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
        id          = "${lower(var.name)}-lifecycle_rule-${lower(var.environment)}"
        enabled     = "${var.enable_lifecycle_rule}"
        
        prefix      = "${var.lifecycle_rule_prefix}"
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
        create_before_destroy   = true
        ignore_changes          = []
    }

}

#---------------------------------------------------
# Create S3 bucket policy
#---------------------------------------------------
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
    count       = "${var.enable_s3_bucket_policy}"
                    
    bucket      = "${var.bucket_name == "" && var.enable_s3_bucket ? "${aws_s3_bucket.s3_bucket_default.id}" : var.bucket_name }"
    policy      = "${var.policy}"

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

}

#---------------------------------------------------
# Create S3 bucket
#---------------------------------------------------
resource "aws_s3_bucket_object" "s3_bucket_object" {
    count                   = "${var.enable_s3_bucket_object ? length(var.s3_bucket_object_source) : 0 }" 
                 
    bucket                  = "${var.bucket_name == "" && var.enable_s3_bucket ? "${aws_s3_bucket.s3_bucket_default.id}" : var.bucket_name }"
    #source                  = "${var.s3_bucket_object_source}"
    #key                     = "${var.s3_bucket_object_key}"
    source                  = "${element(var.s3_bucket_object_source, count.index)}" 
    key                     = "${element(var.s3_bucket_object_source, count.index)}"
    #content_type            = "${var.s3_bucket_object_content_type}"
    content_type            = "${lookup(var.mime_types, var.type_of_file)}"
    server_side_encryption  = "${var.s3_bucket_object_server_side_encryption}"

    tags {
        #Name            = "${lower(var.s3_bucket_object_key)}"
        Name            = "${element(var.s3_bucket_object_source, count.index)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }
}

#---------------------------------------------------
# Create S3 bucket inventory
#---------------------------------------------------
#
# https://www.terraform.io/docs/providers/aws/r/s3_bucket_inventory.html
#

#---------------------------------------------------
# Create S3 bucket metric
#---------------------------------------------------
#resource "aws_s3_bucket_metric" "s3_bucket_metric" {
#  https://www.terraform.io/docs/providers/aws/r/s3_bucket_metric.html
#
#    bucket = "${var.bucket_name == "" && var.enable_s3_bucket ? "${aws_s3_bucket.s3_bucket_default.id}" : var.bucket_name }"
#    name   = "ImportantBlueDocuments" 
#    
#    filter {
#        prefix = ""
#    
#        tags = {
#            priority = "high"
#            class    = "blue"
#        }
#    }
#}
#
#---------------------------------------------------
# Create S3 bucket notification
#---------------------------------------------------
resource "aws_s3_bucket_notification" "s3_bucket_notification_sns" {
    count                   = "${var.enable_s3_bucket_notification_sns}"

    bucket                  = "${var.bucket_name == "" && var.enable_s3_bucket ? "${aws_s3_bucket.s3_bucket_default.id}" : var.bucket_name }"
            
    topic {
        topic_arn     = "${var.topic_arn}"
        events        = ["${var.topic_events}"]
        filter_suffix = "${var.topic_filter_suffix}"
        filter_prefix = "${var.topic_filter_prefix}"
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }
}

resource "aws_s3_bucket_notification" "s3_bucket_notification_sqs" {
    count                   = "${var.enable_s3_bucket_notification_sqs}"

    bucket                  = "${var.bucket_name == "" && var.enable_s3_bucket ? "${aws_s3_bucket.s3_bucket_default.id}" : var.bucket_name }"

    queue                   = "${var.queue_configuration}"

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }
}

resource "aws_s3_bucket_notification" "s3_bucket_notification_lambda_function" {
    count                   = "${var.enable_s3_bucket_notification_lambda_function}"

    bucket                  = "${var.bucket_name == "" && var.enable_s3_bucket ? "${aws_s3_bucket.s3_bucket_default.id}" : var.bucket_name }"

    lambda_function         = "${var.lambda_function_configuration}"

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }
}

