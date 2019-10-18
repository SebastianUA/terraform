resource "aws_ecs_service" "ecs_service" {
    count               = "${var.enable_ecs_service && !var.enable_ecs_service_daemon ? 1 :0 }"
        
    name                = "${var.ecs_service_name !="" ? var.ecs_service_name : "${lower(var.name)}-ecs-service-${lower(var.environment)}" }"
    cluster             = "${var.ecs_cluster_id}"
    task_definition     = "${var.task_definition}"
    desired_count       = "${var.desired_count}"
    iam_role            = "${var.iam_role}"
    
    launch_type         = "${var.launch_type}"
    platform_version    = "${var.platform_version}"
    scheduling_strategy = "${var.scheduling_strategy}"
    #propagate_tags      = "${var.propagate_tags}"

    deployment_controller {
        type    = "${var.deployment_controller_type}"
    }

    load_balancer {
        #elb_name         = "${var.load_balancer_elb_name}"   
        target_group_arn = "${var.load_balancer_target_group_arn}"
        container_name   = "${var.load_balancer_container_name !="" ? var.load_balancer_container_name : "${lower(var.name)}-container-${lower(var.environment)}" }"
        container_port   = "${var.load_balancer_container_port}"
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