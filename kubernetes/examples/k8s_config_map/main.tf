#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.15"

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

module "k8s_config_map" {
  source = "../../modules/k8s_config_map"

  enable_config_map    = true
  config_map_name      = "my-test-cm"
  config_map_namespace = module.k8s_namespace.namespace_id

  config_map_annotations = {
    name = "example-annotation"
  }

  config_map_labels = {
    mylabel = "label-value"
  }

  data = {
    ssh-privatekey = filebase64("./additional_files/rsa-key")
    ssh-publickey  = filebase64("./additional_files/rsa-key.pub")
  }

  binary_data = {}

}

module "k8s_config_map_suffix" {
  source = "../../modules/k8s_config_map"

  enable_config_map        = true
  config_map_generate_name = "test-cm-"
  config_map_namespace     = "default"

  config_map_annotations = {
    name = "example-annotation"
  }

  config_map_labels = {
    mylabel = "label-value"
  }

  data = {
    api_host = "myhost:443"
    db_host  = "dbhost:5432"
  }

  binary_data = {}

}

