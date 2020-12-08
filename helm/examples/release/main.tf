#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}

module "helm_release" {
  source = "../../modules/release"

  enable_release     = true
  release_name       = "redis-dev"
  release_chart      = "redis"
  release_repository = "https://kubernetes-charts.storage.googleapis.com"
  release_version    = "6.0.1"

  release_namespace        = "redis-dev"
  release_create_namespace = true
  release_values           = []

  release_set = [
    {
      name  = "cluster.enabled"
      value = "true"
    },
    {
      name  = "metrics.enabled"
      value = "true"
    },
    {
      name  = "service.annotations.prometheus\\.io/port"
      value = "9127"
    }
  ]
  release_set_sensitive = []
  release_postrender    = []

  release_timeout       = 300
  release_force_update  = false
  release_recreate_pods = false
  release_lint          = false

}
