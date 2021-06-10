#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

module "helm_release" {
  source = "../../modules/release"

  enable_release     = true
  release_name       = "argocd-dev"
  release_chart      = "argo-cd"
  release_repository = "https://argoproj.github.io/argo-helm"
  release_version    = "v1.7.6"

  release_namespace        = "argocd-dev"
  release_create_namespace = true
  release_values           = []

  release_set = [
    #  {
    #    name  = "global.image.repository"
    #    value = "argoproj/argocd"
    #  },
    #  {
    #    name  = "global.image.repository"
    #    value = "v1.7.10"
    #  },
    {
      name  = "server.service.type"
      value = "LoadBalancer"
    }
  ]
  release_set_sensitive = []
  release_postrender    = []

  release_timeout       = 600
  release_force_update  = false
  release_recreate_pods = true
  release_lint          = false

}
