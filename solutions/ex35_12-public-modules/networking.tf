module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.5.3"

  name = "12-public-modules"
  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.azs.names
  private_subnets = ["10.0.0.0/24"]
  public_subnets  = ["10.0.128.0/24"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}