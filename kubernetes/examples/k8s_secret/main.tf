#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.13.3"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 1.3.2"
    }
  }
}

module "k8s_namespace" {
  source = "../../modules/k8s_namespace"

  enable_namespace = true

  # Set name for your NS
  namespace_name = "k8s-namespace"

  namespace_annotations = {
    name = "example-annotation"
  }

  namespace_labels = {
    mylabel = "label-value"
  }

}

module "k8s_secret" {
  source = "../../modules/k8s_secret"

  enable_secret    = true
  secret_name      = "github-ssh-key"
  secret_namespace = module.k8s_namespace.namespace_id

  secret_annotations = {
    name = "example-annotation"
  }

  secret_labels = {
    mylabel = "label-value"
  }

  secret_type = "Opaque"
  // secret_type = "kubernetes.io/dockerconfigjson"
  // secret_type = "kubernetes.io/basic-auth"
  secret_data = {
    ssh-privatekey = filebase64("./additional_files/rsa-key")
    ssh-publickey  = filebase64("./additional_files/rsa-key.pub")
  }

}