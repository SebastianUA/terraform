#---------------------------------------------------
# Create AWS elastic beanstalk application
#---------------------------------------------------
resource "aws_elastic_beanstalk_application" "elastic_beanstalk_application" {
    count                   = "${var.enable_elastic_beanstalk_application ? 1 : 0}"
                        
    name                    = "${lower(var.name)}-eb-${lower(var.environment)}"
    description             = "Elactic beanstalk application for ${lower(var.name)}-eb-${lower(var.environment)}"
                
    appversion_lifecycle    = "${var.appversion_lifecycle}"
    # doesn't support in my module... 
    #appversion_lifecycle {
    #    service_role          = "${var.appversion_lifecycle_service_role}"
    #    max_count             = "${var.appversion_lifecycle_max_count}"
    #    max_age_in_days       = "${var.appversion_lifecycle_max_age_in_days}"  
    #    delete_source_from_s3 = "${var.appversion_lifecycle_delete_source_from_s3}"
    #}

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }
    
    depends_on  = []
}

#---------------------------------------------------
# Create AWS elastic beanstalk environment
#---------------------------------------------------
resource "aws_elastic_beanstalk_environment" "elastic_beanstalk_environment" {
    count                       = "${var.enable_elastic_beanstalk_environment && var.solution_stack_name != "" && var.template_name == "" ? 1 : 0}"

    name                        = "${lower(var.name)}-eb-app-${lower(var.environment)}"
    description                 = "Elactic beanstalk environment for ${lower(var.name)}-eb-app-${lower(var.environment)}"
    application                 = "${length(var.application_name) == 0 ? aws_elastic_beanstalk_application.elastic_beanstalk_application.name : var.application_name}"
    
    solution_stack_name         = "${var.solution_stack_name}"
    #cname_prefix                = "${lower(var.cname_prefix)}"
    # The cname_prefix can not be set for Worker tier
    cname_prefix                = "${length(var.cname_prefix) == 0 && var.tier == "WebServer" ? "${lower(var.name)}-${lower(var.environment)}" : lower(var.cname_prefix) }"
    tier                        = "${var.tier}"

    setting                     = ["${var.setting}"]
    #all_settings                = ["${var.all_settings}"]
    #platform_arn                = "${var.platform_arn}"
    wait_for_ready_timeout      = "${var.wait_for_ready_timeout}"
    poll_interval               = "${var.poll_interval}"
    version_label               = "${var.version_label}"

    tags {
        Name            = "${var.name}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = ["tags"]
    }

    depends_on  = []

}

resource "aws_elastic_beanstalk_environment" "elastic_beanstalk_environment_with_template_name" {
    count                       = "${var.enable_elastic_beanstalk_environment && var.solution_stack_name == "" && var.template_name != "" ? 1 : 0}"

    name                        = "${lower(var.name)}-eb-app-${lower(var.environment)}"
    description                 = "Elactic beanstalk environment for ${lower(var.name)}-eb-app-${lower(var.environment)}"
    application                 = "${length(var.application_name) == 0 ? aws_elastic_beanstalk_application.elastic_beanstalk_application.name : var.application_name}"

    template_name               = "${var.template_name}"
    cname_prefix                = "${length(var.cname_prefix) == 0 ? "${lower(var.name)}-${lower(var.environment)}" : lower(var.cname_prefix) }"
    tier                        = "${var.tier}"

    setting                     = ["${var.setting}"]
    #all_settings                = ["${var.all_settings}"]
    #platform_arn                = "${var.platform_arn}"
    wait_for_ready_timeout      = "${var.wait_for_ready_timeout}"
    poll_interval               = "${var.poll_interval}"
    version_label               = "${var.version_label}"

    tags {
        Name            = "${var.name}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = ["tags"]
    }

    depends_on  = ["aws_elastic_beanstalk_application_version.elastic_beanstalk_application_version"]

}
 
#---------------------------------------------------
# Create AWS elastic beanstalk configuration template
#---------------------------------------------------
resource "aws_elastic_beanstalk_configuration_template" "elastic_beanstalk_configuration_template" {
    count               = "${var.enable_elastic_beanstalk_configuration_template}"

    name                = "${length(var.configuration_template_name) == 0 ? "${lower(var.name)}-conf-template-${lower(var.environment)}" : lower(var.configuration_template_name) }"
    description         = "Elactic beanstalk config-template for some ENV"
    
    environment_id      = "${var.environment_id}"
    application         = "${length(var.application_name) == 0 ? aws_elastic_beanstalk_application.elastic_beanstalk_application.name : var.application_name}"
    solution_stack_name = "${var.solution_stack_name}"
    setting             = ["${var.setting}"]    
                            
    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}

#---------------------------------------------------
# Create AWS elastic beanstalk application version
#---------------------------------------------------
resource "aws_elastic_beanstalk_application_version" "elastic_beanstalk_application_version" {
    count           = "${var.enable_elastic_beanstalk_application_version ? 1 : 0 }"
    #count           = "${var.enable_elastic_beanstalk_application_version ? length(concat(var.keys)) : 0 }"
    
    name            = "${lower(var.name)}-eb-app-ver-${lower(var.environment)}"
    #name            = "${lower(var.name)}-eb-app-ver-${lower(var.environment)}-${count.index+1}"
    application     = "${var.beanstalk_application_name == "" ? "${aws_elastic_beanstalk_application.elastic_beanstalk_application.id}" : var.beanstalk_application_name }"
    description     = "EB App version for ${lower(var.name)}-eb-app-ver-${lower(var.environment)}-${count.index+1}"
    bucket          = "${var.bucket}"
    key             = "${var.key}"

    #key             = "${element(concat(coalescelist(var.keys), list("")), 0)}"
    #key             = "${element(var.keys, count.index)}"
    
    force_delete    = "${var.force_delete}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}

