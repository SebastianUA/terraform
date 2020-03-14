variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "enable_cloudbuild_trigger_filename" {
    description = "Enable cloudbuild trigger filename. Default - true. If not, will use biult inside structure of module"
    default     = "true"
}

variable "project" {
    description = "Project name"
    default     = ""
}

variable "description" {
    description = "(Optional) A brief description of this resource."
    default     = ""
}

variable "trigger_template_branch_name" {
    description = "(Optional) Name of the branch to build."
    default     = ""
}

variable "trigger_template_project" {
    description = "(Optional) ID of the project that owns the Cloud Source Repository."
    default     = ""
}

variable "trigger_template_repo_name" {
    description = "(Optional) Name of the Cloud Source Repository."
    default     = ""
}

variable "trigger_template_commit_sha" {
    description = "(Optional) Explicit commit SHA to build."
    default     = ""
}

variable "trigger_template_dir" {
    description = "(Optional) Directory, relative to the source root, in which to run the build. This must be a relative path. If a step's dir is specified and is an absolute path, this value is ignored for that step's execution."
    default     = ""
}

variable "trigger_template_tag_name" {
    description = "(Optional) Name of the tag to build."
    default     = ""
}

variable "filename" {
    description = "(Optional) Specify the path to a Cloud Build configuration file in the Git repo. This is mutually exclusive with build. This is typically cloudbuild.yaml however it can be specified by the user."
    default     = ""
}

variable "build_images" {
    description = "(Optional) A list of images to be pushed upon the successful completion of all build steps. Ex: 'gcr.io/$PROJECT_ID/$REPO_NAME:$COMMIT_SHA'"
    default     = []
}

variable "build_step_name" {
    description = "(Optional) The name of the container image that will run this particular build step. If the image is available in the host's Docker daemon's cache, it will be run directly. If not, the host will attempt to pull the image first, using the builder service account's credentials if necessary. The Docker daemon's cache will already have the latest versions of all of the officially supported build steps (https://github.com/GoogleCloudPlatform/cloud-builders). The Docker daemon will also have cached many of the layers for some popular images, like 'ubuntu', 'debian', but they will be refreshed at the time you attempt to use them. If you built an image in a previous build step, it will be stored in the host's Docker daemon's cache and is available to use as the name for a later build step."
    default     = ""
}

variable "build_step_args" {
    description = "(Optional) A list of arguments that will be presented to the step when it is started. If the image used to run the step's container has an entrypoint, the args are used as arguments to that entrypoint. If the image does not define an entrypoint, the first element in args is used as the entrypoint, and the remainder will be used as arguments."
    default     = ""
}

variable "build_tags" {
    description = "(Optional) Tags for annotation of a build. These are not docker tags"
    default     = []
}
