# Work with OBJECTSTORAGE_BUCKET via terraform

A terraform module for making OBJECTSTORAGE_BUCKET.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.21.0"
    }
  }
}

provider "oci" {
  # config_file = var.provider_oci_config_file
  # profile     = var.provider_oci_profile

  fingerprint      = var.provider_oci_fingerprint
  private_key_path = var.provider_oci_private_key_path
  region           = var.provider_oci_region
  tenancy_ocid     = var.provider_oci_tenancy_ocid
  user_ocid        = var.provider_oci_user_ocid
}

module "objectstorage_bucket" {
  source = "../../modules/objectstorage_bucket"

  enable_objectstorage_bucket = true

  objectstorage_bucket_name           = "ibucket-1"
  objectstorage_bucket_namespace      = "deploys"
  objectstorage_bucket_compartment_id = "ocid1.compartment.oc1..exampleuniqueID"


  objectstorage_bucket_retention_rules = [
    {
      display_name = "RetentionRule1"
      duration = {
        time_amount = 30
        time_unit   = "DAYS"
      }
      time_rule_locked = true
    },
    {
      # No display_name provided; defaults to "rule-2"
      duration = {
        time_amount = 365
        time_unit   = "DAYS"
      }
      # time_rule_locked not provided; defaults to false
    }
    # Add up to 100 retention rules
  ]

