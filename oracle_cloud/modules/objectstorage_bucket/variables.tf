#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for resources"
  default     = "test"
}

variable "environment" {
  description = "The environment for resources"
  default     = "dev"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# objectstorage bucket
#-----------------------------------------------------------
variable "enable_objectstorage_bucket" {
  description = "Enable objectstorage bucket uses"
  default     = false
}

variable "objectstorage_bucket_name" {
  description = "The name of the bucket. Valid characters are uppercase or lowercase letters, numbers, hyphens, underscores, and periods. Bucket names must be unique within an Object Storage namespace. Avoid entering confidential information. example: Example: my-new-bucket1"
  default     = ""
}

variable "objectstorage_bucket_namespace" {
  description = "(Required) The Object Storage namespace used for the request."
  default     = null
}

variable "objectstorage_bucket_compartment_id" {
  description = "(Required) (Updatable) The ID of the compartment in which to create the bucket."
  default     = ""
}

variable "objectstorage_bucket_access_type" {
  description = "(Optional) (Updatable) The type of public access enabled on this bucket. A bucket is set to NoPublicAccess by default, which only allows an authenticated caller to access the bucket and its contents. When ObjectRead is enabled on the bucket, public access is allowed for the GetObject, HeadObject, and ListObjects operations. When ObjectReadWithoutList is enabled on the bucket, public access is allowed for the GetObject and HeadObject operations."
  default     = null
}

variable "objectstorage_bucket_auto_tiering" {
  description = "(Optional) (Updatable) Set the auto tiering status on the bucket. By default, a bucket is created with auto tiering Disabled. Use this option to enable auto tiering during bucket creation. Objects in a bucket with auto tiering set to InfrequentAccess are transitioned automatically between the 'Standard' and 'InfrequentAccess' tiers based on the access pattern of the objects."
  default     = null
}

variable "objectstorage_bucket_kms_key_id" {
  description = "(Optional) (Updatable) The OCID of a master encryption key used to call the Key Management service to generate a data encryption key or to encrypt or decrypt a data encryption key."
  default     = null
}

variable "objectstorage_bucket_metadata" {
  description = "(Optional) (Updatable) Arbitrary string, up to 4KB, of keys and values for user-defined metadata."
  default     = null
}

variable "objectstorage_bucket_object_events_enabled" {
  description = "(Optional) (Updatable) Whether or not events are emitted for object state changes in this bucket. By default, objectEventsEnabled is set to false. Set objectEventsEnabled to true to emit events for object state changes. For more information about events, see Overview of Events."
  default     = null
}

variable "objectstorage_bucket_storage_tier" {
  description = "(Optional) The type of storage tier of this bucket. A bucket is set to 'Standard' tier by default, which means the bucket will be put in the standard storage tier. When 'Archive' tier type is set explicitly, the bucket is put in the Archive Storage tier. The 'storageTier' property is immutable after bucket is created."
  default     = null
}

variable "objectstorage_bucket_versioning" {
  description = "(Optional) (Updatable) Set the versioning status on the bucket. By default, a bucket is created with versioning Disabled. Use this option to enable versioning during bucket creation. Objects in a version enabled bucket are protected from overwrites and deletions. Previous versions of the same object will be available in the bucket. Allowed Create values: Enabled, Disabled. Allowed Update values: Enabled, Suspended."
  default     = null
}

variable "objectstorage_bucket_defined_tags" {
  description = "(Optional) (Updatable) Defined-formtags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'}"
  default     = {}
}

variable "objectstorage_bucket_retention_rules" {
  description = "(Optional) (Updatable) Creates a new retention rule in the specified bucket. The new rule will take effect typically within 30 seconds. Note that a maximum of 100 rules are supported on a bucket."

  type = list(object({
    # Define the structure of each retention rule here.
    # For example:
    days   = number
    action = string
    # Add other relevant fields as per your retention rule requirements.
  }))

  default = []

  validation {
    condition     = length(var.objectstorage_bucket_retention_rules) <= 100
    error_message = "A maximum of 100 retention rules are supported on a bucket. Please reduce the number of retention rules to 100 or fewer."
  }
}

variable "objectstorage_bucket_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Bucket * update - (Defaults to 20 minutes), when updating the Bucket * delete - (Defaults to 20 minutes), when destroying the Bucket"
  default     = {}
}

