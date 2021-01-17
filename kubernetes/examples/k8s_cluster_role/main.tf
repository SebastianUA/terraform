#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"

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

module "k8s_cluster_role" {
  source = "../../modules/k8s_cluster_role"

  enable_cluster_role = true
  cluster_role_name   = "k8s-cluster-role"

  cluster_role_annotations = {
    name = "example-annotation"
  }

  cluster_role_labels = {
    mylabel = "label-value"
  }

  cluster_role_rule = [
    {
      verbs      = ["get", "list", "watch"]
      api_groups = [""]
      resources  = ["namespaces", "pods"]
    }
  ]

  cluster_role_aggregation_rule = []

}

module "k8s_cluster_role_with_aggregation_rule" {
  source = "../../modules/k8s_cluster_role"

  enable_cluster_role = true
  cluster_role_name   = "k8s-cluster-role-with-aggregation-rule"

  cluster_role_annotations = {
    name = "example-annotation"
  }

  cluster_role_labels = {
    mylabel = "label-value"
  }

  cluster_role_rule = [
    {
      verbs      = ["get", "list", "watch"]
      api_groups = [""]
      resources  = ["namespaces", "pods"]
    }
  ]

  cluster_role_aggregation_rule = [
    {
      match_labels = {
        foo = "bar"
      }
      match_expressions_key      = "environment"
      match_expressions_operator = "In"
      match_expressions_values   = ["non-exists-12345"]
    }
  ]

}

module "k8s_cluster_role_binding" {
  source = "../../modules/k8s_cluster_role"

  enable_cluster_role_binding = true
  cluster_role_binding_name   = "k8s-cluster-role-binding"

  cluster_role_binding_annotations = {
    name = "example-annotation"
  }

  cluster_role_binding_labels = {
    mylabel = "label-value"
  }

  cluster_role_binding_role_ref = [
    {
      api_group = "rbac.authorization.k8s.io"
      kind      = "ClusterRole"
      name      = module.k8s_cluster_role.cluster_role_id
    }
  ]

  cluster_role_binding_subject = [
    {
      kind      = "User"
      name      = "admin"
      api_group = "rbac.authorization.k8s.io"
    },
    {
      kind      = "ServiceAccount"
      name      = "default"
      namespace = "kube-system"
    },
    {
      kind      = "Group"
      name      = "system:masters"
      api_group = "rbac.authorization.k8s.io"
    }
  ]

}