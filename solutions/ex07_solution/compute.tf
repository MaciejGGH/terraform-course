data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/*amd64*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# data "aws_vpc" "prod_vpc" {
#   tags = {
#     Env = "Prod"
#   }
# }

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_iam_policy_document" "static_website" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]

    resources = ["arn:aws:s3:::*/*"]
  }
}

output "iam_policy" {
  value = data.aws_iam_policy_document.static_website.json
}

output "zones" {
  value = data.aws_availability_zones.available.names
}

# output "prod_vpc" {
#   value = data.aws_vpc.prod_vpc
# }

output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu_ami.id
}

output "ubuntu_ami_name" {
  value = data.aws_ami.ubuntu_ami.name
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

output "aws_region" {
  value = data.aws_region.current
}

resource "aws_instance" "web" {
  # AMI ID NGINX  = ami-0dfee6e7eb44d480b
  ami                         = data.aws_ami.ubuntu_ami.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
}