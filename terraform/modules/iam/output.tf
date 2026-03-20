output "ec2_instance_profile_name" {   
  value = aws_iam_instance_profile.ecs_instance_profile.id
}


output "execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

