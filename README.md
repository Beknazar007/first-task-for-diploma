Plan your life ,  eat elephant in pieces , achieve  goals  and your dreams will come true.
![asdf](./images/screen1.png)
![asdf](./images/screen2.png)

It saves in local storage that informations which we enter.

[![Watch the video](https://i.imgur.com/vKb2F1B.png)](https://drive.google.com/file/d/1bHMKIrh9imdWEIhAKnLCv0IiCpSp53Fl/view?usp=sharing)




# CI/CD Pipeline Setup Documentation:
[Infrastructure as Code](Terraform/readme.md) 
[Outputs of the pipelines](https://github.com/Beknazar007/first-task-for-diploma/actions) 


## Docker Build, Push, and Update EKS Deployment Pipeline Documentation

This document provides an overview and explanation of the CI/CD pipeline named "Docker Build, Push, and Update EKS Deployment" used for building Docker images, pushing them to Docker Hub, and updating deployments in an AWS EKS cluster. 

### Overview

The purpose of this pipeline is to automate the process of building Docker images, pushing them to a Docker Hub repository, and updating Kubernetes deployments in an AWS EKS cluster with the new images. 

### Trigger

This pipeline is triggered by GitHub push events to the main branch, specifically when changes occur in the `htmls/` folder. Additionally, it can be manually triggered using the workflow dispatch event.

### Prerequisites

- Access to GitHub repository.
- Docker Hub account for storing Docker images.
- AWS account with appropriate permissions.
- AWS EKS cluster set up in the desired region.
## Jobs and Steps
### Build and Deploy Job

1. **Checkout code**: Checks out the code from the GitHub repository.

2. **Login to Docker Hub**: Uses the Docker login action to authenticate with Docker Hub using the provided credentials stored as secrets.

3. **Build and tag Docker image**: Builds the Docker image using the Dockerfile in the repository and tags it with the GitHub commit SHA. Then, pushes the image to Docker Hub.

4. **Configure AWS credentials**: Uses the AWS configure action to set up AWS credentials for accessing AWS services, including EKS.

5. **Update Kubernetes deployment**: Updates the Kubernetes deployment in the AWS EKS cluster with the new Docker image. It first updates the kubeconfig to access the EKS cluster, then sets the new image for the deployment using kubectl, and finally waits for the rollout to complete.

## Security Considerations

- Docker Hub credentials and AWS credentials are stored as GitHub secrets to ensure secure authentication.
- Access to AWS resources is restricted based on IAM permissions to minimize security risks.

# Terraform Infrastructure Provisioning Pipeline Documentation

This document provides an overview and explanation of the Terraform pipeline used for provisioning infrastructure on AWS using Terraform scripts.

## Overview

The purpose of this pipeline is to automate the process of provisioning infrastructure on AWS using Terraform scripts. It includes steps for initializing Terraform, planning changes, and applying those changes to create or update resources on AWS.

## Trigger

This pipeline can be manually triggered using the workflow dispatch event.

## Prerequisites

- Access to GitHub repository containing Terraform scripts.
- AWS account with appropriate permissions.
- Terraform CLI installed locally.

## Jobs and Steps

### Terraform Job

1. **Checkout code**: Checks out the Terraform scripts from the GitHub repository.

2. **Set up Terraform**: Uses the HashiCorp setup Terraform action to set up the specified version of Terraform for the job.

3. **Terraform Init**: Initializes Terraform in the working directory to prepare for creating the execution plan.

4. **Terraform Plan**: Generates an execution plan for Terraform to create, modify, or delete infrastructure resources. The plan is saved to a JSON file for further processing.

5. **Display Terraform Plan**: Displays the contents of the Terraform plan to review the proposed changes before applying them.

6. **Terraform Apply**: Applies the Terraform plan to create or update infrastructure resources on AWS. The changes are automatically approved using the `-auto-approve` flag.

## Security Considerations

- AWS credentials used by Terraform are stored securely in GitHub secrets.
- Access to AWS resources is restricted based on IAM permissions to minimize security risks.

## Troubleshooting

- If the Terraform apply step fails, check the Terraform plan and error messages for any issues.
- Verify AWS credentials and permissions if there are issues with accessing AWS services.

## Future Improvements

- Implement infrastructure state management using a remote backend for better collaboration and state tracking.
- Integrate with Terraform Cloud or Terraform Enterprise for enhanced features such as remote execution and collaboration.
- Enhance error handling and notifications for better pipeline monitoring.


