#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"

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
  namespace_name = "k8s-ns"

  namespace_annotations = {
    name = "example-annotation"
  }

  namespace_labels = {
    mylabel = "label-value"
  }

}

module "k8s_namespace_suffix" {
  source = "../../modules/k8s_namespace"

  enable_namespace = true

  # Or, you can use suffix for your NS
  namespace_generate_name = "test-ns-"

  namespace_annotations = {
    name = "example-annotation"
  }

  namespace_labels = {
    mylabel = "label-value"
  }

}

module "k8s_namespace_multiple_names" {
  source = "../../modules/k8s_namespace"

  count = length(["n1", "n2", "k8s-ns"])

  enable_namespace = true

  # Set name for your NS
  namespace_name = count.index

  namespace_annotations = {
    name = "example-annotation"
  }

  namespace_labels = {
    mylabel = "label-value"
  }

}

module "k8s_namespace_multiple_suffixes" {
  source = "../../modules/k8s_namespace"

  count = 4

  enable_namespace = true

  # Or, you can use suffix for your NS
  namespace_generate_name = "test-ns-"

  namespace_annotations = {
    name = "example-annotation"
  }

  namespace_labels = {
    mylabel = "label-value"
  }

}