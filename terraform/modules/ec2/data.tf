# ECS-optimized Amazon Linux 2 AMI
data "aws_ami" "ecs_ami" {
  most_recent = true

  owners = ["amazon"] # Amazon

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}









# data "aws_ami" "ubuntu" {
#   most_recent = true

#   owners = ["099720109477"] # Canonical

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/*/ubuntu-noble-24.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }
# }

