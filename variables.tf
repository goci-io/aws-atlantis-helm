
variable "organization" {
  type        = string
  description = "The version control hosting organization (eg: goci-io)"
}

variable "repositories" {
  type        = list(string)
  default     = ["*"]
  description = "List of repositories. Defaults to all repositories within the organization"
}

variable "namespace" {
  type        = string
  description = "Organization or company prefix"
}

variable "stage" {
  type        = string
  description = "Stage for which to deploy the release"
}

variable "region" {
  type        = string
  description = "Custom region name"
}

variable "k8s_namespace" {
  type        = string
  default     = "provisioning"
  description = "The kubernetes namespace to deploy the release into"
}

variable "name" {
  type        = string
  default     = "atlantis"
  description = "Deployment name of the helm release"
}

variable "pod_annotations" {
  type        = map(string)
  default     = {}
  description = "Additional annotations to be added to the pod template"
}

variable "helm_release_version" {
  type        = string
  default     = "3.10.1"
  description = "Version of the helm release to deploy"
}

variable "aws_region" {
  type        = string
  description = "AWS Region to deploy atlantis to"
}

variable "vc_host" {
  type        = string
  default     = "github.com"
  description = "Host to the version control system (github, gitlab, bitbucket)"
}

variable "vc_type" {
  type        = string
  default     = "github"
  description = "The version control system platform to use. Valid values are bitbucket, github and gitlab"
}

variable "apply_requirements" {
  type        = list(string)
  default     = ["approved", "mergeable"]
  description = "Requirements before running terraform apply"
}

variable "lambda_encryption_function" {
  type        = string
  default     = ""
  description = "Name of a lambda function to decrypt the values"
}

variable "encrypted_user" {
  type        = string
  default     = ""
  description = "Encrypted username. Lambda function specified in lambda_encryption_function is used to decrypt"
}

variable "encrypted_token" {
  type        = string
  default     = ""
  description = "Encrypted username. Lambda function specified in lambda_encryption_function is used to decrypt"
}

variable "encrypted_secret" {
  type        = string
  default     = ""
  description = "Encrypted webhook secret. If not set a random secret will be generated. Lambda function specified in lambda_encryption_function is used to decrypt"
}

variable "ssm_parameter_secret" {
  type        = string
  default     = ""
  description = "SSM Parameter name to get the webhook secret"
}

variable "ssm_parameter_token" {
  type        = string
  default     = ""
  description = "SSM Parameter name to get the version control access token"
}

variable "ssm_parameter_user" {
  type        = string
  default     = ""
  description = "SSM Parameter name to get the version control username"
}

variable "cluster_fqdn" {
  type        = string
  description = "The full qualified domain name for the cluster root domain (basically the ingress root dns name)"
}

variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "Additional environment variables to add to the pod template"
}