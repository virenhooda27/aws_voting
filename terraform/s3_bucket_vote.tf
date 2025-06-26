resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "vote_frontend" {
  bucket = "myvote-frontend-${random_id.suffix.hex}"

  tags = {
    Name        = "VoteFrontendBucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "vote_frontend" {
  bucket = aws_s3_bucket.vote_frontend.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "vote_frontend" {
  bucket                  = aws_s3_bucket.vote_frontend.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "vote_frontend" {
  bucket = aws_s3_bucket.vote_frontend.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.vote_frontend.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid       = "PublicReadGetObject",
      Effect    = "Allow",
      Principal = "*",
      Action    = "s3:GetObject",
      Resource  = "${aws_s3_bucket.vote_frontend.arn}/*"
    }]
  })
}

resource "aws_s3_object" "vote_html" {
  bucket       = aws_s3_bucket.vote_frontend.id
  key          = "index.html"
  source       = "../index.html"
  content_type = "text/html"
}