  tags = {}
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_objectstorage_bucket` - Enable objectstorage bucket uses (`default = False`)
- `objectstorage_bucket_name` - The name of the bucket. Valid characters are uppercase or lowercase letters, numbers, hyphens, underscores, and periods. Bucket names must be unique within an Object Storage namespace. Avoid entering confidential information. example: Example: my-new-bucket1 (`default = ""`)
- `objectstorage_bucket_namespace` - (Required) The Object Storage namespace used for the request. (`default = null`)
- `objectstorage_bucket_compartment_id` - (Required) (Updatable) The ID of the compartment in which to create the bucket. (`default = ""`)
- `objectstorage_bucket_access_type` - (Optional) (Updatable) The type of public access enabled on this bucket. A bucket is set to NoPublicAccess by default, which only allows an authenticated caller to access the bucket and its contents. When ObjectRead is enabled on the bucket, public access is allowed for the GetObject, HeadObject, and ListObjects operations. When ObjectReadWithoutList is enabled on the bucket, public access is allowed for the GetObject and HeadObject operations. (`default = null`)
- `objectstorage_bucket_auto_tiering` - (Optional) (Updatable) Set the auto tiering status on the bucket. By default, a bucket is created with auto tiering Disabled. Use this option to enable auto tiering during bucket creation. Objects in a bucket with auto tiering set to InfrequentAccess are transitioned automatically between the 'Standard' and 'InfrequentAccess' tiers based on the access pattern of the objects. (`default = null`)
- `objectstorage_bucket_kms_key_id` - (Optional) (Updatable) The OCID of a master encryption key used to call the Key Management service to generate a data encryption key or to encrypt or decrypt a data encryption key. (`default = null`)
- `objectstorage_bucket_metadata` - (Optional) (Updatable) Arbitrary string, up to 4KB, of keys and values for user-defined metadata. (`default = null`)
- `objectstorage_bucket_object_events_enabled` - (Optional) (Updatable) Whether or not events are emitted for object state changes in this bucket. By default, objectEventsEnabled is set to false. Set objectEventsEnabled to true to emit events for object state changes. For more information about events, see Overview of Events. (`default = null`)
- `objectstorage_bucket_storage_tier` - (Optional) The type of storage tier of this bucket. A bucket is set to 'Standard' tier by default, which means the bucket will be put in the standard storage tier. When 'Archive' tier type is set explicitly, the bucket is put in the Archive Storage tier. The 'storageTier' property is immutable after bucket is created. (`default = null`)
- `objectstorage_bucket_versioning` - (Optional) (Updatable) Set the versioning status on the bucket. By default, a bucket is created with versioning Disabled. Use this option to enable versioning during bucket creation. Objects in a version enabled bucket are protected from overwrites and deletions. Previous versions of the same object will be available in the bucket. Allowed Create values: Enabled, Disabled. Allowed Update values: Enabled, Suspended. (`default = null`)
- `objectstorage_bucket_defined_tags` - (Optional) (Updatable) Defined-formtags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'} (`default = {}`)
- `objectstorage_bucket_retention_rules` - (Optional) (Updatable) Creates a new retention rule in the specified bucket. The new rule will take effect typically within 30 seconds. Note that a maximum of 100 rules are supported on a bucket. (`default = []`)
- `objectstorage_bucket_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Bucket * update - (Defaults to 20 minutes), when updating the Bucket * delete - (Defaults to 20 minutes), when destroying the Bucket (`default = {}`)
- `enable_objectstorage_object_lifecycle_policy` - Enable objectstorage object lifecycle policy usages (`default = False`)
- `objectstorage_object_lifecycle_policy_bucket` - (Required) The name of the bucket. Avoid entering confidential information. Example: my-new-bucket1 (`default = ""`)
- `objectstorage_object_lifecycle_policy_namespace` - (Required) The Object Storage namespace used for the request. (`default = ""`)
- `objectstorage_object_lifecycle_policy_rules` - (Optional) (Updatable) The bucket's set of lifecycle policy rules. (`default = []`)
- `objectstorage_object_lifecycle_policy_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Object Lifecycle Policy * update - (Defaults to 20 minutes), when updating the Object Lifecycle Policy * delete - (Defaults to 20 minutes), when destroying the Object Lifecycle Policy (`default = {}`)
- `enable_objectstorage_object_timeouts` - Enable objectstorage object timeouts ssages (`default = False`)
- `objectstorage_object_bucket` - The name of the bucket. Avoid entering confidential information. Example: my-new-bucket1 (`default = ""`)
- `objectstorage_object_namespace` - The Object Storage namespace used for the request. (`default = ""`)
- `objectstorage_object_content` - (Optional) The object to upload to the object store. Cannot be defined if source or source_uri_details is defined. (`default = null`)
- `objectstorage_object_object` - (Required) (Updatable) The name of the object. Avoid entering confidential information. Example: test/object1.log (`default = null`)
- `objectstorage_object_cache_control` - (Optional) The optional Cache-Control header that defines the caching behavior value to be returned in GetObject and HeadObject responses. Specifying values for this header has no effect on Object Storage behavior. Programs that read the object determine what to do based on the value provided. For example, you could use this header to identify objects that require caching restrictions. (`default = null`)
- `objectstorage_object_content_disposition` - (Optional) The optional Content-Disposition header that defines presentational information for the object to be returned in GetObject and HeadObject responses. Specifying values for this header has no effect on Object Storage behavior. Programs that read the object determine what to do based on the value provided. For example, you could use this header to let users download objects with custom filenames in a browser. (`default = null`)
- `objectstorage_object_content_encoding` - (Optional) The optional Content-Encoding header that defines the content encodings that were applied to the object to upload. Specifying values for this header has no effect on Object Storage behavior. Programs that read the object determine what to do based on the value provided. For example, you could use this header to determine what decoding mechanisms need to be applied to obtain the media-type specified by the Content-Type header of the object. (`default = null`)
- `objectstorage_object_content_language` - AAAAAA (`default = null`)
- `objectstorage_object_content_type` - (Optional) The optional Content-Language header that defines the content language of the object to upload. Specifying values for this header has no effect on Object Storage behavior. Programs that read the object determine what to do based on the value provided. For example, you could use this header to identify and differentiate objects based on a particular language. (`default = null`)
- `objectstorage_object_delete_all_object_versions` - (Optional) (Updatable) A boolean to delete all object versions for an object in a bucket that has or ever had versioning enabled. (`default = null`)
- `objectstorage_object_metadata` - (Optional) Optional user-defined metadata key and value. Note: All specified keys must be in lower case. (`default = null`)
- `objectstorage_object_storage_tier` - (Optional) (Updatable) The storage tier that the object should be stored in. If not specified, the object will be stored in the same storage tier as the bucket. (`default = null`)
- `objectstorage_object_opc_sse_kms_key_id` - (Optional) (Updatable) The OCID of a master encryption key used to call the Key Management service to generate a data encryption key or to encrypt or decrypt a data encryption key. (`default = null`)
- `objectstorage_object_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Object * update - (Defaults to 20 minutes), when updating the Object * delete - (Defaults to 20 minutes), when destroying the Object (`default = {}`)
- `enable_objectstorage_preauthrequest` - Enable objectstorage preauthrequest usages (`default = False`)
- `objectstorage_preauthrequest_bucket` - The name of the bucket. Avoid entering confidential information. Example: my-new-bucket1 (`default = ""`)
- `objectstorage_preauthrequest_namespace` - The Object Storage namespace used for the request. (`default = ""`)
- `objectstorage_preauthrequest_name` - A user-specified name for the pre-authenticated request. Names can be helpful in managing pre-authenticated requests. Avoid entering confidential information. (`default = ""`)
- `objectstorage_preauthrequest_access_type` - (Required) The operation that can be performed on this resource. Allowed Values: ObjectRead, ObjectWrite, ObjectReadWrite, AnyObjectReadWrite or AnyObjectRead (`default = null`)
- `objectstorage_preauthrequest_time_expires` - (Required) The expiration date for the pre-authenticated request as per RFC 3339. After this date the pre-authenticated request will no longer be valid. (`default = null`)
- `objectstorage_preauthrequest_bucket_listing_action` - (Optional) Specifies whether a list operation is allowed on a PAR with accessType 'AnyObjectRead' or 'AnyObjectReadWrite'. Deny: Prevents the user from performing a list operation. ListObjects: Authorizes the user to perform a list operation. (`default = null`)
- `objectstorage_preauthrequest_object_name` - (Optional) The name of the object that is being granted access to by the pre-authenticated request. Avoid entering confidential information. The object name can be null and if so, the pre-authenticated request grants access to the entire bucket if the access type allows that. The object name can be a prefix as well, in that case pre-authenticated request grants access to all the objects within the bucket starting with that prefix provided that we have the correct access type. (`default = null`)
- `objectstorage_preauthrequest_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Preauthenticated Request * update - (Defaults to 20 minutes), when updating the Preauthenticated Request * delete - (Defaults to 20 minutes), when destroying the Preauthenticated Request (`default = {}`)
- `enable_objectstorage_replication_policy` - Enable objectstorage replication policy usages (`default = False`)
- `objectstorage_replication_policy_name` - The name of the policy. Avoid entering confidential information. (`default = ""`)
- `objectstorage_replication_policy_bucket` - The name of the bucket. Avoid entering confidential information. Example: my-new-bucket1 (`default = ""`)
- `objectstorage_replication_policy_namespace` - The Object Storage namespace used for the request. (`default = ""`)
- `objectstorage_replication_policy_destination_bucket_name` - (Required) The bucket to replicate to in the destination region. Replication policy creation does not automatically create a destination bucket. Create the destination bucket before creating the policy. (`default = null`)
- `objectstorage_replication_policy_destination_region_name` - (Required) The destination region to replicate to, for example 'us-ashburn-1'. (`default = null`)
- `objectstorage_replication_policy_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Replication Policy * update - (Defaults to 20 minutes), when updating the Replication Policy * delete - (Defaults to 20 minutes), when destroying the Replication Policy (`default = {}`)

## Module Output Variables
----------------------
- `objectstorage_bucket_id` - The OCID of the bucket which is a Oracle assigned unique identifier for this resource type (bucket). bucket_id cannot be used for bucket lookup.
- `objectstorage_bucket_access_type` - The type of public access enabled on this bucket. A bucket is set to NoPublicAccess by default, which only allows an authenticated caller to access the bucket and its contents. When ObjectRead is enabled on the bucket, public access is allowed for the GetObject, HeadObject, and ListObjects operations. When ObjectReadWithoutList is enabled on the bucket, public access is allowed for the GetObject and HeadObject operations.
- `objectstorage_bucket_compartment_id` - The compartment ID in which the bucket is authorized.
- `objectstorage_bucket_created_by` - The OCID of the user who created the bucket.
- `objectstorage_bucket_is_read_only` - Whether or not this bucket is read only. By default, isReadOnly is set to false. This will be set to 'true' when this bucket is configured as a destination in a replication policy.
- `objectstorage_bucket_name` - The name of the bucket. Avoid entering confidential information. Example: my-new-bucket1
- `objectstorage_bucket_namespace` - The Object Storage namespace in which the bucket resides.
- `objectstorage_bucket_versioning` - The versioning status on the bucket. A bucket is created with versioning Disabled by default. For versioning Enabled, objects are protected from overwrites and deletes, by maintaining their version history. When versioning is Suspended, the previous versions will still remain but new versions will no longer be created when overwitten or deleted.
- `objectstorage_bucket_storage_tier` - The storage tier type assigned to the bucket. A bucket is set to Standard tier by default, which means objects uploaded or copied to the bucket will be in the standard storage tier. When the Archive tier type is set explicitly for a bucket, objects uploaded or copied to the bucket will be stored in archive storage. The storageTier property is immutable after bucket is created.
- `objectstorage_bucket_replication_enabled` - Whether or not this bucket is a replication source. By default, replicationEnabled is set to false. This will be set to 'true' when you create a replication policy for the bucket.
- `objectstorage_object_lifecycle_policy_rules` - TBD
- `objectstorage_object_bucket` - The name of the bucket. Avoid entering confidential information. Example: my-new-bucket1
- `objectstorage_object_namespace` - The top-level namespace used for the request.
- `objectstorage_object_object` - The name of the object. Avoid entering confidential information. Example: test/object1.log
- `objectstorage_preauthrequest_id` - The unique identifier to use when directly addressing the pre-authenticated request.
- `objectstorage_preauthrequest_bucket` - The name of the bucket. Example: my-new-bucket1
- `objectstorage_preauthrequest_name` - The user-provided name of the pre-authenticated request.
- `objectstorage_preauthrequest_namespace` - The top-level namespace used for the request.
- `objectstorage_preauthrequest_access_type` - The operation that can be performed on this resource.
- `objectstorage_preauthrequest_bucket_listing_action` - Specifies whether a list operation is allowed on a PAR with accessType 'AnyObjectRead' or 'AnyObjectReadWrite'. Deny: Prevents the user from performing a list operation. ListObjects: Authorizes the user to perform a list operation.
- `objectstorage_preauthrequest_full_path` - The full Path for the object.
- `objectstorage_preauthrequest_access_uri` - The URI to embed in the URL https://objectstorage.${var.region}.oraclecloud.com{var.access_uri} when using the pre-authenticated request.
- `objectstorage_preauthrequest_object` - The name of the object that is being granted access to by the pre-authenticated request. Avoid entering confidential information. The object name can be null and if so, the pre-authenticated request grants access to the entire bucket. Example: test/object1.log
- `objectstorage_preauthrequest_par_id` - The unique identifier for the pre-authenticated request. This can be used to manage operations against the pre-authenticated request, such as GET or DELETE.
- `objectstorage_preauthrequest_time_created` - The date when the pre-authenticated request was created as per specification RFC 3339.
- `objectstorage_preauthrequest_time_expires` - The expiration date for the pre-authenticated request as per RFC 3339. After this date the pre-authenticated request will no longer be valid.
- `objectstorage_replication_policy_destination_bucket_name` - The bucket to replicate to in the destination region. Replication policy creation does not automatically create a destination bucket. Create the destination bucket before creating the policy.
- `objectstorage_replication_policy_destination_region_name` - The destination region to replicate to, for example 'us-ashburn-1'.
- `objectstorage_replication_policy_id` - The id of the replication policy.
- `objectstorage_replication_policy_name` - The name of the policy.
- `objectstorage_replication_policy_status` - The replication status of the policy. If the status is CLIENT_ERROR, once the user fixes the issue described in the status message, the status will become ACTIVE.
- `objectstorage_replication_policy_status_message` - A human-readable description of the status.
- `objectstorage_replication_policy_time_created` - The date when the replication policy was created as per RFC 3339.
- `objectstorage_replication_policy_time_last_sync` - Changes made to the source bucket before this time has been replicated.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
