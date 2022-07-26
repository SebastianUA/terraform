# Work with K8S_ROLE via terraform

A terraform module for making K8S_ROLE.


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
```

## Module Input Variables
----------------------
- `name` - The name for helm release resources (`default = test`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_role` - Enable role for kubernetes usage (`default = False`)
- `role_name` - (Optional) Name of the cluster role binding, must be unique. Cannot be updated. For more info see Kubernetes reference (`default = ""`)
- `role_generate_name` - (Optional) Prefix, used by the server, to generate a unique name ONLY IF the name field has not been provided. This value will also be combined with a unique suffix. For more info see Kubernetes reference (`default = null`)
- `role_annotations` - (Optional) An unstructured key value map stored with the cluster role binding that may be used to store arbitrary metadata. (`default = {}`)
- `role_labels` - (Optional) Map of string keys and values that can be used to organize and categorize (scope and select) the cluster role binding. (`default = {}`)
- `role_rules` - (Optional) The PolicyRoles for this ClusterRole. For more info see Kubernetes reference (`default = []`)
- `role_namespace` - (Optional) Namespace defines the space within which name of the role must be unique. (`default = null`)
- `enable_role_binding` - Enable role_binding for kubernetes usage (`default = False`)
- `role_binding_name` - (Optional) Name of the cluster role binding, must be unique. Cannot be updated. For more info see Kubernetes reference (`default = ""`)
- `role_binding_namespace` - (Optional) Namespace defines the space within which name of the role binding must be unique. (`default = null`)
- `role_binding_annotations` - (Optional) An unstructured key value map stored with the cluster role binding that may be used to store arbitrary metadata. (`default = {}`)
- `role_binding_labels` - (Optional) Map of string keys and values that can be used to organize and categorize (scope and select) the cluster role binding. (`default = {}`)
- `role_binding_role_refs` - (Required) The ClusterRole to bind Subjects to. For more info see Kubernetes reference (`default = []`)
- `role_binding_subjects` - (Required) The Users, Groups, or ServiceAccounts to grant permissions to. For more info see Kubernetes reference (`default = []`)

## Module Output Variables
----------------------
- `role_id` - ID of Kubernetes role
- `role_binding_id` - ID of Kubernetes role_binding


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
