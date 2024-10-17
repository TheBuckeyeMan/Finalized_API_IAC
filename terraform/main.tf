resource "aws_s3_bucket" "new_bucket_provision" { 
  bucket = var.bucket_name #Update the bucket name in the variables/dev~local~prod!test.tfvars files
  tags = {
    Name = "New S3 Bucket Provision" # Can update the tage here
  }
}