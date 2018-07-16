#--------------------------------------------------------------------------------
# MySQL
#--------------------------------------------------------------------------------
output "sql_database_instance_mysql_name" {
    description = "Name of sql database instance for MYSQL"
    value       = "${google_sql_database_instance.sql_database_instance_mysql.*.name}"
}

output "sql_database_instance_mysql_replication_name" {
    description = "Name of sql database instance for MYSQL replica"
    value       = "${google_sql_database_instance.sql_database_instance_mysql_replication.*.name}"
}

output "sql_database_instance_mysql_self_link" {
    description = "self_link of sql database instance for MYSQL"
    value       = "${google_sql_database_instance.sql_database_instance_mysql.*.self_link}"
}

output "sql_database_instance_mysql_replication_self_link" {
    description = "self_link of sql database instance for mysql replica"
    value       = "${google_sql_database_instance.sql_database_instance_mysql_replication.*.self_link}"
}

output "sql_database_instance_mysql_connection_name" {
    description = "connection_name of sql database instance for MYSQL"
    value       = "${google_sql_database_instance.sql_database_instance_mysql.*.connection_name}"
}

output "sql_database_instance_mysql_replication_connection_name" {
    description = "connection_name of sql database instance for mysql replica"
    value       = "${google_sql_database_instance.sql_database_instance_mysql_replication.*.connection_name}"
}
#--------------------------------------------------------------------------------
# PostGres
#--------------------------------------------------------------------------------

output "sql_database_instance_postgres_name" {
    description = "Name of sql database instance for postgres"
    value       = "${google_sql_database_instance.sql_database_instance_postgres.*.name}"
}

output "sql_database_instance_postgres_replication_name" {
    description = "Name of sql database instance for postgres replica"
    value       = "${google_sql_database_instance.sql_database_instance_postgres_replication.*.name}"
}

output "sql_database_instance_postgres_self_link" {
    description = "self_link of sql database instance for postgres"
    value       = "${google_sql_database_instance.sql_database_instance_postgres.*.self_link}"
}

output "sql_database_instance_postgres_replication_self_link" {
    description = "self_link of sql database instance for postgres replica"
    value       = "${google_sql_database_instance.sql_database_instance_postgres_replication.*.self_link}"
}

output "sql_database_instance_postgres_connection_name" {
    description = "connection_name of sql database instance for postgres"
    value       = "${google_sql_database_instance.sql_database_instance_postgres.*.connection_name}"
}       

output "sql_database_instance_postgres_replication_connection_name" {
    description = "connection_nameof sql database instance for postgres replica"
    value       = "${google_sql_database_instance.sql_database_instance_postgres_replication.*.connection_name}"
}

#--------------------------------------------------------------------------------
# DB
#--------------------------------------------------------------------------------
output "sql_database_name" {
    description = "Name of sql database"
    value       = "${google_sql_database.sql_database.*.name}"
}

output "sql_database_self_link" {
    description = "self_link for DB"
    value       = "${google_sql_database.sql_database.*.self_link}"
}

#--------------------------------------------------------------------------------
# User
#--------------------------------------------------------------------------------
output "sql_user_name" {
    description = "User"
    value       = "${google_sql_user.sql_user.*.name}"
}

