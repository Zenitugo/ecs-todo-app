resource "aws_security_group" "ecs_todo_app_sg" {
  vpc_id      = var.vpc_id # References a variable or another resource's output


  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Default egress rule (ALLOW ALL) is automatically created by AWS within a VPC
  # Can be explicitly defined if needed.

  tags = {
    Name = "${var.name}-sg"
  }
}
