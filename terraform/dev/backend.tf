terraform {
  backend "s3" {
    bucket = "chioma-project1-state"
    key    = "todo-app/ecs/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "ugochi-terraform-lock"
    encrypt = true
  }
}
