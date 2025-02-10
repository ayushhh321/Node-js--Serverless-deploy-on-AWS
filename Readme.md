# Pearl Deployment
                                                           

This repository contains Terraform configurations for deploying a Node.js application on AWS using ECS (Elastic Container Service) with Fargate, ALB (Application Load Balancer), and ECR (Elastic Container Registry). The deployment includes setting up the necessary IAM roles, security groups, VPC, subnets, and ECS services.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup](#setup)
  - [AWS IAM Roles and Policies](#aws-iam-roles-and-policies)
  - [Docker and ECR](#docker-and-ecr)
  - [Terraform Configuration](#terraform-configuration)
- [Deploying the Application](#deploying-the-application)
- [Testing the Deployment](#testing-the-deployment)
- [Cleanup](#cleanup)

## Prerequisites

- AWS account with appropriate permissions.
- AWS CLI installed and configured.
- Terraform installed.
- Docker installed.

## Setup

### AWS IAM Roles and Policies

#### Create IAM Roles:

- **ecsTaskExecutionRole**: This role is assumed by ECS tasks.

  - **Trust Relationship**:
    ```json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "ecs-tasks.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    ```

  - **Attached Policies**:
    - AmazonECSTaskExecutionRolePolicy
    - Custom inline policy to allow `iam:PassRole`:
      ```json
      {
          "Version": "2012-10-17",
          "Statement": [
              {
                  "Effect": "Allow",
                  "Action": "iam:PassRole",
                  "Resource": "arn:aws:iam::<AWS_ACCOUNT_ID>:role/ecsTaskExecutionRole"
              }
          ]
      }
      ```

#### Attach Policies to User:

- AdministratorAccess for full access.
- Custom inline policy AllowPassRoleForECS:
  ```json
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": "iam:PassRole",
              "Resource": "arn:aws:iam::<AWS_ACCOUNT_ID>:role/ecsTaskExecutionRole"
          }
      ]
  }


# Docker and ECR

## Build and Push Docker Image:

### Authenticate Docker with ECR:

```sh
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com
```
## Build Docker Image:

```sh
docker build -t app_repo .

```
## Tag and Push Docker Image to ECR:

```sh
docker tag app_repo:latest <AWS_ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/app_repo:latest
docker push <AWS_ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/app_repo:latest


```

# Terraform Configuration

## 1. vpc.tf
This file defines the network infrastructure, including the VPC, subnets, and security groups. It sets up a Virtual Private Cloud (VPC) with three subnets across different availability zones and configures security groups to manage inbound and outbound traffic.

## 2. repository.tf
This file sets up the Elastic Container Registry (ECR) for storing Docker images. It includes the necessary IAM policies and permissions to allow ECS tasks to pull images from the repository.

## 3. ecs.tf
This file configures the ECS cluster, task definitions, and services. It includes the setup for the ECS cluster, task definitions specifying the Docker image to use, and ECS services to manage the application deployment.

## 4. config.tf
This file sets up the Application Load Balancer (ALB), target groups, and listeners. It ensures the ECS service is accessible and properly routed through the ALB.

# Deploying the Application

## Initialize Terraform:

```sh
terraform init


```

## Plan the Deployment:

```sh
terraform plan


```

## Apply the Deployment:

```sh
terraform apply
terraform apply -auto-approve



```

# Testing the Deployment

After the terraform apply completes, note the DNS name of the ALB from the output. Open a web browser and navigate to the ALB DNS name to see your deployed application.

# Cleanup

To clean up the resources created by Terraform, run:
<<<<<<< HEAD

```sh
terraform destroy
```

## This README covers the setup, configuration, and deployment of the Node.js application on AWS ECS using Terraform. If you encounter any issues or have questions, feel free to open an issue or reach out for support.
=======

```sh
terraform destroy
```

This README covers the setup, configuration, and deployment of the Node.js application on AWS ECS using Terraform. If you encounter any issues or have questions, feel free to open an issue or reach out for support.

## Contribution

Contributions to this repository are welcome! If you have additional documentation, code examples, or tasks that you would like to share, feel free to submit a pull request.

## Feedback

Your feedback is valuable! If you have suggestions for improving existing content or ideas for new additions, please open an issue or reach out to the repository maintainers. If you have any other feedbacks, you can reach out to us at ayushguptab6@gmail.com or +91 7324829593


## Connect with Me
<p>

 <a href="https://x.com/hypo_sucks" target="blank"><img align="center" src="https://img.freepik.com/premium-vector/vector-new-twitter-x-white-logo-black-background_744381-866.jpg" alt="hypo_sucks" height="40" width="50" /></a>
  &nbsp;&nbsp;
  	<a href="https://www.linkedin.com/in/ayushhh321/" target="blank"><img align="center" src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/LinkedIn_logo_initials.png/800px-LinkedIn_logo_initials.png" alt="ayushhh321" height="40" width="40" /></a>
  &nbsp;&nbsp;
 <a href="https://instagram.com/ayushgupta.73" target="blank"><img align="center" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/768px-Instagram_logo_2016.svg.png" alt="ayushgupta.73" height="40" width="40" /></a>
