# Work with K8S_CONFIG_MAP via terraform

A terraform module for making K8S_CONFIG_MAP.


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


```

## Module Input Variables
----------------------
- `name` - The name for helm release resources (`default = test`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_config_map` - Enable cm for kubernetes usage (`default = False`)
- `config_map_name` - (Optional) Name of the namespace, must be unique. Cannot be updated. For more info see Kubernetes reference (`default = ""`)
- `config_map_generate_name` - (Optional) Prefix, used by the server, to generate a unique name ONLY IF the name field has not been provided. This value will also be combined with a unique suffix. Read more about name idempotency. (`default = null`)
- `config_map_annotations` - (Optional) An unstructured key value map stored with the namespace that may be used to store arbitrary metadata. (`default = {}`)
- `config_map_labels` - (Optional) Map of string keys and values that can be used to organize and categorize (scope and select) namespaces. May match selectors of replication controllers and services. (`default = {}`)
- `config_map_namespace` - (Optional) Namespace defines the space within which name of the config map must be unique. (`default = null`)
- `data` - (Optional) Data contains the configuration data. Each key must consist of alphanumeric characters, '-', '_' or '.'. Values with non-UTF-8 byte sequences must use the BinaryData field. The keys stored in Data must not overlap with the keys in the BinaryData field, this is enforced during validation process. (`default = null`)
- `binary_data` - (Optional) BinaryData contains the binary data. Each key must consist of alphanumeric characters, '-', '_' or '.'. BinaryData can contain byte sequences that are not in the UTF-8 range. The keys stored in BinaryData must not overlap with the ones in the Data field, this is enforced during validation process. Using this field will require 1.10+ apiserver and kubelet. This field only accepts base64-encoded payloads that will be decoded/received before being sent/received to the apiserver. (`default = null`)

## Module Output Variables
----------------------
- `config_map_id` - ID of Kubernetes config_map


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
