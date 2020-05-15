#---------------------------------------------------
# AWS datapipeline pipeline
#---------------------------------------------------
resource "aws_datapipeline_pipeline" "datapipeline_pipeline" {
    count               = var.enable_datapipeline_pipeline ? 1 : 0

    name                = var.datapipeline_pipeline_name != "" ? lower(var.datapipeline_pipeline_name) : "${lower(var.name)}-datapipeline-pipeline-${lower(var.environment)}"

    description         = var.datapipeline_pipeline_description

    tags                = merge(
        {
            "Name"  = var.datapipeline_pipeline_name != "" ? lower(var.datapipeline_pipeline_name) : "${lower(var.name)}-datapipeline-pipeline-${lower(var.environment)}"
        },
        var.tags,
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = []
}
