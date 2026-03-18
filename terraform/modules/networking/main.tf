
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

# This resource creates a public subnet for the VPC.
resource "aws_subnet" "ecs_public_subnet" {
  vpc_id            = aws_vpc.ecs_network.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

    tags = {
        Name = "${var.name}-public-subnet"
    }
}

# This resource creates a route table for the public subnet.
resource "aws_route_table" "ecs_public_rt" {
  vpc_id = aws_vpc.ecs_network.id   

    tags = {
        Name = "${var.name}-public-rt"
    }
}

# This resource associates the public subnet with the route table.
resource "aws_route_table_association" "ecs_public_rt_assoc" {
  subnet_id      = aws_subnet.ecs_public_subnet.id
  route_table_id = aws_route_table.ecs_public_rt.id     
}