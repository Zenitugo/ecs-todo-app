
# Create ECS Instance Role
resource "aws_iam_role" "ecs_instance_role" {
  name_prefix        = "ecs-instance-role-"
  assume_role_policy = data.aws_iam_policy_document.ecs_instance_assume_role.json
}


# Attach AWS Managed Policy for ECS EC2 instances to the Role

resource "aws_iam_role_policy_attachment" "ecs_instance_role_attachment" {
  role       = aws_iam_role.ecs_instance_role.name
  # AWS Managed Policy for ECS EC2 instances
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role" 
}

# IAM instance profile Created for ECS Instance Role
resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name_prefix = "ecs-instance-profile-"
  role        = aws_iam_role.ecs_instance_role.name
}





# Create Code Build Role
resource "aws_iam_role" "codebuild_service_role" {
  name_prefix        = "codebuild-service-role-"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role.json
}




resource "aws_iam_role_policy" "codebuild_policy_attachment" {
  name = "codebuild_execution_policy"
  role = aws_iam_role.codebuild_service_role.id
  policy = data.aws_iam_policy_document.codebuild_policy.json
}


# ECS execution role for ECS tasks to pull images from ECR and send logs to Cloud Watch
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}




# Attach AWS Managed Policy for ECS Task Execution to the Role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

  depends_on = [aws_iam_role.ecs_task_execution_role]
}



