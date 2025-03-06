data "aws_ami" "ubuntu" {
  # This data source retrieves the most recent Ubuntu 22.04 LTS AMI for the specified region.
  most_recent = true
  owners      = ["099720109477"] # Owner is Canonical

  filter {
    name = "name"
    # Filters the AMIs by name, looking for Ubuntu 22.04 server images.
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    # Filters the AMIs by virtualization type, selecting only HVM (Hardware Virtual Machine) images.
    values = ["hvm"]
  }
}

# resource "aws_instance" "compute" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.ec2_instance_type

#   #   root_block_device {
#   #     delete_on_termination = true
#   #     volume_size           = var.ec2_volume_size
#   #     volume_type           = var.ec2_volume_type
#   #   }
#   root_block_device {
#     delete_on_termination = true
#     volume_size           = var.ec2_volume_config.size
#     volume_type           = var.ec2_volume_config.type
#   }

#   tags = merge(local.common_tags, var.additional_tags)
# }


