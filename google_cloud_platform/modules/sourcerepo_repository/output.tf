output "google_sourcerepo_repository_name" {
    description = "Name of google sourcerepo repository"
    value       = "${google_sourcerepo_repository.sourcerepo_repository.name}"
}

output "google_sourcerepo_repository_url" {
    description = "The url to clone the repository."
    value       = "${google_sourcerepo_repository.sourcerepo_repository.url}"
}

output "google_sourcerepo_repository_size" {
    description = "The size of the repository."
    value       = "${google_sourcerepo_repository.sourcerepo_repository.size}"
}

output "google_sourcerepo_repository_id" {
    description = "ID"
    value       = "${google_sourcerepo_repository.sourcerepo_repository.id}"
}

