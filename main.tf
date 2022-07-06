module "vpc" {
  source = "./modules/"
  name = var.name
  vpc_cidr = var.vpc_cidr

  availability_zone = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = ["10.0.1.0/24", "10.1.1.0/24"]
  public_subnets  = ["10.0.0.0/24", "10.1.0.0/24"]

}