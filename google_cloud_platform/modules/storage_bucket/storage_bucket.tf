#---------------------------------------------------
# Create storage bucket 
#---------------------------------------------------
resource "google_storage_bucket" "storage_bucket" {
    count           = "${var.enable_storage_bucket ? 1 : 0}"
    
    name            = "${lower(var.name)}-sb-${lower(var.environment)}"
    project         = "${var.project}"
    location        = "${var.location}"

    storage_class   = "${var.storage_class}"
    force_destroy   = "${var.force_destroy}"
    
    lifecycle_rule {
        action {
            type            = "${var.lifecycle_rule_action_type}"
            storage_class   = "${var.lifecycle_rule_action_type == "SetStorageClass" ? var.lifecycle_rule_action_storage_class : "" }"
        }
        condition {
            age                     = "${var.lifecycle_rule_condition_age}"
            created_before          = "${var.lifecycle_rule_condition_created_before}"
            is_live                 = "${var.lifecycle_rule_condition_is_live}" 
            matches_storage_class   = ["${var.lifecycle_rule_condition_matches_storage_class}"]
            num_newer_versions      = "${var.lifecycle_rule_condition_num_newer_versions}"
        }
    }

    versioning {
        enabled = "${var.versioning_enabled}"
    }

    website {
        main_page_suffix = "${var.website_main_page_suffix}"
        not_found_page   = "${var.website_not_found_page}"
    }

    cors {
        origin          = ["${var.cors_origin}"]
        method          = ["${var.cors_method}"]
        response_header = ["${var.cors_response_header}"]
        max_age_seconds = "${var.cors_max_age_seconds}"
    }

    logging {
        log_bucket          = "${var.logging_log_bucket}"
        log_object_prefix   = "${var.logging_log_object_prefix}"
    }

    labels {
        name            = "${lower(var.name)}-sb-${lower(var.environment)}"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create storage bucket acl
#---------------------------------------------------
resource "google_storage_bucket_acl" "storage_bucket_acl_role_entity" {
    count           = "${var.enable_storage_bucket_acl && length(var.bucket) > 0 && length(var.role_entity) !=0 ? 1 : 0}"    

    bucket          = "${var.bucket}"
    role_entity     = ["${var.role_entity}"]
    default_acl     = "${var.default_acl}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

resource "google_storage_bucket_acl" "storage_bucket_acl_predefined_acl" {
    count           = "${var.enable_storage_bucket_acl && length(var.bucket) > 0 && length(var.predefined_acl) > 0 ? 1 : 0}"

    bucket          = "${var.bucket}"
    predefined_acl  = "${var.predefined_acl}"
    default_acl     = "${var.default_acl}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create storage bucket iam binding
#---------------------------------------------------
resource "google_storage_bucket_iam_binding" "storage_bucket_iam_binding" {
    count       = "${var.enable_storage_bucket_iam_binding ? 1 : 0}"
    
    bucket      = "${var.bucket}"
    role        = "${var.role}"
    
    members = ["${var.members}"]
    
    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create storage bucket iam member
#---------------------------------------------------
resource "google_storage_bucket_iam_member" "storage_bucket_iam_member" {
    count           = "${var.enable_storage_bucket_iam_member ? 1 : 0}"   
            
    bucket          = "${var.bucket}"
    role            = "${var.role}"
    member          = "${element(var.members, 0)}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create iam policy for bucket
#---------------------------------------------------
data "google_iam_policy" "iam_policy" {
    binding {
        role = "${var.role}"
    
        members = ["${var.members}"]
    }
}

resource "google_storage_bucket_iam_policy" "storage_bucket_iam_policy" {
    count       = "${var.enable_storage_bucket_iam_policy ? 1 : 0}"
    
    bucket      = "${var.bucket}"
    policy_data = "${data.google_iam_policy.iam_policy.policy_data}"

    depends_on  = ["data.google_iam_policy.iam_policy"]
    
    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create storage default object acl
#---------------------------------------------------
resource "google_storage_default_object_acl" "storage_default_object_acl" {
    count       = "${var.enable_storage_default_object_acl && length(var.role_entity) > 0 ? 1 : 0}"
    
    bucket      = "${var.bucket}"
    role_entity = ["${var.role_entity}"]

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create storage object acl
#---------------------------------------------------
resource "google_storage_object_acl" "storage_object_acl" {
    count       = "${var.enable_storage_object_acl && length(var.role_entity) > 0 ? 1 : 0}"
            
    bucket      = "${var.bucket}"
    object      = "${var.object}"

    #predefined_acl  = ""
    
    role_entity = ["${var.role_entity}"]

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create storage bucket object
#---------------------------------------------------
resource "google_storage_bucket_object" "storage_bucket_object" {
    count           = "${var.enable_storage_bucket_object && length(var.bucket) >0 && length(var.source_path) >0 ? 1 : 0}"    
    name            = "${lower(var.name)}-sb-obj-${lower(var.environment)}"
    source          = "${var.source_path}"
    bucket          = "${var.bucket}"
            
    cache_control       = "${var.cache_control}"
    content_disposition = "${var.content_disposition}"
    content_encoding    = "${var.content_encoding}"
    content_language    = "${var.content_language}"
    content_type        = "${var.content_type}"
    storage_class       = "${var.storage_class}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create storage notification
#---------------------------------------------------
resource "google_storage_notification" "storage_notification" {
    count               = "${var.enable_storage_notification && var.topic !=""  && var.bucket != "" ? 1 : 0}"
                        
    bucket              = "${var.bucket}"
    payload_format      = "${var.payload_format}"
    topic               = "${var.topic}"
    event_types         = ["${var.event_types}"]
    object_name_prefix  = "${var.object_name_prefix}"    

    custom_attributes {
        name            = "${lower(var.name)}-sb-n-${lower(var.environment)}"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }

}
