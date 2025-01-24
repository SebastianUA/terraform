#-----------------------------------------------------------
# mount target
#-----------------------------------------------------------
resource "oci_file_storage_mount_target" "file_storage_mount_target" {
  count = var.enable_file_storage_mount_target ? 1 : 0

  # Required
  availability_domain = var.file_storage_mount_target_availability_domain
  compartment_id      = var.file_storage_mount_target_compartment_id
  subnet_id           = var.file_storage_mount_target_subnet_id

  # Optional
  display_name         = var.file_storage_mount_target_display_name != "" ? var.file_storage_mount_target_display_name : "${lower(var.name)}-nfs-mount-target-${lower(var.environment)}"
  hostname_label       = var.file_storage_mount_target_hostname_label
  idmap_type           = var.file_storage_mount_target_idmap_type
  ip_address           = var.file_storage_mount_target_ip_address
  is_lock_override     = var.file_storage_mount_target_is_lock_override
  nsg_ids              = var.file_storage_mount_target_nsg_ids
  requested_throughput = var.file_storage_mount_target_requested_throughput

  dynamic "kerberos" {
    iterator = kerberos
    for_each = length(keys(var.file_storage_mount_target_kerberos)) > 0 ? [var.file_storage_mount_target_kerberos] : []

    content {
      # Required
      kerberos_realm = lookup(kerberos.value, "kerberos_realm", null)

      # Optional
      backup_key_tab_secret_version  = lookup(kerberos.value, "backup_key_tab_secret_version", null)
      current_key_tab_secret_version = lookup(kerberos.value, "current_key_tab_secret_version", null)
      is_kerberos_enabled            = lookup(kerberos.value, "is_kerberos_enabled", null)
      key_tab_secret_id              = lookup(kerberos.value, "key_tab_secret_id", null)
    }
  }

  dynamic "ldap_idmap" {
    iterator = ldap_idmap
    for_each = length(keys(var.file_storage_mount_target_ldap_idmap)) > 0 ? [var.file_storage_mount_target_ldap_idmap] : []

    content {
      # Optional
      cache_lifetime_seconds          = lookup(ldap_idmap.value, "cache_lifetime_seconds", null)
      cache_refresh_interval_seconds  = lookup(ldap_idmap.value, "cache_refresh_interval_seconds", null)
      group_search_base               = lookup(ldap_idmap.value, "group_search_base", null)
      negative_cache_lifetime_seconds = lookup(ldap_idmap.value, "negative_cache_lifetime_seconds", null)
      outbound_connector1id           = lookup(ldap_idmap.value, "outbound_connector1id", null)
      outbound_connector2id           = lookup(ldap_idmap.value, "outbound_connector2id", null)
      schema_type                     = lookup(ldap_idmap.value, "schema_type", null)
      user_search_base                = lookup(ldap_idmap.value, "user_search_base", null)
    }
  }

  dynamic "locks" {
    iterator = locks
    for_each = var.file_storage_mount_target_locks

    content {
      # Required
      type = lookup(locks.value, "type", null)

      # Optional
      message             = lookup(locks.value, "message", null)
      related_resource_id = lookup(locks.value, "related_resource_id", null)
      time_created        = lookup(locks.value, "time_created", null)
    }
  }

  defined_tags = var.file_storage_mount_target_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.file_storage_mount_target_display_name != "" ? var.file_storage_mount_target_display_name : "${lower(var.name)}-nfs-mount-target-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.file_storage_mount_target_timeouts)) > 0 ? [var.file_storage_mount_target_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}