#-----------------------------------------------------------
# ProofPoint Meta log streaming access bridge
#-----------------------------------------------------------
resource "pfptmeta_log_streaming_access_bridge" "log_streaming_access_bridge" {
  count = var.enable_log_streaming_access_bridge ? 1 : 0

  name        = var.log_streaming_access_bridge_name != "" ? var.log_streaming_access_bridge_name : "${lower(var.name)}-log-streaming-access-bridge-${lower(var.environment)}"
  export_logs = var.log_streaming_access_bridge_export_logs

  description           = var.log_streaming_access_bridge_description
  enabled               = var.log_streaming_access_bridge_enabled
  notification_channels = var.log_streaming_access_bridge_notification_channels

  dynamic "proofpoint_casb_config" {
    iterator = proofpoint_casb_config
    for_each = length(keys(var.log_streaming_access_bridge_proofpoint_casb_config)) > 0 ? [var.log_streaming_access_bridge_proofpoint_casb_config] : []

    content {
      region    = lookup(proofpoint_casb_config.value, "region", null)
      tenant_id = lookup(proofpoint_casb_config.value, "tenant_id", null)
    }
  }

  dynamic "qradar_http_config" {
    iterator = qradar_http_config
    for_each = length(keys(var.log_streaming_access_bridge_qradar_http_config)) > 0 ? [var.log_streaming_access_bridge_qradar_http_config] : []

    content {
      url = lookup(qradar_http_config.value, "url", null)

      certificate = lookup(qradar_http_config.value, "certificate", null)
    }
  }

  dynamic "s3_config" {
    iterator = s3_config
    for_each = length(keys(var.log_streaming_access_bridge_s3_config)) > 0 ? [var.log_streaming_access_bridge_s3_config] : []

    content {
      bucket   = lookup(s3_config.value, "bucket", null)
      compress = lookup(s3_config.value, "compress", null)

      prefix = lookup(s3_config.value, "prefix", null)
    }
  }

  dynamic "splunk_http_config" {
    iterator = splunk_http_config
    for_each = length(keys(var.log_streaming_access_bridge_splunk_http_config)) > 0 ? [var.log_streaming_access_bridge_splunk_http_config] : []

    content {
      token = lookup(splunk_http_config.value, "token", null)
      url   = lookup(splunk_http_config.value, "url", null)

      certificate         = lookup(splunk_http_config.value, "certificate", null)
      publicly_accessible = lookup(splunk_http_config.value, "publicly_accessible", null)
    }
  }

  dynamic "syslog_config" {
    iterator = syslog_config
    for_each = length(keys(var.log_streaming_access_bridge_syslog_config)) > 0 ? [var.log_streaming_access_bridge_syslog_config] : []

    content {
      host  = lookup(syslog_config.value, "host", null)
      port  = lookup(syslog_config.value, "port", null)
      proto = lookup(syslog_config.value, "proto", null)
    }
  }
}
