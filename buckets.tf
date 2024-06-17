
resource "aws_s3_bucket" "private_bucket" {
  bucket = "jcabrera-private-bucket"
}

resource "aws_s3_bucket" "public_bucket" {
  bucket = "jcabrera-public-bucket"
}

resource "aws_s3_bucket_public_access_block" "pab_public" {
  bucket = aws_s3_bucket.public_bucket.id
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "private_bucket_policy" {
  bucket = aws_s3_bucket.private_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PrivateAll",
        Effect    = "Allow",
        Principal = "*",
        Action    = ["s3:*"],
        Resource  = "${aws_s3_bucket.private_bucket.arn}/*",
      },
    ],
  })
}

resource "aws_s3_bucket_policy" "public_bucket_policy" {
  bucket = aws_s3_bucket.public_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicAll",
        Effect    = "Allow",
        Principal = "*",
        Action    = ["s3:*"],
        Resource  = "${aws_s3_bucket.public_bucket.arn}/*",
      },
    ],
  })
}
