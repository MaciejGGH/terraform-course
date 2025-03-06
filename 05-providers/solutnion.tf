terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"

    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
  alias  = "aws-eu"
}

provider "aws" {
  region = "us-east-1"
  alias  = "aws-us"
}

resource "random_id" "us_bucket_suffix" {
  byte_length = 6
}

resource "random_id" "eu_bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "example_us_bucket" {
  bucket = "example-bucket-${random_id.us_bucket_suffix.hex}"
  provider=aws.aws-us
}

resource "aws_s3_bucket" "example_eu_bucket" {
  bucket = "example-bucket-${random_id.eu_bucket_suffix.hex}"
  provider = aws.aws-eu
}