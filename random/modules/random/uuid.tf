#---------------------------------------------------
# Create random uuid
#---------------------------------------------------
resource "random_uuid" "uuid" {
    count       = var.enable_uuid ? 1 : 0

    keepers     = var.uuid_keepers

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = []
}
