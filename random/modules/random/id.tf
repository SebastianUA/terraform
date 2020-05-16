#---------------------------------------------------
# Create random id
#---------------------------------------------------
resource "random_id" "id" {
    count               = var.enable_id ? 1 : 0

    byte_length         = var.id_byte_length
    keepers             = var.id_keepers
    prefix              = var.id_prefix

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = []
}
