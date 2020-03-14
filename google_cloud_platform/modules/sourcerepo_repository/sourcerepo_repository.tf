#---------------------------------------------------
# Create sourcerepo repository
#---------------------------------------------------
resource "google_sourcerepo_repository" "sourcerepo_repository" {

    name    = "${lower(var.name)}-sr-repository-${lower(var.environment)}"
    project = "${var.project}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
