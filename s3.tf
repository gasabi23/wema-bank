resource "aws_s3_bucket" "s3_29" {
  bucket = "my-first-bucket-29x"

  tags = {
    Name = "mi1234"
    # Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "s3_29" {
  bucket = aws_s3_bucket.s3_29.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "versions" {
  bucket = aws_s3_bucket.s3_29.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}


resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.s3_29.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
