# Deploying a Todo App on AWS ECS with EC2 Lauch Type

[![AWS ECS](https://img.shields.io/badge/AWS-ECS-blue.svg)](https://aws.amazon.com/ecs/)
[![Docker](https://img.shields.io/badge/Docker-Containerized-blue.svg)](https://www.docker.com/)
[![Terraform](https://img.shields.io/badge/Terraform-IaC-purple.svg)](https://www.terraform.io/)
[![CI/CD](https://img.shields.io/badge/CI%2FCD-CodePipeline-orange.svg)](https://aws.amazon.com/codepipeline/)

## 📖 Overview
This project demonstrates how to deploy a **containerized Python Flask Todo application** on **AWS ECS (EC2 launch type)**. The entire infrastructure is fully provisioned using **Terraform** and a **CI/CD pipeline** is set up using **AWS CodeBuild** and **CodePipeline** for automated building and deployments.

This is **Part 1** of my AWS ECS series where I document my hands-on juourney as an AWS Community Builder(Container Track).


## Brief Description

This project takes a simple Flask Todo app from local development to the cloud. It solves the classic **"but it works on my machine"** problem by showing how to consistently package and deploy applications using Docker containers and AWS ECS.

**Purpose**: To teach practical DevOps skills — containerization, Infrastructure as Code, and CI/CD — through a real, working example.


## Architectural Design of the Project
<img width="1337" height="1600" alt="ecs-ec2 deployment (2)" src="https://github.com/user-attachments/assets/008aa142-89a5-4907-81e4-feb273f34482" />



## 🚀 Features
- Python Flask Todo app with frontend REST API
- Contanerised with Docker and stored in AWS ECR
- Infrastructure provisioned with Terraform
- Deployed on AWS ECS with EC2 launch type
- CI/CD Pipeline with AWs Code Pipeline and Code Build
- Health check endpoint for ECS container monitoring

## 🛠  Tech Stack 

- **Backend**: Python + Flask
- **Container**: Docker
- **Registry**: Amazon ECR
- **Orchestration**: Amazon ECS (EC2 launch type)
- **IaC**: Terraform
- **CI/CD**: AWS CodeBuild + AWS CodePipeline
- **Version Control**: GitHub


## 📂 Repo Structure

```bash
todo-app/
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── templates/
│       └── index.html
├── Dockerfile
├── buildspec.yml
└── terraform/
    └── dev/                  # Development environment
        ├── main.tf
        ├── backend.tf
        └── ...
    └── modules/              # Reusable modules (networking, ecs, iam, etc.)
```

## Prerequisites

- AWS Account with appropriate IAM permissions
- AWS CLI configured
- Docker installed and running
- Terraform installed
- GitHub account + Personal Access Token (for CodePipeline)

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

## 🛠️ Troubleshooting
Here are the most common issues I encountered (and fixed):

- **"No Container Instances were found"**: EC2 instance not registered with ECS.  
  Fix: Use ECS-optimized AMI and ensure ECS Agent is running.

- **CodeBuild service quota error** (e.g., "Cannot have more than X active builds for the account"):  Build fails due to account-level concurrent build limits.  
  **Fix**: Go to the **AWS Service Quotas** console → Search for **CodeBuild** → Request an increase for "Concurrent running builds" (for your compute type, e.g., Linux Small/Medium).  

  I had to reach out to AWS Support for approval — it can take a few hours to a couple of days.


## 📚 Blog Post

This project is explained in detail here: [Hashnode](https://dhebbydavid.hashnode.dev/deploying-your-first-containerized-application-on-aws-ecs-part-1)

## 👤 Ugochi Deborah Ukaegbu, AWS Builders Community Programme (Containers Track)
