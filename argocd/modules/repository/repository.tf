#---------------------------------------------------
# ArgoCD repository
#---------------------------------------------------
resource "argocd_repository" "repository" {
  count = var.enable_repository ? 1 : 0

  repo = var.repository_repo

  name = var.repository_name != "" ? var.repository_name : "${var.name}-${var.environment}-repo"
  type = var.repository_type

  insecure   = var.repository_insecure
  enable_lfs = var.repository_enable_lfs

  username = var.repository_username
  password = var.repository_password

  ssh_private_key      = var.repository_ssh_private_key
  tls_client_cert_data = var.repository_tls_client_cert_data
  tls_client_cert_key  = var.repository_tls_client_cert_key


  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
