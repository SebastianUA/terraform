#---------------------------------------------------
# Helm release
#---------------------------------------------------
resource "helm_release" "release" {
  count = var.enable_release ? 1 : 0

  name  = var.release_name != "" ? var.release_name : "${lower(var.name)}-release-${lower(var.environment)}"
  chart = var.release_chart

  repository       = var.release_repository
  version          = var.release_version
  namespace        = var.release_namespace
  create_namespace = var.release_create_namespace
  values           = var.release_values

  repository_key_file  = var.release_repository_key_file
  repository_cert_file = var.release_repository_cert_file
  repository_ca_file   = var.release_repository_ca_file
  repository_username  = var.release_repository_username
  repository_password  = var.release_repository_password

  devel                      = var.release_devel
  verify                     = var.release_verify
  keyring                    = var.release_keyring
  timeout                    = var.release_timeout
  disable_webhooks           = var.release_disable_webhooks
  reuse_values               = var.release_reuse_values
  reset_values               = var.release_reset_values
  force_update               = var.release_force_update
  recreate_pods              = var.release_recreate_pods
  cleanup_on_fail            = var.release_cleanup_on_fail
  max_history                = var.release_max_history
  atomic                     = var.release_atomic
  skip_crds                  = var.release_skip_crds
  render_subchart_notes      = var.release_render_subchart_notes
  disable_openapi_validation = var.release_disable_openapi_validation
  wait                       = var.release_wait
  dependency_update          = var.release_dependency_update
  replace                    = var.release_replace
  description                = var.release_description
  lint                       = var.release_lint

  dynamic "set" {
    iterator = set
    for_each = var.release_set

    content {
      name  = lookup(set.value, "name", null)
      value = lookup(set.value, "value", null)
      type  = lookup(set.value, "type", null)
    }
  }

  dynamic "set_sensitive" {
    iterator = set_sensitive
    for_each = var.release_set_sensitive

    content {
      name  = lookup(set_sensitive.value, "name", null)
      value = lookup(set_sensitive.value, "value", null)
      type  = lookup(set_sensitive.value, "type", null)
    }
  }

  // dynamic "set_string" {
  //   iterator = set_string
  //   for_each = var.release_set_string
  //   content {
  //     name  = lookup(set_string.value, "name", null)
  //     value = lookup(set_string.value, "value", null)
  //   }
  // }

  dynamic "postrender" {
    iterator = postrender
    for_each = var.release_postrender

    content {
      binary_path = lookup(postrender.value, "binary_path", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
