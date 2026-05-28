output "bucket_name" {
  description = "Nome do bucket S3 criado"
  value       = aws_s3_bucket.site.id
}

output "bucket_arn" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.site.arn
}

output "cloudfront_id" {
  description = "ID da distribuição CloudFront"
  value       = aws_cloudfront_distribution.site.id
}

output "cloudfront_domain" {
  description = "URL pública do site via CloudFront"
  value       = "https://${aws_cloudfront_distribution.site.domain_name}"
}
