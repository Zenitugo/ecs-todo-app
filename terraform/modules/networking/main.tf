
# This resource creates a VPC for the ECS Todo App.
resource "aws_vpc" "ecs_network" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}


# This resource creates an Internet Gateway for the VPC.
resource "aws_internet_gateway" "ecs_igw" {
  vpc_id = aws_vpc.ecs_network.id
    tags = {
        Name = "${var.name}-igw"
    }
}


