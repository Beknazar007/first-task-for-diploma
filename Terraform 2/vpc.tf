module "vpc" {
  source                    = "./vpc"
  name                      = var.vpc_name
  region                    = var.aws_region
  environment               = var.environment
  network_cidr              = var.vpc_network_cidr
  eks_subnet_name           = ["eks-primary"]
  eks_subnet_cidr           = ["${cidrsubnet(var.vpc_network_cidr, 4, 5)}", "${cidrsubnet(var.vpc_network_cidr, 4, 13)}"]
  public_subnets_cidr       = ["${cidrsubnet(var.vpc_network_cidr, 4, 7)}", "${cidrsubnet(var.vpc_network_cidr, 4, 15)}"]
  zones                   = var.resource_availability_zones
  azs                     = length(var.resource_availability_zones)
  enable_nat_gateway      = true
  create_internet_gateway = true

}
