# Work with K8S_NAMESPACE via terraform

A terraform module for making K8S_NAMESPACE.


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
```

## Module Input Variables
----------------------
- `name` - The name for helm release resources (`default = test`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_namespace` - Enable ns for kubernetes usage (`default = False`)
- `namespace_name` - (Optional) Name of the namespace, must be unique. Cannot be updated. For more info see Kubernetes reference (`default = ""`)
- `namespace_generate_name` - (Optional) Prefix, used by the server, to generate a unique name ONLY IF the name field has not been provided. This value will also be combined with a unique suffix. Read more about name idempotency. (`default = null`)
- `namespace_annotations` - (Optional) An unstructured key value map stored with the namespace that may be used to store arbitrary metadata. (`default = {}`)
- `namespace_labels` - (Optional) Map of string keys and values that can be used to organize and categorize (scope and select) namespaces. May match selectors of replication controllers and services. (`default = {}`)
- `timeouts` - kubernetes_namespace provides the following Timeouts configuration (`default = {}`)

## Module Output Variables
----------------------
- `namespace_id` - ID of Kubernetes namespace


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
