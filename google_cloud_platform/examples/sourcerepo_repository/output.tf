output "repository_name" {
    description = "Name of google sourcerepo repository"
    value       = "${module.sourcerepo_repository.google_sourcerepo_repository_name}"
}

output "repository_url" {
    description = "The url to clone the repository."
    value       = "${module.sourcerepo_repository.google_sourcerepo_repository_url}"
}

output "repository_size" {
    description = "The size of the repository."
    value       = "${module.sourcerepo_repository.google_sourcerepo_repository_size}"
}

output "repository_id" {
    description = "ID"                      
    value       = "${module.sourcerepo_repository.google_sourcerepo_repository_id}"
}
