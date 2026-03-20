
# Load Balancer Security Group
resource "aws_security_group" "load_balancer_sg" {
  vpc_id      = var.vpc_id # References a variable or another resource's output


  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Default egress rule (ALLOW ALL) is automatically created by AWS within a VPC
  # Can be explicitly defined if needed.

  tags = {
    Name = "${var.name}-load-balancer-sg"
  }
}


# ECS Security Group
resource "aws_security_group" "ecs_sg" {
  vpc_id      = var.vpc_id # References a variable or another resource's output

  ingress {
    description = "HTTP from Load Balancer"
    from_port   = var.container_port # References a variable for the container port (e.g., 80)
    to_port     = var.container_port # References a variable for the container port (e.g., 80)
    protocol    = "tcp"
    security_groups = [aws_security_group.load_balancer_sg.id] # Allow traffic from Load Balancer SG
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-ecs-sg"
  }
}





# EC2 Security Group
resource "aws_security_group" "ec2_sg" {
  vpc_id      = var.vpc_id # References a variable or another resource's output

  ingress {
    description = "SSH from Internet"
    from_port   = var.container_port # References a variable for the container port (e.g., 22 for SSH)
    to_port     = var.container_port # References a variable for the container port (e.g., 80)
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1" # -1 means all protocols
      cidr_blocks = ["0.0.0.0/0"]
   
  }

   
    tags ={
      Name = "${var.name}-ec2-sg"
    }
}