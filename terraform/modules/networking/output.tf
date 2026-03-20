output vpc_id {
  value       = aws_vpc.ecs_network.id
  description = "The ID of the VPC created for the ECS Todo App."
}


output public_subnet_id {
  value       = aws_subnet.ecs_public_subnet.id
  description = "The ID of the public subnet created for the ECS Todo App."
}

output private_subnet_1_id {
  value       = aws_subnet.ecs_private_subnet_1.id
  description = "The ID of the private subnet 1 created for the ECS Todo App."
}

output private_subnet_2_id {
  value       = aws_subnet.ecs_private_subnet_2.id
  description = "The ID of the private subnet 2 created for the ECS Todo App."
}
output  public_subnet_2_id {
  value       = aws_subnet.ecs_public_subnet_2.id
  description = "The ID of the public subnet 2 created for the ECS Todo App."
}
