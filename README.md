## terraform-kubernetes-opensearch

![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>

This module deploys OpenSearch. With this module, take the advantage of OpenSearch installation in your AWS account. OpenSearch is a scalable, flexible, and extensible open-source software suite for search, analytics, and observability applications licensed under Apache 2.0. Powered by Apache Lucene and driven by the OpenSearch Project community, OpenSearch offers a vendor-agnostic toolset you can use to build secure, high-performance, cost-efficient applications. Use OpenSearch as an end-to-end solution or connect it with your preferred open-source tools or partner projects.OpenSearch is a distributed, community-driven, Apache 2.0-licensed, 100% open-source search and analytics suite used for a broad set of use cases like real-time application monitoring, log analytics, and website search. OpenSearch provides a highly scalable system for providing fast access and response to large volumes of data with an integrated visualization tool, OpenSearch Dashboards, that makes it easy for users to explore their data. OpenSearch is powered by the Apache Lucene search library, and it supports a number of search and analytics capabilities such as k-nearest neighbors (KNN) search, SQL, Anomaly Detection, Machine Learning Commons, Trace Analytics, full-text search, and more.

## Important Notes:
This module is compatible with all the terraform versions which is great news for users deploying the module on AWS running account. Reviewed the module's documentation, meet specific configuration requirements, and test thoroughly after deployment to ensure everything works as expected.


## Usage Example

```hcl
locals {
  aws_region                         = "us-east-2"
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
  opensearch_enabled = true
  domain_name    = "skaf"
  open_search_engine_version = "2.11"
  cluster_config = [{
    instance_type            = "t3.medium.search"
    instance_count           = 1
# warm nodes depends on dedicated master type nodes.
    dedicated_master_enabled = false
    dedicated_master_type    = "r6g.large.search"
    dedicated_master_count   = 3
    warm_enabled             = false
    zone_awareness_enabled   = false
    availability_zone_count  = 1
  }]

  custom_master_password_enabled    = local.custom_master_password_enabled
  custom_master_password            = local.custom_master_password
  advanced_security_options_enabled = true
  advanced_security_options = [{
    master_user_options = {
      master_user_name     = "admin"
      master_user_password = local.custom_master_password_enabled ? local.custom_master_password : ""
    }
  }]

  domain_endpoint_options = [{
    enforce_https            = true
    custom_endpoint_enabled  = false
  }]

  ebs_enabled = true
  ebs_options = [{
    volume_size = 10
    volume_type = "gp2"
    iops        = 3000
  }]

  # if you will not pass kms key id it will pick default managed by aws
  encrypt_at_rest = [{
    enabled = true
  }]

  cloudwatch_log_enabled = false
  log_publishing_options = {
    es_application_logs = {
      enabled                          = true
      log_publishing_options_retention = 30
      cloudwatch_log_group_name        = "os_application_logs_dev"
    }
    audit_logs = {
      enabled                          = false
      log_publishing_options_retention = 30
      cloudwatch_log_group_name        = "os_audit_logs"
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
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.es_cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_resource_policy.es_aws_cloudwatch_log_resource_policy](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_iam_service_linked_role.es](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/iam_service_linked_role) | resource |
| [aws_opensearch_domain.es_domain](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/resources/opensearch_domain) | resource |
| [random_password.master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.access_policy](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.aws_es](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/kms_key) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advanced_options"></a> [advanced\_options](#input\_advanced\_options) | Key-value string pairs to specify advanced configuration options. Note that the values for these configuration options must be strings (wrapped in quotes) or they may be wrong and cause a perpetual diff, causing Terraform to want to recreate your Elasticsearch domain on every apply | `map(string)` | `{}` | no |
| <a name="input_advanced_security_options"></a> [advanced\_security\_options](#input\_advanced\_security\_options) | Options for fine-grained access control | `any` | `{}` | no |
| <a name="input_advanced_security_options_create_random_master_password"></a> [advanced\_security\_options\_create\_random\_master\_password](#input\_advanced\_security\_options\_create\_random\_master\_password) | Whether to create random master password for Elasticsearch master user | `bool` | `false` | no |
| <a name="input_advanced_security_options_enabled"></a> [advanced\_security\_options\_enabled](#input\_advanced\_security\_options\_enabled) | Whether advanced security is enabled (Forces new resource) | `bool` | `false` | no |
| <a name="input_advanced_security_options_internal_user_database_enabled"></a> [advanced\_security\_options\_internal\_user\_database\_enabled](#input\_advanced\_security\_options\_internal\_user\_database\_enabled) | Whether the internal user database is enabled. If not set, defaults to false by the AWS API. | `bool` | `false` | no |
| <a name="input_advanced_security_options_master_user_arn"></a> [advanced\_security\_options\_master\_user\_arn](#input\_advanced\_security\_options\_master\_user\_arn) | ARN for the master user. Only specify if `internal_user_database_enabled` is not set or set to `false`) | `string` | `null` | no |
| <a name="input_advanced_security_options_master_user_password"></a> [advanced\_security\_options\_master\_user\_password](#input\_advanced\_security\_options\_master\_user\_password) | The master user's password, which is stored in the Amazon Elasticsearch Service domain's internal database. Only specify if `internal_user_database_enabled` is set to `true`. | `string` | `"Admin@2233"` | no |
| <a name="input_advanced_security_options_master_user_username"></a> [advanced\_security\_options\_master\_user\_username](#input\_advanced\_security\_options\_master\_user\_username) | The master user's username, which is stored in the Amazon Elasticsearch Service domain's internal database. Only specify if `internal_user_database_enabled` is set to `true`. | `string` | `"admin"` | no |
| <a name="input_advanced_security_options_random_master_password_length"></a> [advanced\_security\_options\_random\_master\_password\_length](#input\_advanced\_security\_options\_random\_master\_password\_length) | Length of random master password to create | `number` | `8` | no |
| <a name="input_cloudwatch_log_enabled"></a> [cloudwatch\_log\_enabled](#input\_cloudwatch\_log\_enabled) | Change to false to avoid deploying any Cloudwatch Logs resources | `bool` | `true` | no |
| <a name="input_cluster_config"></a> [cluster\_config](#input\_cluster\_config) | Cluster configuration of the domain | `any` | `{}` | no |
| <a name="input_cluster_config_availability_zone_count"></a> [cluster\_config\_availability\_zone\_count](#input\_cluster\_config\_availability\_zone\_count) | Number of Availability Zones for the domain to use with | `number` | `1` | no |
| <a name="input_cluster_config_cold_storage_options_enabled"></a> [cluster\_config\_cold\_storage\_options\_enabled](#input\_cluster\_config\_cold\_storage\_options\_enabled) | Indicates whether to enable cold storage for an Elasticsearch domain | `bool` | `false` | no |
| <a name="input_cluster_config_dedicated_master_count"></a> [cluster\_config\_dedicated\_master\_count](#input\_cluster\_config\_dedicated\_master\_count) | Number of dedicated master nodes in the cluster | `number` | `1` | no |
| <a name="input_cluster_config_dedicated_master_enabled"></a> [cluster\_config\_dedicated\_master\_enabled](#input\_cluster\_config\_dedicated\_master\_enabled) | Indicates whether dedicated master nodes are enabled for the cluster | `bool` | `false` | no |
| <a name="input_cluster_config_dedicated_master_type"></a> [cluster\_config\_dedicated\_master\_type](#input\_cluster\_config\_dedicated\_master\_type) | Instance type of the dedicated master nodes in the cluster | `string` | `"t3.medium.search"` | no |
| <a name="input_cluster_config_instance_count"></a> [cluster\_config\_instance\_count](#input\_cluster\_config\_instance\_count) | Number of instances in the cluster | `number` | `1` | no |
| <a name="input_cluster_config_instance_type"></a> [cluster\_config\_instance\_type](#input\_cluster\_config\_instance\_type) | Instance type of data nodes in the cluster | `string` | `"t3.medium.search"` | no |
| <a name="input_cluster_config_warm_count"></a> [cluster\_config\_warm\_count](#input\_cluster\_config\_warm\_count) | The number of warm nodes in the cluster | `number` | `null` | no |
| <a name="input_cluster_config_warm_enabled"></a> [cluster\_config\_warm\_enabled](#input\_cluster\_config\_warm\_enabled) | Indicates whether to enable warm storage | `bool` | `false` | no |
| <a name="input_cluster_config_warm_type"></a> [cluster\_config\_warm\_type](#input\_cluster\_config\_warm\_type) | The instance type for the Elasticsearch cluster's warm nodes | `string` | `null` | no |
| <a name="input_cluster_config_zone_awareness_enabled"></a> [cluster\_config\_zone\_awareness\_enabled](#input\_cluster\_config\_zone\_awareness\_enabled) | Indicates whether zone awareness is enabled. To enable awareness with three Availability Zones | `bool` | `false` | no |
| <a name="input_cognito_options"></a> [cognito\_options](#input\_cognito\_options) | Options for Amazon Cognito Authentication for Kibana | `any` | `{}` | no |
| <a name="input_cognito_options_enabled"></a> [cognito\_options\_enabled](#input\_cognito\_options\_enabled) | Specifies whether Amazon Cognito authentication with Kibana is enabled or not | `bool` | `false` | no |
| <a name="input_cognito_options_identity_pool_id"></a> [cognito\_options\_identity\_pool\_id](#input\_cognito\_options\_identity\_pool\_id) | ID of the Cognito Identity Pool to use | `string` | `""` | no |
| <a name="input_cognito_options_role_arn"></a> [cognito\_options\_role\_arn](#input\_cognito\_options\_role\_arn) | ARN of the IAM role that has the AmazonESCognitoAccess policy attached | `string` | `""` | no |
| <a name="input_cognito_options_user_pool_id"></a> [cognito\_options\_user\_pool\_id](#input\_cognito\_options\_user\_pool\_id) | ID of the Cognito User Pool to use | `string` | `""` | no |
| <a name="input_create_a_record"></a> [create\_a\_record](#input\_create\_a\_record) | create route 53 record | `bool` | `false` | no |
| <a name="input_create_service_link_role"></a> [create\_service\_link\_role](#input\_create\_service\_link\_role) | Create service link role for AWS Elasticsearch Service | `bool` | `true` | no |
| <a name="input_domain_endpoint_options"></a> [domain\_endpoint\_options](#input\_domain\_endpoint\_options) | Domain endpoint HTTP(S) related options. | `any` | `{}` | no |
| <a name="input_domain_endpoint_options_custom_endpoint"></a> [domain\_endpoint\_options\_custom\_endpoint](#input\_domain\_endpoint\_options\_custom\_endpoint) | Fully qualified domain for your custom endpoint | `string` | `null` | no |
| <a name="input_domain_endpoint_options_custom_endpoint_certificate_arn"></a> [domain\_endpoint\_options\_custom\_endpoint\_certificate\_arn](#input\_domain\_endpoint\_options\_custom\_endpoint\_certificate\_arn) | ACM certificate ARN for your custom endpoint | `string` | `null` | no |
| <a name="input_domain_endpoint_options_custom_endpoint_enabled"></a> [domain\_endpoint\_options\_custom\_endpoint\_enabled](#input\_domain\_endpoint\_options\_custom\_endpoint\_enabled) | Whether to enable custom endpoint for the Elasticsearch domain | `bool` | `false` | no |
| <a name="input_domain_endpoint_options_enforce_https"></a> [domain\_endpoint\_options\_enforce\_https](#input\_domain\_endpoint\_options\_enforce\_https) | Whether or not to require HTTPS | `bool` | `true` | no |
| <a name="input_domain_endpoint_options_tls_security_policy"></a> [domain\_endpoint\_options\_tls\_security\_policy](#input\_domain\_endpoint\_options\_tls\_security\_policy) | The name of the TLS security policy that needs to be applied to the HTTPS endpoint. Valid values: `Policy-Min-TLS-1-0-2019-07` and `Policy-Min-TLS-1-2-2019-07` | `string` | `"Policy-Min-TLS-1-2-2019-07"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Name of the domain | `string` | n/a | yes |
| <a name="input_ebs_enabled"></a> [ebs\_enabled](#input\_ebs\_enabled) | Whether EBS volumes are attached to data nodes in the domain | `bool` | `true` | no |
| <a name="input_ebs_options"></a> [ebs\_options](#input\_ebs\_options) | EBS related options, may be required based on chosen instance size | `any` | `{}` | no |
| <a name="input_ebs_options_iops"></a> [ebs\_options\_iops](#input\_ebs\_options\_iops) | The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type | `number` | `0` | no |
| <a name="input_ebs_options_volume_size"></a> [ebs\_options\_volume\_size](#input\_ebs\_options\_volume\_size) | The size of EBS volumes attached to data nodes (in GB). Required if ebs\_enabled is set to true | `number` | `10` | no |
| <a name="input_ebs_options_volume_type"></a> [ebs\_options\_volume\_type](#input\_ebs\_options\_volume\_type) | The type of EBS volumes attached to data nodes | `string` | `"gp2"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Change to false to avoid deploying any AWS ElasticSearch resources | `bool` | `true` | no |
| <a name="input_encrypt_at_rest"></a> [encrypt\_at\_rest](#input\_encrypt\_at\_rest) | Encrypt at rest options. Only available for certain instance types | `any` | `{}` | no |
| <a name="input_encrypt_at_rest_enabled"></a> [encrypt\_at\_rest\_enabled](#input\_encrypt\_at\_rest\_enabled) | Whether to enable encryption at rest | `bool` | `true` | no |
| <a name="input_encrypt_at_rest_kms_key_id"></a> [encrypt\_at\_rest\_kms\_key\_id](#input\_encrypt\_at\_rest\_kms\_key\_id) | The KMS key id to encrypt the Elasticsearch domain with. If not specified then it defaults to using the aws/es service KMS key | `string` | `"alias/aws/es"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of OpenSearch to deploy. | `string` | `"2.7"` | no |
| <a name="input_log_publishing_options"></a> [log\_publishing\_options](#input\_log\_publishing\_options) | Options for publishing slow logs to CloudWatch Logs | `any` | `{}` | no |
| <a name="input_log_publishing_options_retention"></a> [log\_publishing\_options\_retention](#input\_log\_publishing\_options\_retention) | Retention in days for the created Cloudwatch log group | `number` | `60` | no |
| <a name="input_node_to_node_encryption"></a> [node\_to\_node\_encryption](#input\_node\_to\_node\_encryption) | Node-to-node encryption options | `any` | `{}` | no |
| <a name="input_node_to_node_encryption_enabled"></a> [node\_to\_node\_encryption\_enabled](#input\_node\_to\_node\_encryption\_enabled) | Whether to enable node-to-node encryption | `bool` | `true` | no |
| <a name="input_snapshot_options"></a> [snapshot\_options](#input\_snapshot\_options) | Snapshot related options | `any` | `{}` | no |
| <a name="input_snapshot_options_automated_snapshot_start_hour"></a> [snapshot\_options\_automated\_snapshot\_start\_hour](#input\_snapshot\_options\_automated\_snapshot\_start\_hour) | Hour during which the service takes an automated daily snapshot of the indices in the domain | `number` | `0` | no |
| <a name="input_vpc_options"></a> [vpc\_options](#input\_vpc\_options) | VPC related options, see below. Adding or removing this configuration forces a new resource | `any` | `{}` | no |
| <a name="input_vpc_options_security_group_ids"></a> [vpc\_options\_security\_group\_ids](#input\_vpc\_options\_security\_group\_ids) | List of VPC Security Group IDs to be applied to the Elasticsearch domain endpoints. If omitted, the default Security Group for the VPC will be used | `list(any)` | `[]` | no |
| <a name="input_vpc_options_subnet_ids"></a> [vpc\_options\_subnet\_ids](#input\_vpc\_options\_subnet\_ids) | List of VPC Subnet IDs for the Elasticsearch domain endpoints to be created in | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amazon Resource Name (ARN) of the domain |
| <a name="output_domain_id"></a> [domain\_id](#output\_domain\_id) | Unique identifier for the domain |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Domain-specific endpoint used to submit index, search, and data upload requests |
| <a name="output_kibana_endpoint"></a> [kibana\_endpoint](#output\_kibana\_endpoint) | Domain-specific endpoint for kibana without https scheme |
| <a name="output_master_password"></a> [master\_password](#output\_master\_password) | Master password |
| <a name="output_master_username"></a> [master\_username](#output\_master\_username) | Master username |
| <a name="output_vpc_options_availability_zones"></a> [vpc\_options\_availability\_zones](#output\_vpc\_options\_availability\_zones) | If the domain was created inside a VPC, the names of the availability zones the configured subnet\_ids were created inside |
| <a name="output_vpc_options_vpc_id"></a> [vpc\_options\_vpc\_id](#output\_vpc\_options\_vpc\_id) | If the domain was created inside a VPC, the ID of the VPC |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contribution & Issue Reporting

To report an issue with a project:

  1. Check the repository's [issue tracker](https://github.com/sq-ia/terraform-aws-opensearch/issues) on GitHub
  2. Search to see if the issue has already been reported
  3. If you can't find an answer to your question in the documentation or issue tracker, you can ask a question by creating a new issue. Be sure to provide enough context and details so others can understand your problem.

## License

Apache License, Version 2.0, January 2004 (http://www.apache.org/licenses/).

## Support Us

To support a GitHub project by liking it, you can follow these steps:

  1. Visit the repository: Navigate to the [GitHub repository](https://github.com/sq-ia/terraform-aws-opensearch).

  2. Click the "Star" button: On the repository page, you'll see a "Star" button in the upper right corner. Clicking on it will star the repository, indicating your support for the project.

  3. Optionally, you can also leave a comment on the repository or open an issue to give feedback or suggest changes.

Starring a repository on GitHub is a simple way to show your support and appreciation for the project. It also helps to increase the visibility of the project and make it more discoverable to others.

## Who we are

We believe that the key to success in the digital age is the ability to deliver value quickly and reliably. That’s why we offer a comprehensive range of DevOps & Cloud services designed to help your organization optimize its systems & Processes for speed and agility.

  1. We are an AWS Advanced consulting partner which reflects our deep expertise in AWS Cloud and helping 100+ clients over the last 5 years.
  2. Expertise in Kubernetes and overall container solution helps companies expedite their journey by 10X.
  3. Infrastructure Automation is a key component to the success of our Clients and our Expertise helps deliver the same in the shortest time.
  4. DevSecOps as a service to implement security within the overall DevOps process and helping companies deploy securely and at speed.
  5. Platform engineering which supports scalable,Cost efficient infrastructure that supports rapid development, testing, and deployment.
  6. 24*7 SRE service to help you Monitor the state of your infrastructure and eradicate any issue within the SLA.

We provide [support](https://squareops.com/contact-us/) on all of our projects, no matter how small or large they may be.

To find more information about our company, visit [squareops.com](https://squareops.com/), follow us on [Linkedin](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/), or fill out a [job application](https://squareops.com/careers/). You can also checkout our [Case-studies](https://squareops.com/case-studies/) or [Blogs](https://squareops.com/blog/) to understand more about our solutions. If you have any questions or would like assistance with your cloud strategy and implementation, please don't hesitate to [contact us](https://squareops.com/contact-us/).
