resource "aws_ecr_repository" "zenny_ecr_repo" {
  name = "${var.name}-repo"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = "Development"
  }
}
