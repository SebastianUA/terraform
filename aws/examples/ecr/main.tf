module "ecr" {
    source                          = "../../modules/ecr"
    name                            = "test"
    region                          = "us-west-2"
    environment                     = "PROD"

    enable_ecr_repository           = true
    # You could use custom name for ECR repo
    #ecr_repository_name             = "test-ecr-repo"


    enable_ecr_repository_policy    = true
    policy_json_file                = "additional_files/policy.json"
    
    enable_ecr_lifecycle_policy     = true
    lifecycle_policy_json_file      = "additional_files/lifecycle_policy.json"
}
