# Deploying a Todo App on AWS ECS with EC2 Lauch Type

## 📖 Overview
This project demonstrates how to deploy a containerised Python Flask Todo application on AWS ECS using the EC2 launch type. The infrastructure is fully provisioned using Terraform and the CI/CD pipeline is managed using AWS CodePipeline and CodeBuild.

This is Part 1 of my ECS series where I document my hands-on juourney as an AWS Community Builder

## Brief description of the project, its purpose, and what problem it solves.

## 🚀 Features
- Python Flask Todo app with frontend REST API
- Contanerised with Docker and stored in AWS ECR
- Infrastructure provisioned with Terraform
- Deployed on AWS ECS with EC2 launch type
- CI/CD Pipeline with AWs Code Pipeline and Code Build
- Health check endpoint for ECS container monitoring

## 🛠 Tech Stack

- Python(Flask)
- Docker
- AWS ECR
- AWS ECS
- Terraform
- AWS Code Build
- AWS Code Pipeline
- Github

## 📂 Repo Structure

```
todo-app/
├── Readme.md
├── app
│   ├── Dockerfile
│   ├── app.py
│   ├── buildspec.yml
│   ├── requirements.txt
│   └── templates
│       └── index.html
└── terraform
    ├── dev
    │   ├── backend.tf
    │   ├── ecs-todo-app-key.pem
    │   ├── main.tf
    │   ├── provider.tf
    │   ├── terraform.tfvars
    │   └── variable.tf
    └── modules
        ├── SG
        │   ├── main.tf
        │   ├── output.tf
        │   └── variable.tf
        ├── ec2
        │   ├── data.tf
        │   ├── main.tf
        │   └── variable.tf
        ├── ecr
        │   ├── main.tf
        │   ├── output.tf
        │   └── variable.tf
        ├── ecs
        │   ├── container_definition.json.tpl
        │   ├── main.tf
        │   ├── output.tf
        │   └── variable.tf
        ├── iam
        │   ├── data.tf
        │   ├── main.tf
        │   ├── output.tf
        │   └── variable.tf
        ├── lb
        │   ├── main.tf
        │   ├── output.tf
        │   └── variable.tf
        ├── networking
        │   ├── data.tf
        │   ├── main.tf
        │   ├── output.tf
        │   └── variable.tf
        └── s3
            ├── main.tf
            ├── output.tf
            └── variable.tf

```

## ⚙️ Setup Instructions

1. Clone the repo
```bash
git clone https://github.com/Zenitugo/ecs-todo-app.git
cd ecs-todo-app
```


2. Test the app locally
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python3 app.py
```

3. Build and test Docker image locally
```bash
docker build -t todo-app .
docker run -p 5000:5000 todo-app
```

4. Provision AWS Infrastructure
```bash
cd terraform/dev 
terraform init 
terraform plan -var-file="terraform.tfvars" 
terraform apply -auto-approve

# To destroy the infrastructure
terraform destroy -auto-approve
```

5. Set up Amazon CodeBuild and CodePipeline in the AWS Console.

## 🎥 Demo

- [YouTube Walkthrough](#) (optional)

## 📚 Blog Post

This project is explained in detail here: [Blog Link](#)

## 👤 Ugochi Deborah Ukaegbu, AWS Builders Community Programme (Containers Track)