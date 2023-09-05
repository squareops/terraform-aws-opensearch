variable "opensearch_enabled" {
  description = "Change to false to avoid deploying any AWS ElasticSearch resources"
  type        = bool
  default     = true
}

variable "domain_name" {
  description = "Name of the domain name by which opensearch dashboard will be deployed"
  type        = string
}

variable "engine_version" {
  description = "The version of OpenSearch to deploy."
  type        = string
  default     = "2.7"
}

variable "cloudwatch_log_enabled" {
  description = "Change to false to avoid deploying any Cloudwatch Logs resources"
  type        = bool
  default     = true
}

variable "custom_master_password_enabled" {
  description = "enable disable option for custom master password "
  type        = bool
  default     = false
}

variable "custom_master_password" {
  description = "custom master password value."
  type        = string
  default     = ""
}

variable "cluster_config" {
  description = "Cluster configuration of the domain like instance_type, instance_count, dedicated_master_enabled, availability_zone_count, etc."
  type        = list(any)
  default     = []
}

variable "advanced_security_options" {
  description = "Options for fine-grained access control"
  type        = list(any)
  default     = []
}

variable "advanced_security_options_enabled" {
  description = "enable disable option for fine-grained access control "
  type        = bool
  default     = true
}

variable "domain_endpoint_options" {
  description = "Domain endpoint HTTP(S) related options."
  type        = list(any)
  default     = []
}

variable "ebs_options" {
  description = "EBS related options, may be required based on chosen instance size"
  type        = list(any)
  default     = []
}

variable "ebs_enabled" {
  description = "whether you want to use ebs volumes or not for the generated instance by opensearch"
  type        = bool
  default     = true
}

variable "encrypt_at_rest" {
  description = "Encrypt at rest options. Only available for certain instance types"
  type        = list(any)
  default     = []
}

variable "node_to_node_encryption" {
  description = "Node-to-node encryption options"
  type        = list(any)
  default     = []
}

variable "snapshot_options" {
  description = "Snapshot related options"
  type        = list(any)
  default     = []
}

variable "cognito_options" {
  description = "Options for Amazon Cognito Authentication for opensearch"
  type        = list(any)
  default     = []
}

# log_publishing_options
variable "log_publishing_options" {
  description = "Options for publishing opensearch logs to CloudWatch Logs"
  type        = any
  default     = {}
}

variable "log_publishing_options_retention" {
  description = "Retention in days for the created Cloudwatch log group"
  type        = number
  default     = 60
}

variable "advanced_options" {
  description = "Key-value string pairs to specify advanced configuration options. Note that the values for these configuration options must be strings (wrapped in quotes) or they may be wrong and cause a perpetual diff, causing Terraform to want to recreate your Elasticsearch domain on every apply"
  type        = map(string)
  default     = {}
}
