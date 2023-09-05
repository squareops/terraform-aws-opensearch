output "domain_arn" {
  description = "Amazon Resource Name (ARN) of the domain"
  value       = join("", aws_opensearch_domain.os_domain.*.arn)
}

output "domain_id" {
  description = "Unique identifier for the domain"
  value       = join("", aws_opensearch_domain.os_domain.*.domain_id)
}

output "domain_endpoint" {
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
  value       = join("", aws_opensearch_domain.os_domain.*.endpoint)
}

output "dashboard_endpoint" {
  description = "Domain-specific dashboard endpoint for opensearch without https scheme"
  value       = format("%s/_dashboards", "${aws_opensearch_domain.os_domain.*.endpoint[0]}")
}

output "master_username" {
  description = "Master username"
  value       = aws_opensearch_domain.os_domain[0].advanced_security_options[0].master_user_options[0].master_user_name
}

output "master_password" {
  description = "Master password"
  value       = aws_opensearch_domain.os_domain[0].advanced_security_options[0].master_user_options[0].master_user_password
}