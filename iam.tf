resource "aws_cloudwatch_log_group" "es_cloudwatch_log_group" {

  for_each = { for k, v in var.log_publishing_options :
    k => v if var.enabled && lookup(v, "enabled", false) && lookup(v, "cloudwatch_log_group_name", null) != null
  }

  name              = each.value["cloudwatch_log_group_name"]
  retention_in_days = lookup(each.value, "log_publishing_options_retention", var.log_publishing_options_retention)
}

resource "aws_cloudwatch_log_resource_policy" "es_aws_cloudwatch_log_resource_policy" {
  count       = var.enabled && var.cloudwatch_log_enabled ? 1 : 0
  policy_name = "${var.domain_name}-policy"

  policy_document = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": "arn:aws:logs:*"
    }
  ]
}
CONFIG
}

# data "aws_iam_role" "awsopensearch" {
#   name = "AWSServiceRoleForAmazonOpenSearchService"
# }

# Service-linked role to give Amazon ES permissions to access your VPC
resource "aws_iam_service_linked_role" "es" {
  #count            = length(data.aws_iam_role.awsopensearch.arn) > 0 ? 0 : 1
  aws_service_name = "es.amazonaws.com"
  description      = "Service-linked role to give Amazon ES permissions to access your VPC"
}

# data "aws_kms_key" "aws_es" {
#   key_id = var.encrypt_at_rest_kms_key_id
# }
