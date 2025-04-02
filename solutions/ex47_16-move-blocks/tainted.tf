# resource "aws_s3_bucket" "tainted" {
#   bucket = "my-tainted-bucket-19384981jhahds3243242"
# }

# resource "aws_s3_bucket_public_access_block" "from_tainted" {
#   bucket = aws_s3_bucket.tainted.bucket

#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }