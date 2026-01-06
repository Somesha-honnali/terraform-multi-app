🚀 Terraform EC2 IaC – Dockerized Nginx App

This project demonstrates Infrastructure as Code (IaC) using Terraform to provision an AWS EC2 instance and automatically deploy a Dockerized Nginx application using a bootstrapping script (user_data).

The goal is to eliminate manual EC2 creation in the AWS console and replace it with repeatable, version-controlled infrastructure.
.

🎯 What This Project Demonstrates

Terraform fundamentals on AWS (providers, data sources, resources, outputs)

Dynamic AMI selection (latest Ubuntu 22.04)

Secure networking using Security Groups

Automated EC2 provisioning

Bootstrapping with user_data

Docker installation and container deployment

Full Terraform lifecycle management

Clean teardown for cost control

🧱 Project Structure
terraform-ec2/
├── main.tf          # Core Terraform configuration
├── README.md        # Project documentation
├── .gitignore       # Terraform and state exclusions
└── docs/            # Screenshots and notes

⚙️ How It Works
Infrastructure Definition

AWS provider configured for a specific region

Latest Ubuntu 22.04 AMI fetched dynamically

Security Group allows:

SSH (22)

HTTP (80)

EC2 instance (t2.micro) created with tags
user_data script runs on first boot

Bootstrapping with user_data

On instance launch, the script:

Updates system packages

Installs Docker

Starts and enables Docker

Pulls somesha/nginx-app:latest from Docker Hub

Runs the container on port 80

🛠️  Prerequisites

AWS account

IAM user with EC2 and Security Group permissions

AWS CLI configured (aws configure)

Terraform CLI (v1.x)

Git & GitHub account

Docker image available on Docker Hub:
somesha/nginx-app:latest

Usage
1️⃣ Initialize Terraform
terraform init
2️⃣ Format and Validate
terraform fmt
terraform validate
3️⃣ Preview Infrastructure
terraform plan
4️⃣ Apply (Create Resources)
terraform apply
# Type 'yes' when prompted
Access the application:

http://<public_ip>
5️⃣ Inspect State
terraform show
terraform state list

## Screenshots
![Terraform Plan](docs/terraform-plan.png)
![EC2 Live](docs/ec2-site.png)
![Docker Running](docs/docker-ps.png)

## Destroy (Cost Control)
terraform destroy
