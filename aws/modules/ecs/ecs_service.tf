resource "aws_ecs_service" "ecs_service" {
    count                               = "${var.enable_ecs_service && !var.enable_ecs_service_daemon ? 1 :0 }"
                         
    name                                = "${var.ecs_service_name !="" ? var.ecs_service_name : "${lower(var.name)}-ecs-service-${lower(var.environment)}" }"
    cluster                             = "${var.ecs_cluster_id}"
    task_definition                     = "${var.task_definition}"
    desired_count                       = "${var.desired_count}"
    iam_role                            = "${var.iam_role}"
    
    launch_type                         = "${var.launch_type}"
    platform_version                    = "${var.platform_version}"
    scheduling_strategy                 = "${var.scheduling_strategy}"
    
    #propagate_tags                      = "${var.propagate_tags}"
    #deployment_maximum_percent          = "${var.deployment_maximum_percent}"
    #deployment_minimum_healthy_percent  = "${var.deployment_minimum_healthy_percent}"
    #enable_ecs_managed_tags             = "${var.enable_ecs_managed_tags}"
    #health_check_grace_period_seconds   = "${var.health_check_grace_period_seconds}"
    
  
    deployment_controller {
        type    = "${var.deployment_controller_type}"
    }

    network_configuration {
        subnets             = ["${var.network_configuration_subnets}"]
        security_groups     = ["${var.network_configuration_security_groups}"]
        assign_public_ip    = "${var.network_configuration_assign_public_ip}"
    }

    load_balancer {
        #elb_name         = "${var.load_balancer_elb_name}"   
        target_group_arn = "${var.load_balancer_target_group_arn}"
        container_name   = "${var.load_balancer_container_name !="" ? var.load_balancer_container_name : "${lower(var.name)}-lb-container-${lower(var.environment)}" }"
        container_port   = "${var.load_balancer_container_port}"
    }

    service_registries {
        registry_arn    = "${var.service_registries_registry_arn}"
        port            = "${var.service_registries_port}"
        container_port  = "${var.service_registries_container_port}"
        container_name  = "${var.service_registries_container_name !="" ? var.service_registries_container_name : "${lower(var.name)}-sr-container-${lower(var.environment)}" }"
    }

    ordered_placement_strategy {
        type  = "${var.ordered_placement_strategy_type}"
        field = "${var.ordered_placement_strategy_field}"
    }

    placement_constraints {
        type       = "${var.placement_constraints_type}"
        expression = "${var.placement_constraints_expression}"
    }

    tags {
        Name            = "${var.ecs_service_name !="" ? var.ecs_service_name : "${lower(var.name)}-ecs-service-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Region          = "${var.region}"    
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true
        # Optional: Allow external changes without Terraform plan difference
        #ignore_changes          = ["desired_count"]
        ignore_changes          = []
    }

    depends_on = []
}


resource "aws_ecs_service" "ecs_service_daemon" {
    count               = "${var.enable_ecs_service && var.enable_ecs_service_daemon ? 1 :0 }"

    name                = "${var.ecs_service_name !="" ? var.ecs_service_name : "${lower(var.name)}-ecs-service-${lower(var.environment)}" }"
    cluster            = "${var.ecs_cluster_id}"
    task_definition     = "${var.task_definition}"
    scheduling_strategy = "DAEMON"

    launch_type         = "${var.launch_type}"
    platform_version    = "${var.platform_version}"
    scheduling_strategy = "${var.scheduling_strategy}"

    tags {
        Name            = "${var.ecs_service_name !="" ? var.ecs_service_name : "${lower(var.name)}-ecs-service-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Region          = "${var.region}"    
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = []
}
