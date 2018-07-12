#---------------------------------------------------
# Create pubsub topic
#---------------------------------------------------
resource "google_pubsub_topic" "pubsub_topic" {
    count       = "${var.enable_pubsub_topic ? 1 : 0}"    

    name        = "${lower(var.name)}-ps-topic-${lower(var.environment)}"
    project     = "${var.project}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create pubsub topic iam policy
#---------------------------------------------------
data "google_iam_policy" "iam_policy" {
    binding {
        role    = "${var.role}"
        members = ["${var.members}"]
    }
}

resource "google_pubsub_topic_iam_policy" "pubsub_topic_iam_policy" {
    count       = "${var.enable_pubsub_topic_iam_policy ? 1 : 0}"
    
    topic       = "${var.topic}"
    policy_data = "${data.google_iam_policy.iam_policy.policy_data}"
    project     = "${var.project}"    

    depends_on  = ["data.google_iam_policy.iam_policy"]

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create pubsub topic iam binding
#---------------------------------------------------
resource "google_pubsub_topic_iam_binding" "pubsub_topic_iam_binding" {
    count       = "${var.enable_pubsub_topic_iam_binding ? 1 : 0}"
    
    topic       = "${var.topic}"
    role        = "${var.role}"
    members     = ["${var.members}"]

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }

}

#---------------------------------------------------
# Create pubsub topic iam member
#---------------------------------------------------
resource "google_pubsub_topic_iam_member" "pubsub_topic_iam_member" {
    count       = "${var.enable_pubsub_topic_iam_member ? 1 : 0}"
    
    topic       = "${var.topic}"
    role        = "${var.role}"
    member      = "${element(var.members, 0)}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }

}

#---------------------------------------------------
# Create pubsub subscription 
#---------------------------------------------------
resource "google_pubsub_subscription" "pubsub_subscription_default" {
    count       = "${var.enable_pubsub_subscription_default ? 1 : 0}"

    name        = "${lower(var.name)}-ps-subscription-${lower(var.environment)}"
    project     = "${var.project}"
    topic       = "${var.topic}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }

}

resource "google_pubsub_subscription" "pubsub_subscription" {
    count                   = "${!var.enable_pubsub_subscription_default ? 1 : 0}"
                    
    name                    = "${lower(var.name)}-ps-subscription-${lower(var.environment)}"
    project                 = "${var.project}"    
    topic                   = "${var.topic}"
                
    ack_deadline_seconds    = "${var.ack_deadline_seconds}"

    push_config {
        push_endpoint   = "${var.push_config_push_endpoint}"
        attributes {
            x-goog-version = "v1"
        }
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }

}

#---------------------------------------------------
# Create pubsub subscription iam policy
#---------------------------------------------------
data "google_iam_policy" "subscription_iam_policy" {
    binding {
        role    = "${var.role}"
        members = ["${var.members}"]
  }
}

resource "google_pubsub_subscription_iam_policy" "pubsub_subscription_iam_policy" {
    count           = "${var.enable_pubsub_subscription_iam_policy ? 1 : 0}"  
                            
    subscription    = "${var.subscription}"
    policy_data     = "${data.google_iam_policy.subscription_iam_policy.policy_data}"
    
    depends_on      = ["data.google_iam_policy.subscription_iam_policy"]    

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }

}

#---------------------------------------------------
# Create pubsub subscription iam binding
#---------------------------------------------------
resource "google_pubsub_subscription_iam_binding" "pubsub_subscription_iam_binding" {
    count           = "${var.enable_pubsub_subscription_iam_binding ? 1 : 0}"
    
    subscription    = "${var.subscription}"
    role            = "${var.role}"
    members         = ["${var.members}"]

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }

}

#---------------------------------------------------
# Create pubsub subscription iam member
#---------------------------------------------------
resource "google_pubsub_subscription_iam_member" "pubsub_subscription_iam_member" {
    count           = "${var.enable_pubsub_subscription_iam_member ? 1 : 0}"
    
    subscription    = "${var.subscription}"
    role            = "${var.role}"
    member          = "${element(var.members, 0)}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
} 
