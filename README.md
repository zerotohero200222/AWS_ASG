# AWS_ASG
Here’s a complete `README.md` file tailored to your Terraform project, which deploys an Auto Scaling Group with a Placement Group on AWS using GitHub Actions for CI/CD. The destroy step is **intentionally omitted** from the workflow as per your request.

---

## 📘 Terraform AWS Auto Scaling Group Deployment

This project provisions an **Auto Scaling Group** (ASG) on AWS with a **Placement Group** and related infrastructure using **Terraform**. The deployment is automated through a **CI/CD pipeline** with GitHub Actions.

---

### ✅ Features

* Creates a VPC, subnets, route tables
* Creates a Placement Group
* Deploys an Auto Scaling Group using Launch Template
* Automatically applies configuration using GitHub Actions
* Access logging via S3 for Load Balancer (if included)
* Configurable via input variables

---

### 🧪 Prerequisites

* AWS CLI configured
* Terraform CLI installed (>= v1.2)
* GitHub repository with secrets:

  * `AWS_ACCESS_KEY_ID`
  * `AWS_SECRET_ACCESS_KEY`
  * (optional) `AWS_REGION` (default: `us-east-2`)

---

### 🚀 Setup & Usage

#### 1. Clone the repository

```bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
```

#### 2. Initialize Terraform

```bash
terraform init
```

#### 3. Plan and Apply

```bash
terraform plan -out=tfplan
terraform apply tfplan
```

> 💡 This manually deploys the infrastructure.

---

### 🤖 CI/CD Pipeline with GitHub Actions

A GitHub Actions workflow is set up to automatically deploy your Terraform code on push to `main`.

**Path:** `.github/workflows/terraform-deploy.yml`

**Triggers:**

* Push to `main` branch

**Steps:**

* Checkout code
* Configure AWS credentials
* Terraform init → validate → plan → apply

✅ No destroy step is included in this workflow.

---

### 📦 Outputs

The following output values will be displayed after apply:

* `asg_name`: Name of the Auto Scaling Group
* `placement_group`: Name of the Placement Group

---

### ⚙️ Sample Variable File (`variables.tf`)

```hcl
variable "instance_type" {
  description = "EC2 instance type"
  default     = "c5.large"
}
```

---

### 🛠️ Notes

* Ensure the instance type supports Placement Group strategy (e.g., `c5.large`).
* Destroy can be done **manually** using:

  ```bash
  terraform destroy
  ```

---

