#---------------------------------------------------
# AWS codestarconnections connection
#---------------------------------------------------
resource "aws_codestarconnections_connection" "codestarconnections_connection" {
  count = var.enable_codestarconnections_connection ? 1 : 0

  name          = var.codestarconnections_connection_name != "" ? lower(var.codestarconnections_connection_name) : "${lower(var.name)}-codestarconnections-connection-${lower(var.environment)}"
  provider_type = var.codestarconnections_connection_provider_type

  tags = merge(
    {
      Name = var.codestarconnections_connection_name != "" ? lower(var.codestarconnections_connection_name) : "${lower(var.name)}-codestarconnections-connection-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}