resource "aws_s3_bucket" "logs" {
  bucket = "ugochi-app-logs"
  force_destroy = true # Use with caution in production environments

  tags = {
    Name        = "${var.name}-logs"
    Environment = "dev"
  }
}


# Activate public access block to prevent public access to the bucket
resource "aws_s3_bucket_public_access_block" "logs" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# Enable versioning for the bucket to protect against accidental deletions
resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id            
    versioning_configuration {
        status = "Enabled"
    }

}

# Enable server-side encryption for the bucket to protect data at rest
resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Set up lifecycle rules to automatically delete old logs after a certain period
resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id     = "log-expiration"
    status = "Enabled"

    expiration {
      days = 30
          } 
  }

}