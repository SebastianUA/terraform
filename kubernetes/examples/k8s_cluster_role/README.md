# Work with K8S_CLUSTER_ROLE via terraform

A terraform module for making K8S_CLUSTER_ROLE.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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

  cluster_role_rules = [
    {
      verbs      = ["get", "list", "watch"]
      api_groups = [""]
      resources  = ["namespaces", "pods"]
    }
  ]

  cluster_role_aggregation_rules = []

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

  cluster_role_rules = [
    {
      verbs      = ["get", "list", "watch"]
      api_groups = [""]
      resources  = ["namespaces", "pods"]
    }
  ]

  cluster_role_aggregation_rules = [
    {
      match_labels = {
        foo = "bar"
      }

      match_expressions = [
        {
          key      = "environment"
          operator = "In"
          values   = ["non-exists-12345"]
        }
      ]
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

  cluster_role_binding_role_refs = [
    {
      api_group = "rbac.authorization.k8s.io"
      kind      = "ClusterRole"
      name      = module.k8s_cluster_role.cluster_role_id
    }
  ]

  cluster_role_binding_subjects = [
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
```

## Module Input Variables
----------------------
- `name` - The name for helm release resources (`default = test`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_cluster_role` - Enable cluster_role for kubernetes usage (`default = False`)
- `cluster_role_name` - (Optional) Name of the cluster role binding, must be unique. Cannot be updated. For more info see Kubernetes reference (`default = ""`)
- `cluster_role_annotations` - (Optional) An unstructured key value map stored with the cluster role binding that may be used to store arbitrary metadata. (`default = {}`)
- `cluster_role_labels` - (Optional) Map of string keys and values that can be used to organize and categorize (scope and select) the cluster role binding. (`default = {}`)
- `cluster_role_rules` - (Optional) The PolicyRoles for this ClusterRole. For more info see Kubernetes reference (`default = []`)
- `cluster_role_aggregation_rules` - (Optional) Describes how to build the Rules for this ClusterRole. If AggregationRule is set, then the Rules are controller managed and direct changes to Rules will be overwritten by the controller. . For more info see Kubernetes reference (`default = []`)
- `enable_cluster_role_binding` - Enable cluster_role_binding for kubernetes usage (`default = False`)
- `cluster_role_binding_name` - (Optional) Name of the cluster role binding, must be unique. Cannot be updated. For more info see Kubernetes reference (`default = ""`)
- `cluster_role_binding_annotations` - (Optional) An unstructured key value map stored with the cluster role binding that may be used to store arbitrary metadata. (`default = {}`)
- `cluster_role_binding_labels` - (Optional) Map of string keys and values that can be used to organize and categorize (scope and select) the cluster role binding. (`default = {}`)
- `cluster_role_binding_role_refs` - (Required) The ClusterRole to bind Subjects to. For more info see Kubernetes reference (`default = []`)
- `cluster_role_binding_subjects` - (Required) The Users, Groups, or ServiceAccounts to grant permissions to. For more info see Kubernetes reference (`default = []`)

## Module Output Variables
----------------------
- `cluster_role_id` - ID of Kubernetes cluster_role
- `cluster_role_binding_id` - ID of Kubernetes cluster_role_binding


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
