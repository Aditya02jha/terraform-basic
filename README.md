# Terraform EC2 Setup

This project demonstrates how to use **Terraform** to provision an **EC2 instance** on **AWS**.

## Features

* Uses **Amazon Linux 2** AMI (most recent)
* Free-tier eligible **t2.micro** instance
* SSH key pair for secure access
* Configurable region and availability zone

## Prerequisites

* [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
* AWS CLI configured with credentials (`aws configure`)
* An existing AWS key pair (or create one in AWS console)

## Steps to Deploy

### 1. Clone the Repository

```bash
git clone <repo-url>
cd terraform-ec2-setup
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Validate the Configuration

```bash
terraform validate
```

### 4. Plan the Deployment

```bash
terraform plan
```

### 5. Apply the Configuration

```bash
terraform apply -auto-approve
```

### 6. Destroy Resources (when no longer needed)

```bash
terraform destroy -auto-approve
```

## Configuration Variables

* `instance_type` (default: `t2.micro`)
* `region` (default: `us-east-1`)
* `ami` (dynamically fetched using `data.aws_ami`)

## Common Issues

* **InvalidParameterCombination**: Ensure the instance type is **free-tier eligible** (`t2.micro`).
* **AMI not found**: Verify region and AMI filter.

## License

This project is licensed under the MIT License.
