resource "aws_ecs_cluster" "ecs_cluster" {
    count          = var.enable_ecs_cluster ? 1 :0 
        
    name           = var.ecs_cluster_name !="" ? var.ecs_cluster_name : "${lower(var.name)}-ecs-cluster-${lower(var.environment)}"

    dynamic "setting" {
        for_each = var.setting
        content {
            name    = lookup(setting.value, "name", null)
            value   = lookup(setting.value, "value", null)
        }
    }

    tags = merge(
        {
            "Name"          = var.ecs_cluster_name != "" ? var.ecs_cluster_name : "${lower(var.name)}-ecs-cluster-${lower(var.environment)}"
        },
        {
            "Environment"   = var.environment
        },
        {
            "Orchestration" = var.orchestration
        },
        {
            "Createdby"     = var.createdby
        },
        var.tags,
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = []
}