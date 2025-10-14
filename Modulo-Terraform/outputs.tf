output "bucket_id" {
  value       = module.s3.bucket_id
  sensitive   = false
  description = "ID do Bucket"
}

output "cdn_id" {
  value       = module.cloudfront.cdn_id
  sensitive   = false
  description = "ID do CDN"
}