#---------------------------------------------------
# Create google KMS key ring
#---------------------------------------------------
resource "google_kms_key_ring" "kms_key_ring" {
    count       = "${var.enable_kms_key_ring ? 1 : 0}"

    name        = "${lower(var.name)}-kms-kr-${lower(var.environment)}"
    location    = "${var.location}"
    project     = "${var.project}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create google KMS
#---------------------------------------------------
resource "google_kms_crypto_key_iam_binding" "kms_crypto_key_iam_binding" {
    count           = "${var.enable_kms_crypto_key_iam_binding ? 1 : 0}"
            
    #crypto_key_id   = "my-gcp-project/us-central1/my-key-ring/my-crypto-key"
    crypto_key_id   = "${var.crypto_key_id}" 
    role            = "${var.role}"
                    
    members         = ["${var.members}"] 

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create google KMS crypto key
#---------------------------------------------------
resource "google_kms_crypto_key" "kms_crypto_key" {
    count           = "${var.enable_kms_crypto_key ? 1 : 0}"    

    name            = "${lower(var.name)}-kms-ck-${lower(var.environment)}"
    key_ring        = "${var.key_ring}"
    rotation_period = "${var.rotation_period}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create google KMS crypto key iam member 
#---------------------------------------------------
resource "google_kms_crypto_key_iam_member" "kms_crypto_key_iam_member" {
    count           = "${var.enable_kms_crypto_key_iam_member ? 1 : 0}"    

    crypto_key_id   = "${var.crypto_key_id}"
    role            = "${var.role}"
    member          = "${var.kms_crypto_key_iam_member}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create google KMS key ring iam policy
#---------------------------------------------------
data "google_iam_policy" "iam_policy" {
  binding {
    role = "${var.role}"

    members = ["${var.members}"]
  }
}

resource "google_kms_key_ring_iam_policy" "kms_key_ring_iam_policy" {
    count           = "${var.enable_kms_key_ring_iam_policy ? 1 : 0}"

    key_ring_id     = "${var.key_ring_id}"
    policy_data     = "${data.google_iam_policy.iam_policy.policy_data}"

    depends_on      = ["data.google_iam_policy.iam_policy"] 

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
