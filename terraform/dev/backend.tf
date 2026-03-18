terraform {
  backend "s3" {
    bucket = "ugochi-terraform-state"
    key    = "todo-app/ecs/terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "ugochi-terraform-lock"
    encrypt = true
  }
}
