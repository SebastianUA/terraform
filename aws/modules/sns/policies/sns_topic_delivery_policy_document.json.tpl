{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": ${minDelayTarget},
      "maxDelayTarget": ${maxDelayTarget},
      "numRetries": ${numRetries},
      "numMaxDelayRetries": ${numMaxDelayRetries},
      "numNoDelayRetries": ${numNoDelayRetries},
      "numMinDelayRetries": ${numMinDelayRetries},
      "backoffFunction": "${backoffFunction}"
    },
    "disableSubscriptionOverrides": ${disableSubscriptionOverrides}
  }
}

