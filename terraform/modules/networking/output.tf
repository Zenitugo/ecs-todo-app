output vpc_id {
  value       = aws_vpc.ecs_network.id
  description = "The ID of the VPC created for the ECS Todo App."
}