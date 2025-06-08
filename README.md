# Automated AWS Minecraft Server Deployment Tutorial:
This project demonstrates how to fully automate the provisioning and configuration of a Minecraft server on AWS using Terraform, Ansible, and GitHub Actions. The infrastructure is codified and version-controlled, enabling reliable, repeatable deployments.

## Requirements:
To follow this tutorial or reuse this project, you’ll need:

* An AWS account with permissions to manage EC2, VPC, IAM, and S3.
* A GitHub repository to store and trigger your deployment pipeline (you can fork this repository).
* Basic knowledge of Terraform, Ansible, and GitHub Actions.

### Required Tools:
Install the following tools locally if you intend to test or deploy manually:

* Terraform (v1.5 or higher)
* Ansible (v2.10+)
* AWS CLI
* Python 3 (for Ansible compatibility)
* ssh (to connect to EC2 if needed)

### Actions/Github Environment Setup:
To automate deployments, GitHub Actions is used as a CI/CD pipeline:

1. Set the following secrets in your GitHub repository under Settings > Secrets > Actions:

    * `AWS_ACCESS_KEY_ID`
    * `AWS_SECRET_ACCESS_KEY`
    * `TF_VAR_key_pair_name (must match the name of your EC2 key pair in AWS)`
    * `TF_VAR_public_key (your SSH public key)`

2. A GitHub Actions workflow (.github/workflows/stand-on-push.yml) triggers on every push to the main branch. It:

    * Initializes Terraform
    * Provisions infrastructure
    * Runs Ansible over SSH to configure the server

### Configuring AWS Credentials & Remote Terraform State:
Answer

## Deployment Pipeline:
Answer

### Diagram:
Answer

## Deployment:
Answer

### How to and stuff:
Answer

### Connecting to the Minecraft Server Post Deployment:
Answer

## FAQs:

### Where is this?:
Answer
