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

module "k8s_role" {
  source = "../../modules/k8s_role"

  enable_role = true
  role_name   = "test-role"

  role_annotations = {
    name = "example-annotation"
  }

  role_labels = {
    test = "MyRole"
  }

  role_namespace = null

  role_rules = [
    {
      api_groups     = [""]
      resources      = ["pods"]
      resource_names = ["foo"]
      verbs          = ["get", "list", "watch"]
    },
    {
      api_groups = ["apps"]
      resources  = ["deployments"]
      verbs      = ["get", "list"]
    }
  ]
}


module "k8s_role_binding" {
  source = "../../modules/k8s_role"

  enable_role_binding = true
  role_binding_name   = "test-rb"

  role_binding_annotations = {
    name = "example-annotation"
  }

  role_binding_labels = {
    test = "MyRole"
  }

  role_binding_namespace = null

  role_binding_role_refs = [
    {
      api_group = "rbac.authorization.k8s.io"
      kind      = "Role"
      name      = "test-role"
    }
  ]

  role_binding_subjects = [
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

  depends_on = [
    module.k8s_role
  ]
}