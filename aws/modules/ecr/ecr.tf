#---------------------------------------------------
# Create AWS ECR repository
#---------------------------------------------------
resource "aws_ecr_repository" "ecr_repository" {
    count               = "${var.enable_ecr_repository ? 1 : 0}"
                                             
    name                = "${var.ecr_repository_name == "" ? "${lower(var.name)}-ecr-${lower(var.environment)}" : "${var.ecr_repository_name}" }"

    tags {
        Name            = "${var.ecr_repository_name == "" ? "${lower(var.name)}-ecr-${lower(var.environment)}" : "${var.ecr_repository_name}" }"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    timeouts {
        delete  = "${var.timeouts_delete}"
    }

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}

#---------------------------------------------------
# Create AWS ECR repository policy
#---------------------------------------------------
resource "aws_ecr_repository_policy" "ecr_repository_policy" {
    count       = "${var.enable_ecr_repository_policy ? 1 : 0}"
                
    repository  = "${var.repository == "" && var.enable_ecr_repository ? "${aws_ecr_repository.ecr_repository.name}" : "${var.repository}" }"
    
    policy = "${data.template_file.policy.rendered}"
            
    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = ["data.template_file.policy"]
}

data "template_file" "policy" {
    template    = "${file("${var.policy_json_file}")}"
}

#---------------------------------------------------
# Create AWS ECR repository 
#---------------------------------------------------
resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
    count       = "${var.enable_ecr_lifecycle_policy ? 1 : 0}"
    
    repository  = "${var.repository == "" && var.enable_ecr_repository ? "${aws_ecr_repository.ecr_repository.name}" : "${var.repository}" }"
    
    policy      = "${data.template_file.lifecycle_policy.rendered}"

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = ["data.template_file.lifecycle_policy"]
}

data "template_file" "lifecycle_policy" {
    template    = "${file("${var.lifecycle_policy_json_file}")}"
}
