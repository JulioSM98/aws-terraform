
output "bucket_regional_domain_name" {
  value = {
    for k, v in aws_s3_bucket.this : k => v.bucket_regional_domain_name
  }
}

output "bucket" {
  value = {
    for k, v in aws_s3_bucket.this : k => v.bucket
  }
}