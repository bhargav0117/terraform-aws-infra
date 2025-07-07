provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.az
}


module "ec2" {
  source            = "./modules/ec2"
  ami_id            = "ami-0c101f26f147fa7fd"
  instance_type     = "t2.micro"
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  key_name          = "Rx-Learn"
  vpc_id            = module.vpc.vpc_id
  my_ip             = "76.117.112.106/32"
}

module "iam" {
  source = "./modules/iam"
}

module "cloudwatch" {
  source      = "./modules/cloudwatch"
  alarm_name  = "rxsense-bastion"
  instance_id = module.ec2.bastion_instance_id
}

module "cloudwatch_logs" {
  source = "./modules/cloudwatch_logs"
}
