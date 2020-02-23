#---------------------------------------------------
# Using depends_on
#---------------------------------------------------
resource "null_resource" "depends_on" {
    count   = var.enable_depends_on ? 1 : 0

    triggers = {
        depends_on = join("", var.depends_on_var)
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = []
}
