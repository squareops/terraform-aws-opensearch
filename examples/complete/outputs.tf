output "domain_arn" {
  description = "Amazon Resource Name (ARN) of the domain"
  value       = module.aws_opensearch.domain_arn
}

output "domain_id" {
  description = "Unique identifier for the domain"
  value       = module.aws_opensearch.domain_id
}

output "domain_endpoint" {
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
  value       = module.aws_opensearch.domain_endpoint
}

output "dashboard_endpoint" {
  description = "Domain-specific endpoint for opensearch without https scheme"
  value       = module.aws_opensearch.dashboard_endpoint
}

output "master_username" {
  description = "Master username"
  value       = module.aws_opensearch.master_username
}

output "master_password" {
  description = "Master password"
  value       = nonsensitive(module.aws_opensearch.master_password)
}
