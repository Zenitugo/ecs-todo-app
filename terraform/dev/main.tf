module "networking" {
  source                              =  "../modules/networking"
  name                                =  var.name
  vpc_cidr_block                      =  var.vpc_cidr_block
  public_subnet_cidr_block            =  var.public_subnet_cidr_block
  availability_zone                   =  var.availability_zone
}