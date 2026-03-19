module "networking" {
  source                              =  "../modules/networking"
  name                                =  var.name
  vpc_cidr_block                      =  var.vpc_cidr_block
  public_subnet_cidr_block            =  var.public_subnet_cidr_block
  availability_zone                   =  var.availability_zone
  private_subnet_1_cidr_block         =  var.private_subnet_1_cidr_block
  private_subnet_2_cidr_block         =  var.private_subnet_2_cidr_block
}


module "SG" {
  source                             = "../modules/SG"
  name                               = var.name
  vpc_id                             = module.networking.vpc_id
}

module "ec2" {
  source                             = "../modules/ec2"
  instance_type                      = var.instance_type
  key_name                           = var.key_name
  public_subnet_id                   = module.networking.public_subnet_id
  sg_ids                             = [module.SG.sg_ids]
  name                               = var.name
  key_filename                       = var.key_filename
}

module "ecr" {
  source                             = "../modules/ecr"
  name                               = var.name
}

module "ecs" {
  source                             = "../modules/ecs"
  name                               = var.name
  ecr_repository_url                 = module.ecr.ecr_repository_url
  container_port                     = var.container_port
  aws_region                         = var.aws_region
  private_subnet_1_id                = module.networking.private_subnet_1_id
  private_subnet_2_id                = module.networking.private_subnet_2_id
  sg_ids                             = module.SG.sg_ids
}