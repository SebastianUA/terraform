#---------------------------------------------------
# Create google spanner instance
#---------------------------------------------------
resource "google_spanner_instance" "spanner_instance" {
  
    config          = "${var.config}"
    display_name    = "${length(var.display_name) >0 ? var.display_name : "${lower(var.name)}-si-${lower(var.environment)}" }"
    name            = "${lower(var.name)}-si-${lower(var.environment)}"
    num_nodes       = "${var.num_nodes}"
    project         = "${var.project}"

    labels {
        name            = "${lower(var.name)}-si-${lower(var.environment)}"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create google spanner iam
#---------------------------------------------------
data "google_iam_policy" "iam_policy" {
  
    binding {
        role = "${var.role}"
        members = ["${var.members}"]
    }
}

resource "google_spanner_instance_iam_policy" "spanner_instance_iam_policy" {
    count       = "${var.enable_spanner_instance_iam_policy ? 1 : 0}"  

    instance    = "${var.instance}"
    policy_data = "${data.google_iam_policy.iam_policy.policy_data}"
                    
    depends_on  = ["data.google_iam_policy.iam_policy"]

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }

}

resource "google_spanner_instance_iam_binding" "spanner_instance_iam_binding" {
    count       = "${var.enable_spanner_instance_iam_binding ? 1 : 0}"  

    instance    = "${var.instance}"
    role        = "${var.role}"

    members     = ["${var.members}"]
    
    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }

}

resource "google_spanner_instance_iam_member" "spanner_instance_iam_member" {
    count       = "${var.enable_spanner_instance_iam_member ? 1 : 0}"

    instance    = "${var.instance}"
    role        = "${var.role}"
    member      = "${element(var.members, 0)}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create spanner database 
#---------------------------------------------------
resource "google_spanner_database" "spanner_database" {
    count       = "${var.enable_spanner_database ? 1 : 0}"    

    instance    = "${var.instance}"
    name        = "${var.db_name}"
    project     = "${var.project}"
   
    ddl       =  ["${var.ddl}"]

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }

}

#---------------------------------------------------
# Create spanner database iam
#---------------------------------------------------
data "google_iam_policy" "database_iam_policy" {
    binding {
        role = "${var.role}"
    
        members = ["${var.members}"]
    }
}

resource "google_spanner_database_iam_policy" "spanner_database_iam_policy" {
    count           = "${var.enable_spanner_database_iam_policy ? 1 : 0}"

    instance        = "${var.instance}"
    database        = "${var.db_name}"
    policy_data     = "${data.google_iam_policy.database_iam_policy.policy_data}"

    depends_on      = ["data.google_iam_policy.database_iam_policy"]

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

resource "google_spanner_database_iam_binding" "spanner_database_iam_binding" {
    count       = "${var.enable_spanner_database_iam_binding ? 1 : 0}"  

    instance    = "${var.instance}"
    database    = "${var.db_name}"
    role        = "${var.role}"
    
    members     = ["${var.members}"]
    
    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

resource "google_spanner_database_iam_member" "spanner_database_iam_member" {
    count       = "${var.enable_spanner_database_iam_member ? 1 :0}"

    instance    = "${var.instance}"
    database    = "${var.db_name}"
    role        = "${var.role}"
    member      = "${element(var.members, 0)}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