#-----------------------------------------------------------
# objectstorage object lifecycle policy
#-----------------------------------------------------------
variable "enable_objectstorage_object_lifecycle_policy" {
  description = "Enable objectstorage object lifecycle policy usages"
  default     = false
}

variable "objectstorage_object_lifecycle_policy_bucket" {
  description = "(Required) The name of the bucket. Avoid entering confidential information. Example: my-new-bucket1"
  default     = ""
}

variable "objectstorage_object_lifecycle_policy_namespace" {
  description = "(Required) The Object Storage namespace used for the request."
  default     = ""
}

variable "objectstorage_object_lifecycle_policy_rules" {
  description = "(Optional) (Updatable) The bucket's set of lifecycle policy rules."
  default     = []
}

variable "objectstorage_object_lifecycle_policy_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Object Lifecycle Policy * update - (Defaults to 20 minutes), when updating the Object Lifecycle Policy * delete - (Defaults to 20 minutes), when destroying the Object Lifecycle Policy"
  default     = {}
}

#-----------------------------------------------------------
# objectstorage object
#-----------------------------------------------------------
variable "enable_objectstorage_object_timeouts" {
  description = "Enable objectstorage object timeouts ssages"
  default     = false
}

variable "objectstorage_object_bucket" {
  description = "The name of the bucket. Avoid entering confidential information. Example: my-new-bucket1"
  default     = ""
}

variable "objectstorage_object_namespace" {
  description = "The Object Storage namespace used for the request."
  default     = ""
}

variable "objectstorage_object_content" {
  description = "(Optional) The object to upload to the object store. Cannot be defined if source or source_uri_details is defined."
  default     = null
}

variable "objectstorage_object_object" {
  description = "(Required) (Updatable) The name of the object. Avoid entering confidential information. Example: test/object1.log"
  default     = null
}

variable "objectstorage_object_cache_control" {
  description = "(Optional) The optional Cache-Control header that defines the caching behavior value to be returned in GetObject and HeadObject responses. Specifying values for this header has no effect on Object Storage behavior. Programs that read the object determine what to do based on the value provided. For example, you could use this header to identify objects that require caching restrictions."
  default     = null
}

variable "objectstorage_object_content_disposition" {
  description = "(Optional) The optional Content-Disposition header that defines presentational information for the object to be returned in GetObject and HeadObject responses. Specifying values for this header has no effect on Object Storage behavior. Programs that read the object determine what to do based on the value provided. For example, you could use this header to let users download objects with custom filenames in a browser."
  default     = null
}

variable "objectstorage_object_content_encoding" {
  description = "(Optional) The optional Content-Encoding header that defines the content encodings that were applied to the object to upload. Specifying values for this header has no effect on Object Storage behavior. Programs that read the object determine what to do based on the value provided. For example, you could use this header to determine what decoding mechanisms need to be applied to obtain the media-type specified by the Content-Type header of the object."
  default     = null
}

variable "objectstorage_object_content_language" {
  description = "AAAAAA"
  default     = null
}

variable "objectstorage_object_content_type" {
  description = "(Optional) The optional Content-Language header that defines the content language of the object to upload. Specifying values for this header has no effect on Object Storage behavior. Programs that read the object determine what to do based on the value provided. For example, you could use this header to identify and differentiate objects based on a particular language."
  default     = null
}

variable "objectstorage_object_delete_all_object_versions" {
  description = "(Optional) (Updatable) A boolean to delete all object versions for an object in a bucket that has or ever had versioning enabled."
  default     = null
}

variable "objectstorage_object_metadata" {
  description = "(Optional) Optional user-defined metadata key and value. Note: All specified keys must be in lower case."
  default     = null
}

