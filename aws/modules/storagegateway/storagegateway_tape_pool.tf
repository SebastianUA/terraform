#---------------------------------------------------
# AWS storagegateway tape pool
#---------------------------------------------------
resource "aws_storagegateway_tape_pool" "storagegateway_tape_pool" {
  count = var.enable_storagegateway_tape_pool ? 1 : 0

  pool_name           = var.storagegateway_tape_pool_name != "" ? lower(var.storagegateway_tape_pool_name) : "${lower(var.name)}-storagegateway-tape-pool-${lower(var.environment)}"
  storage_class       = var.storagegateway_tape_pool_storage_class
  retention_lock_type = var.storagegateway_tape_pool_retention_lock_type

  retention_lock_time_in_days = var.storagegateway_tape_pool_retention_lock_time_in_days

  tags = merge(
    {
      Name = var.storagegateway_tape_pool_name != "" ? lower(var.storagegateway_tape_pool_name) : "${lower(var.name)}-storagegateway-tape-pool-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}