#---------------------------------------------------
# Generate random value
#---------------------------------------------------
resource "random_id" "id" {
    count           = "${var.billing_account != "" &&  var.org_id != "" || var.org_id != "" && var.enable_specific_folder ? 1 : 0}"
    
    byte_length     = 4
    prefix          = "${var.name}-"
}

#---------------------------------------------------
# Create google project
#---------------------------------------------------
resource "google_project" "project" {
    count           = "${var.billing_account != "" &&  var.org_id != "" ? 1 : 0}"
    
    name            = "${var.name}"
    project_id      = "${var.project_id == "" ? random_id.id.hex : var.project_id}"
    billing_account = "${var.billing_account}"
    org_id          = "${var.org_id}"
                    
    skip_delete         = "${var.skip_delete}"
    auto_create_network = "${var.auto_create_network}"
    
    labels {
        Name            = "${var.name}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    depends_on  = ["random_id.id"]
}

#---------------------------------------------------
# Create a project under a specific folder
#---------------------------------------------------
resource "google_project" "specific_project" {
    count           = "${var.org_id != "" && var.enable_specific_folder ? 1 : 0}"
    
    name            = "${var.name}"
    #project_id      = "${random_id.id.hex}"
    project_id      = "${var.project_id == "" ? random_id.id.hex : var.project_id}"
    folder_id       = "${google_folder.specific_folder.name}"

    skip_delete         = "${var.skip_delete}"
    auto_create_network = "${var.auto_create_network}"
    
    labels {
        Name            = "${var.name}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    depends_on  = ["google_folder.specific_folder"]
}
#---------------------------------------------------
# Create a folder under your organization
#---------------------------------------------------
resource "google_folder" "specific_folder" {
    count           = "${var.org_id != "" && var.enable_specific_folder ? 1 : 0}"
    
    display_name    = "${var.name}"
    parent          = "organizations/${var.org_id}"
}

#---------------------------------------------------
# Add google project services
#---------------------------------------------------
resource "google_project_services" "project_services" {
    count       = "${length(var.google_project_services) > 0 && var.billing_account != "" &&  var.org_id != "" || length(var.google_project_services) > 0 && var.org_id != "" && var.enable_specific_folder ? 1 : 0}"
                    
    project     = "${var.project_id == "" ? random_id.id.hex : var.project_id}"
    services    = ["${var.google_project_services}"]

    disable_on_destroy  = "${var.disable_on_destroy}"
}

#---------------------------------------------------
# Add google organization iam policy
#---------------------------------------------------
resource "google_organization_iam_policy" "organization_iam_policy" {
    count           = "${var.org_id != "" && var.enable_organization_iam_policy ? 1 : 0}"
    
    org_id          = "${var.org_id}"
    policy_data     = "${data.google_iam_policy.iam_policy.policy_data}"
}

data "google_iam_policy" "iam_policy" {
    count           = "${var.org_id != "" && var.enable_organization_iam_policy ? 1 : 0}"

    binding {
        role = "roles/editor"

        members = [
            "user:jane@example.com",
        ]
    }
}
# https://www.terraform.io/docs/providers/google/r/google_organization_iam_policy.html

#---------------------------------------------------
# Add google organization iam member
#---------------------------------------------------
resource "google_organization_iam_member" "organization_iam_member" {
    count           = "${var.org_id != "" && var.enable_organization_iam_member ? 1 : 0}"


    org_id          = "${var.org_id}"
    role            = "roles/editor"
    member          = "user:jane@example.com"
}       
# https://www.terraform.io/docs/providers/google/r/google_organization_iam_member.html


#---------------------------------------------------
# Add google organization iam custom role 
#---------------------------------------------------
resource "google_organization_iam_custom_role" "organization_iam_custom_role" {
    count           = "${var.org_id != "" && var.enable_organization_iam_custom_role ? 1 : 0}"
                    
    role_id         = "myCustomRole"
    org_id          = "${var.org_id}"
    title           = "My Custom Role"
    description     = "A description"
    permissions     = ["iam.roles.list", "iam.roles.create", "iam.roles.delete"]
}
# https://www.terraform.io/docs/providers/google/r/google_organization_iam_custom_role.html

#---------------------------------------------------
# Add google organization iam binding
#---------------------------------------------------
resource "google_organization_iam_binding" "binding" {
    count           = "${var.org_id != "" && var.enable_organization_iam_binding ? 1 : 0}"  
            
    org_id          = "${var.org_id}"
    role            = "roles/browser"

    members = [
        "user:jane@example.com",
    ]
}
# https://www.terraform.io/docs/providers/google/r/google_organization_iam_binding.html

#---------------------------------------------------
# Add google folder iam binding
#---------------------------------------------------

# https://www.terraform.io/docs/providers/google/r/google_folder_iam_binding.html

#---------------------------------------------------
# IAM policy for projects
#---------------------------------------------------

# https://www.terraform.io/docs/providers/google/r/google_project_iam.html

#---------------------------------------------------
# google_project_organization_policy
#---------------------------------------------------

# https://www.terraform.io/docs/providers/google/r/google_project_organization_policy.html

