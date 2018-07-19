#---------------------------------------------------
# Create google bigquery dataset
#---------------------------------------------------
resource "random_integer" "dataset" {
    count   = "${var.enable_bigquery_dataset ? 1 : 0}" 
                    
    min     = 10
    max     = 1024
    keepers = {
        dataset_id = "${var.dataset_id}"
    }
}

resource "google_bigquery_dataset" "bigquery_dataset" {
    count                       = "${var.enable_bigquery_dataset ? 1 : 0}"
    
    dataset_id                  = "${length(var.dataset_id) >0 ? var.dataset_id : "${random_integer.dataset.result}" }"
    friendly_name               = "${length(var.friendly_name) >0 ? var.friendly_name : "${lower(var.name)}-bq-dataset-${lower(var.environment)}" }"
    description                 = "${var.description}"
    project                     = "${var.project}"
    location                    = "${var.location}"
    default_table_expiration_ms = "${var.default_table_expiration_ms}"
    
    labels {
        name            = "${lower(var.name)}-bq-dataset-${lower(var.environment)}"
        dataset_id      = "${length(var.dataset_id) >0 ? var.dataset_id : "${random_integer.dataset.result}" }"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }

    lifecycle {
        ignore_changes = ["dataset_id"]
        create_before_destroy = true
    }

    depends_on  = ["random_integer.dataset"] 
}

#---------------------------------------------------
# Create google bigquery table
#---------------------------------------------------
resource "random_integer" "table" {
    count   = "${var.enable_bigquery_table ? 1 : 0}"

    min     = 10
    max     = 1024
    keepers = {
        table_id = "${var.table_id}"
    }
}

resource "google_bigquery_table" "bigquery_table" {
    count           = "${var.enable_bigquery_table ? 1 : 0}"
    
    project         = "${var.project}"
    dataset_id      = "${var.dataset_id}"
    table_id        = "${length(var.table_id) >0 ? var.table_id : "${random_integer.table.result}" }"
    description     = "${var.table_description}"    
    
    expiration_time = "${var.expiration_time}"
    friendly_name   = "${length(var.table_friendly_name) >0 ? var.table_friendly_name : "${lower(var.name)}-bq-table-${lower(var.environment)}" }"
    
    time_partitioning {
        type            = "${var.time_partitioning_type}"
        expiration_ms   = "${var.time_partitioning_expiration_ms}"
        field           = "${var.time_partitioning_field}"
    } 

    #view {
    #    query           = "${var.view_query}"
    #    use_legacy_sql  = "${var.view_use_legacy_sql}"
    #}

    labels {
        name            = "${length(var.table_friendly_name) >0 ? var.table_friendly_name : "${lower(var.name)}-bq-table-${lower(var.environment)}" }"
        table_id        = "${length(var.table_id) >0 ? var.table_id : "${random_integer.table.result}" }"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }

    schema = "${file("${path.module}/${var.schema_file}")}"

    lifecycle {
        ignore_changes = ["dataset_id"]
        create_before_destroy = true
    }

    depends_on  = ["random_integer.table"]
}

resource "random_integer" "table_view" {
    count   = "${var.enable_bigquery_table_view ? 1 : 0}"

    min     = 10
    max     = 1024
    keepers = {
        table_id = "${var.table_id}"
    }
}

resource "google_bigquery_table" "bigquery_table_view" {
    count           = "${var.enable_bigquery_table_view ? 1 : 0}"

    project         = "${var.project}"
    dataset_id      = "${var.dataset_id}"
    table_id        = "${length(var.table_id) >0 ? var.table_id : "${random_integer.table_view.result}" }"
    description     = "${var.table_description}"

    expiration_time = "${var.expiration_time}"
    friendly_name   = "${length(var.table_friendly_name) >0 ? var.table_friendly_name : "${lower(var.name)}-bq-table-${lower(var.environment)}" }"

    time_partitioning {
        type            = "${var.time_partitioning_type}"
        expiration_ms   = "${var.time_partitioning_expiration_ms}"
        field           = "${var.time_partitioning_field}"
    }

    view {
        query           = "${var.view_query}"
        use_legacy_sql  = "${var.view_use_legacy_sql}"
    }

    labels {
        name            = "${length(var.table_friendly_name) >0 ? var.table_friendly_name : "${lower(var.name)}-bq-table-${lower(var.environment)}" }"
        table_id        = "${length(var.table_id) >0 ? var.table_id : "${random_integer.table_view.result}" }"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }

    schema = "${file("${path.module}/${var.schema_file}")}"

    lifecycle {
        ignore_changes = ["dataset_id"]
        create_before_destroy = true
    }

    depends_on  = ["random_integer.table_view"]
}

