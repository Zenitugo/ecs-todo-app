# Create ECS Cluster
resource "aws_ecs_cluster" "todo_app_cluster" {
  name = "${var.name}-cluster"
}



# Create ECS Task Definition
resource "aws_ecs_task_definition" "todo_app_task" {
  family                   = "${var.name}-task"
  container_definitions    = templatefile("${path.module}/container_definitions.json")
  requires_compatibilities = ["EC2"]
  network_mode             = "awsVPC"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = "256"
  memory                   = "512"

  depends_on = [aws_ecs_cluster.todo_app_cluster,
                 aws_iam_role.ecs_task_execution_role]
}       


# Create ECS Service
resource "aws_ecs_service" "todo_app_service" {
  name            = "${var.name}-service"
  cluster         = aws_ecs_cluster.todo_app_cluster.id
  task_definition = aws_ecs_task_definition.todo_app_task.arn
  desired_count   = 2
  
  network_configuration {
    subnets         = [var.private_subnet_1_id, 
                      var.private_subnet_2_id]
    security_groups = [var.ecs_sg_ids]
    assign_public_ip = false
  }
  depends_on      = [aws_ecs_task_definition.todo_app_task]
}