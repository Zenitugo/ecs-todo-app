output load_balancer_sg_ids{
  value       = aws_security_group.load_balancer_sg.id
  description = "The name of the security group created for the ECS Todo App."
}



output ecs_sg_ids{
  value       = aws_security_group.ecs_sg.id
  description = "The name of the security group created for the ECS Todo App."
}

output ec2_sg_ids{
  value       = aws_security_group.ec2_sg.id
  description = "The name of the security group created for the ECS Todo App."
}