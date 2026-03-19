module "networking" {
  source                              =  "../modules/networking"
  name                                =  var.name
  vpc_cidr_block                      =  var.vpc_cidr_block
  public_subnet_cidr_block            =  var.public_subnet_cidr_block
  availability_zone                   =  var.availability_zone
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