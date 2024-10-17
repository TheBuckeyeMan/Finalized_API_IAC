output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  #Update new_bucket_provision if you update the aws resource name for s3
  value       = aws_s3_bucket.new_bucket_provision.arn
}

output "bucket_url" {
  description = "The URL of the S3 bucket"
  #Update new_bucket_provision if you update the aws resource name for s3
  value       = aws_s3_bucket.new_bucket_provision.bucket_domain_name
}