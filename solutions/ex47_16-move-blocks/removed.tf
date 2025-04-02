# resource "aws_s3_bucket" "random" {
#     bucket = "some-random-name-4379859843u"
# }

removed {
  from = aws_s3_bucket.random
  lifecycle {
    destroy = true
  }
}

removed {
  from = aws_s3_bucket.tainted
  lifecycle {
    destroy = true
  }
}

