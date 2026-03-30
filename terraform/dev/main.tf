module "networking" {
  source                              =  "../modules/networking"
  name                                =  var.name
  vpc_cidr_block                      =  var.vpc_cidr_block
  public_subnet_cidr_block            =  var.public_subnet_cidr_block
  private_subnet_1_cidr_block         =  var.private_subnet_1_cidr_block
  private_subnet_2_cidr_block         =  var.private_subnet_2_cidr_block
  public_subnet_cidr_block_2          =  var.public_subnet_cidr_block_2
}


module "SG" {
  source                             = "../modules/SG"
  name                               = var.name
  vpc_id                             = module.networking.vpc_id
  container_port                     = var.container_port
}

module "ec2" {
  source                             = "../modules/ec2"
  instance_type                      = var.instance_type
  key_name                           = var.key_name
  private_subnet_1_id                = module.networking.private_subnet_1_id
  ec2_sg_ids                         = module.SG.ec2_sg_ids
  name                               = var.name
  key_filename                       = var.key_filename
  ec2_instance_profile_name          = module.iam.ec2_instance_profile_name
  cluster_name                       = module.ecs.cluster_name

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
  ecs_sg_ids                         = module.SG.ecs_sg_ids
  target_group_arn                   = module.lb.target_group_arn
  execution_role_arn                 = module.iam.execution_role_arn
  desired_count                      = var.desired_count
}

module "lb" {
  source                             = "../modules/lb"
  name                               = var.name
  public_subnet_id                   = module.networking.public_subnet_id
  load_balancer_sg_ids               = module.SG.load_balancer_sg_ids
  container_port                     = var.container_port
  vpc_id                             = module.networking.vpc_id
  public_subnet_id_2                 = module.networking.public_subnet_2_id
}

module "iam" {
  source                             = "../modules/iam"
  bucket_name                        = module.s3.bucket_name
  region                             = var.aws_region
  ecr_repository_name                = module.ecr.ecr_repository_name
  cluster_name                       = module.ecs.cluster_name
  service_name                       = module.ecs.service_name
}

module "s3" {
  source                             = "../modules/s3"
  name                               = var.name
}