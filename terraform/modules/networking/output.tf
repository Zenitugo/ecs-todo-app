output vpc_id {
  value       = aws_vpc.ecs_network.id
  description = "The ID of the VPC created for the ECS Todo App."
}


output public_subnet_id {
  value       = aws_subnet.ecs_public_subnet.id
  description = "The ID of the public subnet created for the ECS Todo App."
}