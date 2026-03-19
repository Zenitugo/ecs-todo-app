output sg_ids{
  value       = aws_security_group.ecs_todo_app_sg.id
  description = "The name of the security group created for the ECS Todo App."
}
