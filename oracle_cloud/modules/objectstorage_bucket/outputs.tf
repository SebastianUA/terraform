#-----------------------------------------------------------
# objectstorage bucket
#-----------------------------------------------------------
output "objectstorage_bucket_id" {
  description = "The OCID of the bucket which is a Oracle assigned unique identifier for this resource type (bucket). bucket_id cannot be used for bucket lookup."
  value       = element(concat(oci_objectstorage_bucket.objectstorage_bucket.*.bucket_id, [""]), 0)
}

output "objectstorage_bucket_access_type" {
  description = "The type of public access enabled on this bucket. A bucket is set to NoPublicAccess by default, which only allows an authenticated caller to access the bucket and its contents. When ObjectRead is enabled on the bucket, public access is allowed for the GetObject, HeadObject, and ListObjects operations. When ObjectReadWithoutList is enabled on the bucket, public access is allowed for the GetObject and HeadObject operations."
  value       = element(concat(oci_objectstorage_bucket.objectstorage_bucket.*.access_type, [""]), 0)
}

output "objectstorage_bucket_compartment_id" {
  description = "The compartment ID in which the bucket is authorized."
  value       = element(concat(oci_objectstorage_bucket.objectstorage_bucket.*.compartment_id, [""]), 0)
}

output "objectstorage_bucket_created_by" {
  description = "The OCID of the user who created the bucket."
  value       = element(concat(oci_objectstorage_bucket.objectstorage_bucket.*.created_by, [""]), 0)
}

output "objectstorage_bucket_is_read_only" {
  description = "Whether or not this bucket is read only. By default, isReadOnly is set to false. This will be set to 'true' when this bucket is configured as a destination in a replication policy."
  value       = element(concat(oci_objectstorage_bucket.objectstorage_bucket.*.is_read_only, [""]), 0)
}

output "objectstorage_bucket_name" {
  description = "The name of the bucket. Avoid entering confidential information. Example: my-new-bucket1"
  value       = element(concat(oci_objectstorage_bucket.objectstorage_bucket.*.name, [""]), 0)
}

output "objectstorage_bucket_namespace" {
  description = "The Object Storage namespace in which the bucket resides."
  value       = element(concat(oci_objectstorage_bucket.objectstorage_bucket.*.namespace, [""]), 0)
}

output "objectstorage_bucket_versioning" {
  description = "The versioning status on the bucket. A bucket is created with versioning Disabled by default. For versioning Enabled, objects are protected from overwrites and deletes, by maintaining their version history. When versioning is Suspended, the previous versions will still remain but new versions will no longer be created when overwitten or deleted."
  value       = element(concat(oci_objectstorage_bucket.objectstorage_bucket.*.versioning, [""]), 0)
}

output "objectstorage_bucket_storage_tier" {
  description = "The storage tier type assigned to the bucket. A bucket is set to Standard tier by default, which means objects uploaded or copied to the bucket will be in the standard storage tier. When the Archive tier type is set explicitly for a bucket, objects uploaded or copied to the bucket will be stored in archive storage. The storageTier property is immutable after bucket is created."
  value       = element(concat(oci_objectstorage_bucket.objectstorage_bucket.*.storage_tier, [""]), 0)
}

output "objectstorage_bucket_replication_enabled" {
  description = "Whether or not this bucket is a replication source. By default, replicationEnabled is set to false. This will be set to 'true' when you create a replication policy for the bucket."
  value       = element(concat(oci_objectstorage_bucket.objectstorage_bucket.*.replication_enabled, [""]), 0)
}

#-----------------------------------------------------------
# objectstorage object lifecycle policy
#-----------------------------------------------------------
output "objectstorage_object_lifecycle_policy_rules" {
  description = "TBD"
  value       = concat(oci_objectstorage_object_lifecycle_policy.objectstorage_object_lifecycle_policy.*.rules, [""])
}

#-----------------------------------------------------------
# objectstorage object
#-----------------------------------------------------------
output "objectstorage_object_bucket" {
  description = "The name of the bucket. Avoid entering confidential information. Example: my-new-bucket1"
  value       = element(concat(oci_objectstorage_object.objectstorage_object.*.bucket, [""]), 0)
}

output "objectstorage_object_namespace" {
  description = "The top-level namespace used for the request."
  value       = element(concat(oci_objectstorage_object.objectstorage_object.*.namespace, [""]), 0)
}

output "objectstorage_object_object" {
  description = "The name of the object. Avoid entering confidential information. Example: test/object1.log"
  value       = element(concat(oci_objectstorage_object.objectstorage_object.*.object, [""]), 0)
}

#-----------------------------------------------------------
# objectstorage preauthrequest
#-----------------------------------------------------------
output "objectstorage_preauthrequest_id" {
  description = "The unique identifier to use when directly addressing the pre-authenticated request."
  value       = element(concat(oci_objectstorage_preauthrequest.objectstorage_preauthrequest.*.id, [""]), 0)
}

output "objectstorage_preauthrequest_bucket" {
  description = "The name of the bucket. Example: my-new-bucket1"
  value       = element(concat(oci_objectstorage_preauthrequest.objectstorage_preauthrequest.*.bucket, [""]), 0)
}