variable "objectstorage_object_storage_tier" {
  description = "(Optional) (Updatable) The storage tier that the object should be stored in. If not specified, the object will be stored in the same storage tier as the bucket."
  default     = null
}

variable "objectstorage_object_opc_sse_kms_key_id" {
  description = "(Optional) (Updatable) The OCID of a master encryption key used to call the Key Management service to generate a data encryption key or to encrypt or decrypt a data encryption key."
  default     = null
}

variable "objectstorage_object_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Object * update - (Defaults to 20 minutes), when updating the Object * delete - (Defaults to 20 minutes), when destroying the Object"
  default     = {}
}

#-----------------------------------------------------------
# objectstorage preauthrequest
#-----------------------------------------------------------
variable "enable_objectstorage_preauthrequest" {
  description = "Enable objectstorage preauthrequest usages"
  default     = false
}

variable "objectstorage_preauthrequest_bucket" {
  description = "The name of the bucket. Avoid entering confidential information. Example: my-new-bucket1"
  default     = ""
}

variable "objectstorage_preauthrequest_namespace" {
  description = "The Object Storage namespace used for the request."
  default     = ""
}

variable "objectstorage_preauthrequest_name" {
  description = "A user-specified name for the pre-authenticated request. Names can be helpful in managing pre-authenticated requests. Avoid entering confidential information."
  default     = ""
}

variable "objectstorage_preauthrequest_access_type" {
  description = "(Required) The operation that can be performed on this resource. Allowed Values: ObjectRead, ObjectWrite, ObjectReadWrite, AnyObjectReadWrite or AnyObjectRead"
  default     = null
}

variable "objectstorage_preauthrequest_time_expires" {
  description = "(Required) The expiration date for the pre-authenticated request as per RFC 3339. After this date the pre-authenticated request will no longer be valid."
  default     = null
}

variable "objectstorage_preauthrequest_bucket_listing_action" {
  description = "(Optional) Specifies whether a list operation is allowed on a PAR with accessType 'AnyObjectRead' or 'AnyObjectReadWrite'. Deny: Prevents the user from performing a list operation. ListObjects: Authorizes the user to perform a list operation."
  default     = null
}

variable "objectstorage_preauthrequest_object_name" {
  description = "(Optional) The name of the object that is being granted access to by the pre-authenticated request. Avoid entering confidential information. The object name can be null and if so, the pre-authenticated request grants access to the entire bucket if the access type allows that. The object name can be a prefix as well, in that case pre-authenticated request grants access to all the objects within the bucket starting with that prefix provided that we have the correct access type."
  default     = null
}

variable "objectstorage_preauthrequest_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Preauthenticated Request * update - (Defaults to 20 minutes), when updating the Preauthenticated Request * delete - (Defaults to 20 minutes), when destroying the Preauthenticated Request"
  default     = {}
}

#-----------------------------------------------------------
# replication policy
#-----------------------------------------------------------
variable "enable_objectstorage_replication_policy" {
  description = "Enable objectstorage replication policy usages"
  default     = false
}

variable "objectstorage_replication_policy_name" {
  description = "The name of the policy. Avoid entering confidential information."
  default     = ""
}

variable "objectstorage_replication_policy_bucket" {
  description = "The name of the bucket. Avoid entering confidential information. Example: my-new-bucket1"
  default     = ""
}

variable "objectstorage_replication_policy_namespace" {
  description = "The Object Storage namespace used for the request."
  default     = ""
}

variable "objectstorage_replication_policy_destination_bucket_name" {
  description = "(Required) The bucket to replicate to in the destination region. Replication policy creation does not automatically create a destination bucket. Create the destination bucket before creating the policy."
  default     = null
}

variable "objectstorage_replication_policy_destination_region_name" {
  description = "(Required) The destination region to replicate to, for example 'us-ashburn-1'."
  default     = null
}

variable "objectstorage_replication_policy_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Replication Policy * update - (Defaults to 20 minutes), when updating the Replication Policy * delete - (Defaults to 20 minutes), when destroying the Replication Policy"
  default     = {}
}
