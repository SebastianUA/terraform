#---------------------------------------------------
# Create bigtable instance
#---------------------------------------------------
resource "google_bigtable_instance" "bigtable_instance" {
    count           = "${var.enable_bigtable_instance ? 1 :0}"

    name            = "${lower(var.name)}-bt-instance-${lower(var.environment)}"
    display_name    = "${var.display_name}"
    cluster_id      = "${length(var.cluster_id) >0 ? var.cluster_id : "${lower(var.name)}-bt-instance-${lower(var.environment)}" }"
    project         = "${var.project}"
    zone            = "${var.zone}"
    num_nodes       = "${var.num_nodes}"
    instance_type   = "${var.instance_type}"
    storage_type    = "${var.storage_type}"
    
    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
#Create bigtable table
#---------------------------------------------------
resource "google_bigtable_table" "bigtable_table" {
    count           = "${var.enable_bigtable_table ? 1 : 0}"
    
    name            = "${length(var.table_name) >0 ? var.table_name : "${lower(var.name)}-bt-table-${lower(var.environment)}" }"
    project         = "${var.project}"
    instance_name   = "${var.instance_name}"
    split_keys      = ["${var.split_keys}"]

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
