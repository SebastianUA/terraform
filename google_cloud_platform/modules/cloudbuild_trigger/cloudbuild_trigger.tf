#---------------------------------------------------
# Create cloudbuild trigger
#---------------------------------------------------
resource "google_cloudbuild_trigger" "cloudbuild_trigger_filename" {
    count       = "${var.enable_cloudbuild_trigger_filename && length(var.filename) >0 ? 1 : 0}"
    
    project     = "${var.project}"
    description = "${var.description}"

    trigger_template {
        branch_name = "${var.trigger_template_branch_name}"
        project     = "${var.trigger_template_project}"
        repo_name   = "${var.trigger_template_repo_name}"
        
        commit_sha  = "${var.trigger_template_commit_sha}"
        dir         = "${var.trigger_template_dir}"
        tag_name    = "${var.trigger_template_tag_name}"
    }

    filename    = "${var.filename}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

resource "google_cloudbuild_trigger" "cloudbuild_trigger" {
    count       = "${!var.enable_cloudbuild_trigger_filename && length(var.trigger_template_branch_name) >0 ? 1 : 0}"
                        
    project     = "${var.project}"
    description = "${var.description}"

    trigger_template {
        branch_name = "${var.trigger_template_branch_name}"
        project     = "${var.trigger_template_project}"
        repo_name   = "${var.trigger_template_repo_name}"

        commit_sha  = "${var.trigger_template_commit_sha}"
        dir         = "${var.trigger_template_dir}"
        tag_name    = "${var.trigger_template_tag_name}"
    }

    build {
        images  = ["${var.build_images}"]
        step {
            name = "${var.build_step_name}"
            args = "${var.build_step_args}"
        }
        tags    = ["${var.build_tags}"]
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

