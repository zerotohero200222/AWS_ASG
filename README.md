# 🚀 AWS Auto Scaling Group Infrastructure with Terraform & GitHub Actions

This repository automates the deployment of an AWS Auto Scaling Group (ASG) with Terraform, backed by an S3 remote backend and CI/CD enabled via GitHub Actions. It supports multiple environments (`dev`, `uat`, and `prod`) using environment-specific variable files (`.tfvars`).

---

---

## 🧩 Components Deployed

* **VPC** – A new isolated virtual network for your resources.
* **Subnet** – A public subnet inside the VPC.
* **Security Group** – Allows HTTP traffic on port 80.
* **Launch Template** – Launch configuration for EC2 instances.
* **Placement Group** – For clustering instances (used with supported instance types).
* **Auto Scaling Group (ASG)** – Manages scaling policies for EC2 instances.

---

## 🔄 Environments

You can deploy the infrastructure to the following environments using `.tfvars` files:

| Environment | Instance Type | AMI ID                  | AZ           | VPC CIDR      | Subnet CIDR   |
| ----------- | ------------- | ----------------------- | ------------ | ------------- | ------------- |
| dev         | `t3.micro`    | `ami-xxxxxxxxxxxxxxxxx` | `us-east-1a` | `10.0.0.0/16` | `10.0.1.0/24` |
| uat         | `t3.medium`   | `ami-xxxxxxxxxxxxxxxxx` | `us-east-1b` | `10.0.0.0/16` | `10.0.2.0/24` |
| prod        | `t3.large`    | `ami-xxxxxxxxxxxxxxxxx` | `us-east-1c` | `10.0.0.0/16` | `10.0.3.0/24` |

Modify the AMI IDs as per the AWS region you are deploying to.

---

## ☁️ Remote Backend

Terraform state is managed in a secure, versioned, and encrypted S3 bucket. If the bucket doesn't exist, GitHub Actions automatically creates it with:

* **Versioning** enabled
* **Server-side encryption (AES256)** enabled

---

## ⚙️ GitHub Actions CI/CD

A GitHub Actions workflow automatically runs on pushes to the `main` branch:

### Plan Job

* Initializes Terraform
* Creates the backend bucket (if missing)
* Generates a plan using the appropriate `.tfvars` file
* Uploads the plan artifact
* Adds a cost estimation summary to the GitHub UI

### Apply Job

* Requires manual approval (`dev-approval`)
* Downloads and applies the previously generated plan

---

## 🔐 Secrets Configuration

In your repository's **GitHub secrets**, configure:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`

These are injected into the workflow to authenticate Terraform with AWS.

---

## ✅ Prerequisites

* AWS account with access to create EC2, VPC, S3, etc.
* Terraform version ≥ 1.5.x
* GitHub repository with configured secrets
* IAM user/role with permissions for:

  * EC2 (including ASG, LT, PG, SG, Subnets, etc.)
  * S3 (create/manage buckets)
  * IAM (if needed for more advanced ASG scenarios)

---

## 🧪 How to Use

1. **Fork or Clone the repository.**
2. **Update AMI IDs** in `*.tfvars` according to your region.
3. **Commit and push** changes to the `main` branch.
4. **GitHub Actions** will:

   * Create a backend S3 bucket (if not already created)
   * Run `terraform plan`
   * Wait for manual approval before applying
5. **Approve** the `Terraform Apply` stage in GitHub Actions UI.
6. View the **outputs** to retrieve resources like VPC ID, Subnet ID, ASG name, etc.

---

## 🧼 Clean-Up

To remove the deployed infrastructure:

* Trigger a manual **destroy** workflow (if implemented)
* Or run `terraform destroy -var-file=environments/dev.tfvars` locally

---

## 📌 Notes

* Ensure you’re not exceeding AWS service limits (e.g., number of VPCs or EC2 quota).
* Placement groups require compatible instance types (e.g., `c5.large`, `m5.large`). Avoid unsupported types like `t2.micro` with `cluster` placement strategy.
* Cost estimation is static and based on AWS pricing at the time of writing.

