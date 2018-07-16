#--------------------------------------------------------------------------------
# MySQL
#--------------------------------------------------------------------------------
output "sql_database_instance_mysql_name" {
    description = "Name of sql database instance for MYSQL"
    value       = "${module.sql_database.sql_database_instance_mysql_name}"
}

output "sql_database_instance_mysql_replication_name" {
    description = "Name of sql database instance for MYSQL replica"
    value       = "${module.sql_database.sql_database_instance_mysql_replication_name}"
}

output "sql_database_instance_mysql_self_link" {
    description = "self_link of sql database instance for MYSQL"
    value       = "${module.sql_database.sql_database_instance_mysql_self_link}"
}

output "sql_database_instance_mysql_replication_self_link" {
    description = "self_link of sql database instance for mysql replica"
    value       = "${module.sql_database.sql_database_instance_mysql_replication_self_link}"
}

output "sql_database_instance_mysql_connection_name" {
    description = "connection_name of sql database instance for MYSQL"
    value       = "${module.sql_database.sql_database_instance_mysql_connection_name}"
}

output "sql_database_instance_mysql_replication_connection_name" {
    description = "connection_name of sql database instance for mysql replica"
    value       = "${module.sql_database.sql_database_instance_mysql_replication_connection_name}"
}
#--------------------------------------------------------------------------------
# PostGres
#--------------------------------------------------------------------------------

output "sql_database_instance_postgres_name" {
    description = "Name of sql database instance for postgres"
    value       = "${module.sql_database.sql_database_instance_postgres_name}"
}

output "sql_database_instance_postgres_replication_name" {
    description = "Name of sql database instance for postgres replica"
    value       = "${module.sql_database.sql_database_instance_postgres_replication_name}"
}

output "sql_database_instance_postgres_self_link" {
    description = "self_link of sql database instance for postgres"
    value       = "${module.sql_database.sql_database_instance_postgres_self_link}"
}

output "sql_database_instance_postgres_replication_self_link" {
    description = "self_link of sql database instance for postgres replica"
    value       = "${module.sql_database.sql_database_instance_postgres_replication_self_link}"
}

output "sql_database_instance_postgres_connection_name" {
    description = "connection_name of sql database instance for postgres"
    value       = "${module.sql_database.sql_database_instance_postgres_connection_name}"
}

output "sql_database_instance_postgres_replication_connection_name" {
    description = "connection_nameof sql database instance for postgres replica"
    value       = "${module.sql_database.sql_database_instance_postgres_replication_connection_name}"
}

#--------------------------------------------------------------------------------
# DB
#--------------------------------------------------------------------------------
output "sql_database_name" {
    description = "Name of sql database"
    value       = "${module.sql_database.sql_database_name}"
}

output "sql_database_self_link" {
    description = "self_link for DB"
    value       = "${module.sql_database.sql_database_self_link}"
}

#--------------------------------------------------------------------------------
# User
#--------------------------------------------------------------------------------
output "sql_user_name" {
    description = "User"
    value       = "${module.sql_database.sql_user_name}"
}

