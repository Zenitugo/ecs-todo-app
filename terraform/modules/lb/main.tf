# Load balancer Creation

resource "aws_lb" "ecs_lb" {
  name               = "${var.name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.load_balancer_sg_ids]
  subnets            = [var.public_subnet_id,
                        var.public_subnet_id_2]


    tags = {
        Name = "${var.name}-lb"
    }
}


# Target Group Creation
resource "aws_lb_target_group" "public_tg" {
  name        = "${var.name}-tg"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
    matcher             = "200"
  }
}


# Listener Creation
resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.ecs_lb.arn 
  port                = 80
  protocol            = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.public_tg.arn
    type             = "forward"
  }
}