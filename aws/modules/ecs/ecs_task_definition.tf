resource "aws_ecs_task_definition" "ecs_task_definition" {
    count                   = "${var.enable_ecs_task_definition && !var.enable_appmesh_proxy ? 1 :0 }"
        
    family                  = "${var.family !="" ? var.family : "${lower(var.name)}-service-${lower(var.environment)}" }"
    #container_definitions   = "${file("${var.container_definitions}")}"
    container_definitions   = "${var.container_definitions}"
    
    task_role_arn           = "${var.task_role_arn}"
    execution_role_arn      = "${var.execution_role_arn}"
    network_mode            = "${var.network_mode}"
    ipc_mode                = "${var.ipc_mode}"
    pid_mode                = "${var.pid_mode}"

    volume {
        name      = "${var.volume_name !="" ? var.volume_name : "${lower(var.name)}-volume-${lower(var.environment)}" }"
        host_path = "${var.volume_host_path}"
    }
    #docker_volume_configuration {
    #    scope           = "${var.docker_volume_configuration_scope}"
    #    autoprovision   = "${var.docker_volume_configuration_autoprovision}"
    #    driver          = ""
    #    driver_opts     = []
    #    labels          = []
    #}

    placement_constraints {
        type       = "${var.task_definition_placement_constraints_type}"
        expression = "${var.task_definition_placement_constraints_expression}"
    }

    tags {
        Name                = "${var.family !="" ? var.family : "${lower(var.name)}-service-${lower(var.environment)}" }"
        Environment         = "${var.environment}"
        Region              = "${var.region}"    
        Orchestration       = "${var.orchestration}"
        Createdby           = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = []
}

resource "aws_ecs_task_definition" "ecs_task_definition_appmesh_proxy" {
    count                   = "${var.enable_ecs_task_definition && var.enable_appmesh_proxy ? 1 :0 }"

    family                  = "${var.family}"
    container_definitions   = "${file("${var.container_definitions}")}"

    proxy_configuration {
        type           = "${var.proxy_configuration_type}"
        container_name = "${var.proxy_configuration_container_name !="" ? var.proxy_configuration_container_name : "${lower(var.name)}-container-${lower(var.environment)}" }"
        properties = {
            AppPorts         = "${var.proxy_configuration_properties_appports}"
            EgressIgnoredIPs = "${var.proxy_configuration_properties_egressignoredips}"
            IgnoredUID       = "${var.proxy_configuration_properties_ignoreduid}"
            ProxyEgressPort  = "${var.proxy_configuration_properties_proxyegressport}"
            ProxyIngressPort = "${var.proxy_configuration_properties_proxyingressport}"
        }
    }

    tags {
        Name                = "${var.volume_name !="" ? var.volume_name : "${lower(var.name)}-volume-${lower(var.environment)}" }"
        Environment         = "${var.environment}"
        Region              = "${var.region}"    
        Orchestration       = "${var.orchestration}"
        Createdby           = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = []
}
