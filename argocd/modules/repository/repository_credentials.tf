#---------------------------------------------------
# ArgoCD repository credentials
#---------------------------------------------------
resource "argocd_repository_credentials" "repository_credentials" {
  count = var.enable_repository_credentials ? 1 : 0

  url = var.repository_credentials_url

  username        = var.repository_credentials_username
  password        = var.repository_credentials_password
  ssh_private_key = var.repository_credentials_ssh_private_key

  tls_client_cert_data = var.repository_credentials_tls_client_cert_data
  tls_client_cert_key  = var.repository_credentials_tls_client_cert_key

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
