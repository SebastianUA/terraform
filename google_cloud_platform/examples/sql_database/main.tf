#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "google" {
    credentials = "${file("/Users/captain/.config/gcloud/creds/terraform_creds.json")}"
    project     = "terraform-2018"
    region      = "us-east1"
}   
module "sql_database" {
    source                              = "../../modules/sql_database"
    name                                = "TEST"

    #MySQL without replication
    enable_replication                  = false
    database_version                    = "MYSQL_5_6"
    settings_database_flags             = [
        {    
            name    = "skip_show_database"
            value   = "on"
        }
    ]
    #settings_maintenance_window         = []
    #
    #MySQL with replication
    #enable_replication                  = true
    #database_version                    = "MYSQL_5_6"    
    #settings_database_flags             = [
    #    {
    #        name    = "skip_show_database"
    #        value   = "on"
    #    }
    #]
    #settings_maintenance_window         = []
    #
    # Postgres without replication
    #enable_replication                  = false
    #database_version                    = "POSTGRES_9_6"
    #settings_database_flags             = []
    #settings_maintenance_window         = [
    #    {
    #        day             = "6"
    #        hour            = "23"
    #        update_track    = ""
    #    }
    #]
    # Postgres with replication
    #enable_replication                  = true
    #database_version                    = "POSTGRES_9_6"
    #settings_database_flags             = []
    #settings_maintenance_window         = [
    #    {
    #        day             = "6"
    #        hour            = "23"
    #        update_track    = ""
    #    }
    #]

    # DB
    sql_database_instance_name           = "test-sd-instance-stage-1"
    enable_sql_database_creating         = true
    enable_sql_user_creating             = true
    
}