output "objectstorage_preauthrequest_name" {
  description = "The user-provided name of the pre-authenticated request."
  value       = element(concat(oci_objectstorage_preauthrequest.objectstorage_preauthrequest.*.name, [""]), 0)
}

output "objectstorage_preauthrequest_namespace" {
  description = "The top-level namespace used for the request."
  value       = element(concat(oci_objectstorage_preauthrequest.objectstorage_preauthrequest.*.namespace, [""]), 0)
}

output "objectstorage_preauthrequest_access_type" {
  description = "The operation that can be performed on this resource."
  value       = element(concat(oci_objectstorage_preauthrequest.objectstorage_preauthrequest.*.access_type, [""]), 0)
}

output "objectstorage_preauthrequest_bucket_listing_action" {
  description = "Specifies whether a list operation is allowed on a PAR with accessType 'AnyObjectRead' or 'AnyObjectReadWrite'. Deny: Prevents the user from performing a list operation. ListObjects: Authorizes the user to perform a list operation."
  value       = element(concat(oci_objectstorage_preauthrequest.objectstorage_preauthrequest.*.bucket_listing_action, [""]), 0)
}

output "objectstorage_preauthrequest_full_path" {
  description = "The full Path for the object."
  value       = element(concat(oci_objectstorage_preauthrequest.objectstorage_preauthrequest.*.full_path, [""]), 0)
}

output "objectstorage_preauthrequest_access_uri" {
  description = "The URI to embed in the URL https://objectstorage.${var.region}.oraclecloud.com{var.access_uri} when using the pre-authenticated request."
  value       = element(concat(oci_objectstorage_preauthrequest.objectstorage_preauthrequest.*.access_uri, [""]), 0)
}

output "objectstorage_preauthrequest_object" {
  description = "The name of the object that is being granted access to by the pre-authenticated request. Avoid entering confidential information. The object name can be null and if so, the pre-authenticated request grants access to the entire bucket. Example: test/object1.log"
  value       = element(concat(oci_objectstorage_preauthrequest.objectstorage_preauthrequest.*.object, [""]), 0)
}

output "objectstorage_preauthrequest_par_id" {
  description = "The unique identifier for the pre-authenticated request. This can be used to manage operations against the pre-authenticated request, such as GET or DELETE."
  value       = element(concat(oci_objectstorage_preauthrequest.objectstorage_preauthrequest.*.par_id, [""]), 0)
}

output "objectstorage_preauthrequest_time_created" {
  description = "The date when the pre-authenticated request was created as per specification RFC 3339."
  value       = element(concat(oci_objectstorage_preauthrequest.objectstorage_preauthrequest.*.time_created, [""]), 0)
}

output "objectstorage_preauthrequest_time_expires" {
  description = "The expiration date for the pre-authenticated request as per RFC 3339. After this date the pre-authenticated request will no longer be valid."
  value       = element(concat(oci_objectstorage_preauthrequest.objectstorage_preauthrequest.*.time_expires, [""]), 0)
}

#-----------------------------------------------------------
# replication policy
#-----------------------------------------------------------
output "objectstorage_replication_policy_destination_bucket_name" {
  description = "The bucket to replicate to in the destination region. Replication policy creation does not automatically create a destination bucket. Create the destination bucket before creating the policy."
  value       = element(concat(oci_objectstorage_replication_policy.objectstorage_replication_policy.*.destination_bucket_name, [""]), 0)
}

output "objectstorage_replication_policy_destination_region_name" {
  description = "The destination region to replicate to, for example 'us-ashburn-1'."
  value       = element(concat(oci_objectstorage_replication_policy.objectstorage_replication_policy.*.destination_region_name, [""]), 0)
}

output "objectstorage_replication_policy_id" {
  description = "The id of the replication policy."
  value       = element(concat(oci_objectstorage_replication_policy.objectstorage_replication_policy.*.id, [""]), 0)
}

output "objectstorage_replication_policy_name" {
  description = "The name of the policy."
  value       = element(concat(oci_objectstorage_replication_policy.objectstorage_replication_policy.*.name, [""]), 0)
}

output "objectstorage_replication_policy_status" {
  description = "The replication status of the policy. If the status is CLIENT_ERROR, once the user fixes the issue described in the status message, the status will become ACTIVE."
  value       = element(concat(oci_objectstorage_replication_policy.objectstorage_replication_policy.*.status, [""]), 0)
}

output "objectstorage_replication_policy_status_message" {
  description = "A human-readable description of the status."
  value       = element(concat(oci_objectstorage_replication_policy.objectstorage_replication_policy.*.status_message, [""]), 0)
}

output "objectstorage_replication_policy_time_created" {
  description = "The date when the replication policy was created as per RFC 3339."
  value       = element(concat(oci_objectstorage_replication_policy.objectstorage_replication_policy.*.time_created, [""]), 0)
}

output "objectstorage_replication_policy_time_last_sync" {
  description = "Changes made to the source bucket before this time has been replicated."
  value       = element(concat(oci_objectstorage_replication_policy.objectstorage_replication_policy.*.time_last_sync, [""]), 0)
}
