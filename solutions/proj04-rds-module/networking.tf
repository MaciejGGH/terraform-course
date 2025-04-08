############################
# VPC and Subnet Creation
############################

data "aws_vpc" "default" {
  default = true
}

resource "aws_vpc" "custom" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "proj04-custom"
  }
}

moved {
  from = aws_subnet.allowed
  to   = aws_subnet.private1
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.custom.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name   = "proj04-custom-private1"
    Access = "Private"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.custom.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name   = "proj04-custom-private2"
    Access = "Private"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.custom.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name   = "proj04-custom-public1"
    Access = "Private"
  }
}

resource "aws_internet_gateway" "custom" {
  vpc_id = aws_vpc.custom.id

  tags = {
    Name = "proj04-custom-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.custom.id

  tags = {
    Name = "proj04-custom-public-rt"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.custom.id
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

# For documentation purposes only, this subnet is not used in the module
# resource "aws_subnet" "not_allowed" {
#   vpc_id     = data.aws_vpc.default.id
#   cidr_block = "172.31.128.0/24"

#   tags = {
#     Name = "proj04-not-allowed"
#   }
# }

############################
# Security Groups
############################

# 1. Source security group - From where connections are allowed into the DB
# 2. Compliant security group
# 2.1 Security group rule to allow traffic from source security group
# 3 Non-compliant security group
# 3.1 Security group rule

resource "aws_security_group" "source" {
  name        = "source-sg"
  description = "SG from where connections are allowed into the DB"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_security_group" "compliant" {
  name        = "compliant-sg"
  description = "SG that allows traffic from source security group"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_security_group" "non_compliant" {
  name        = "non-compliant-sg"
  description = "Non-compliant security group"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_vpc_security_group_ingress_rule" "db" {
  security_group_id            = aws_security_group.compliant.id
  referenced_security_group_id = aws_security_group.source.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.non_compliant.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

