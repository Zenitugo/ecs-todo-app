# Deploying a Todo App on AWS ECS Using Terraform with EC2 Lauch Type

## 📖 Overview
This project demonstrates how to deploy a containerised Python Flask Todo application on AWS ECS using the EC2 launch type. The infrastructure is fully provisioned using Terraform and the CI/CD pipeline is managed using AWS CodePipeline and CodeBuild.

This is Part 1 of my ECS series where I document my hands-on juoutney as an AWS Community Builder

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
├── app.py                  # Flask application
├── requirements.txt        # Python dependencies
├── Dockerfile              # Container build instructions
├── buildspec.yml           # CodeBuild pipeline instructions
├── templates/
│   └── index.html         # Frontend HTML page
└── terraform/
    ├── backend.tf              # Remote state configuration
    ├── main.tf                 # Root module - calls all modules
    ├── variables.tf            # Root variables
    ├── outputs.tf              # Root outputs
    ├── terraform.tfvars        # Your actual variable values
    ├── provider.tf             # AWS provider
    └── modules/
        ├── ecr/
        │   ├── main.tf         # ECR repository
        │   ├── variables.tf
        │   └── outputs.tf
        ├── networking/
        │   ├── main.tf         # VPC, subnets, IGW, route tables
        │   ├── variables.tf
        │   └── outputs.tf
        ├── security/
        │   ├── main.tf         # Security groups
        │   ├── variables.tf
        │   └── outputs.tf
        ├── iam/
        │   ├── main.tf         # IAM roles and policies
        │   ├── variables.tf
        │   └── outputs.tf
        ├── ec2/
        │   ├── main.tf         # EC2 instance for ECS
        │   ├── variables.tf
        │   └── outputs.tf
        └── ecs/
            ├── main.tf         # ECS cluster, task definition, service
            ├── variables.tf
            └── outputs.tf 

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


## 🎥 Demo

- [Live Demo Link](#) (if deployed)
- [YouTube Walkthrough](#) (optional)

## 📚 Blog Post

This project is explained in detail here: [Blog Link](#)

## 👤 Ugochi Deborah Ukaegbu, AWS Builders Community Programme (Containers Track)