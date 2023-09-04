locals {
  region                         = "us-east-2"
  custom_master_password         = "H2222@sbkQTX"
  custom_master_password_enabled = true
  additional_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }
}

module "aws_opensearch" {
  source         = "git@github.com:sq-ia/terraform-aws-opensearch.git"
  domain_name    = "skaf"
  engine_version = "2.7"
  cluster_config = [{
    dedicated_master_enabled = false
    dedicated_master_type    = "t3.medium.search"
    instance_count           = 1
    instance_type            = "t3.medium.search"
    zone_awareness_enabled   = false
    availability_zone_count  = 1
  }]

  custom_master_password_enabled    = local.custom_master_password_enabled
  custom_master_password            = local.custom_master_password
  advanced_security_options_enabled = true
  advanced_security_options = [{
    internal_user_database_enabled = true
    master_user_options = {
      master_user_name     = "admin"
      master_user_password = local.custom_master_password_enabled ? local.custom_master_password : ""
    }
  }]

  domain_endpoint_options = [{
    enforce_https = true
  }]

  ebs_enabled = true
  ebs_options = [{
    volume_size = 10
  }]

  #if you will not pass kms key id it will pick default managed by aws
  encrypt_at_rest = [{
    enabled = true
    #kms_key_id = "arn:aws:kms:us-east-2:271251951598:key/f1e2f1a9-686a-4e31-a5c8-38623e045e27"
  }]

  log_publishing_options = {
    es_application_logs = {
      enabled                          = true
      log_publishing_options_retention = 30
      cloudwatch_log_group_name        = "os_application_logs_dev"
    }
    audit_logs = {
      enabled                          = false
      log_publishing_options_retention = 30
      cloudwatch_log_group_name        = "audit_logs_dev"
    }
  }

  node_to_node_encryption = [
    {
      enabled = true
    }
  ]

  snapshot_options = [{
    automated_snapshot_start_hour = 23
  }]
}
