# Create ECS Cluster
resource "aws_ecs_cluster" "todo_app_cluster" {
  name = "${var.name}-cluster"
}



# Create ECS Task Definition
resource "aws_ecs_task_definition" "todo_app_task" {
  family                   = "${var.name}-task"
  container_definitions    = templatefile("${path.module}/container_definition.json.tpl", {
    name           = "${var.name}-container",
    image          = var.ecr_repository_url,
    container_port = var.container_port
    aws_region     = var.aws_region
  })
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role_arn
  cpu                      = "256"
  memory                   = "512"

  depends_on = [aws_ecs_cluster.todo_app_cluster,]
}       


# Create ECS Service
resource "aws_ecs_service" "todo_app_service" {
  name            = "${var.name}-service"
  cluster         = aws_ecs_cluster.todo_app_cluster.id
  task_definition = aws_ecs_task_definition.todo_app_task.arn
  desired_count   = var.desired_count
  
  network_configuration {
    subnets         = [var.private_subnet_1_id, 
                      var.private_subnet_2_id]
    security_groups = [var.ecs_sg_ids]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "${var.name}-container"
    container_port   = var.container_port
  }

  depends_on      = [aws_ecs_task_definition.todo_app_task]
}