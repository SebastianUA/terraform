# Work with K8S_SECRET via terraform

A terraform module for making K8S_SECRET.


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
```

## Module Input Variables
----------------------
- `name` - The name for helm release resources (`default = test`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_secret` - Enable ns for kubernetes usage (`default = False`)
- `secret_name` - (Optional) Name of the secret, must be unique. Cannot be updated. For more info see Kubernetes reference (`default = ""`)
- `secret_generate_name` - (Optional) Prefix, used by the server, to generate a unique name ONLY IF the name field has not been provided. This value will also be combined with a unique suffix. For more info see Kubernetes reference (`default = null`)
- `secret_annotations` - (Optional) An unstructured key value map stored with the secret that may be used to store arbitrary metadata. (`default = {}`)
- `secret_labels` - (Optional) Map of string keys and values that can be used to organize and categorize (scope and select) secrets. May match selectors of replication controllers and services. (`default = {}`)
- `secret_namespace` - (Optional) Namespace defines the space within which name of the secret must be unique. (`default = null`)
- `secret_data` - (Optional) A map of the secret data. (`default = null`)
- `secret_type` - (Optional) The secret type. Defaults to Opaque. For more info see Kubernetes reference (`default = Opaque`)

## Module Output Variables
----------------------
- `secret_id` - ID of Kubernetes secret


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
