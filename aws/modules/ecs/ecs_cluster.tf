resource "aws_ecs_cluster" "ecs_cluster" {
    count          = "${var.enable_ecs_cluster ? 1 :0 }"
        
    name           = "${var.ecs_cluster_name !="" ? var.ecs_cluster_name : "${lower(var.name)}-ecs-cluster-${lower(var.environment)}" }"

    setting        = ["${var.setting}"] 

    tags {
        Name            = "${var.alb_name !="" ? var.alb_name : "${lower(var.name)}-alb-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Region          = "${var.region}"    
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy = true
    }

    depends_on = []
}
