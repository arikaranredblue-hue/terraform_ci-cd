# 🚀 Terraform CI/CD Project (AWS EC2 + S3 Backend + DynamoDB Lock)

## 📌 Overview

This project demonstrates how to build a **real-world DevOps workflow** using:

* **Terraform** for Infrastructure as Code
* **AWS EC2** for compute
* **S3 Backend** for remote state management
* **DynamoDB** for state locking
* **GitHub Actions** for CI/CD automation

The goal is simple:

> ✅ Create EC2 only if it doesn't exist
> ❌ Avoid duplicate infrastructure on every push

---

## 🧠 Architecture

```
GitHub Push
     ↓
GitHub Actions (CI/CD)
     ↓
Terraform Init / Plan / Apply
     ↓
S3 (stores state)
DynamoDB (locks state)
     ↓
AWS EC2 (created only if needed)
```

---

## ⚙️ Tech Stack

* Terraform
* AWS (EC2, S3, DynamoDB)
* GitHub Actions

---

## 📁 Project Structure

```
.
├── main.tf
├── variables.tf
├── provider.tf
├── backend.tf
├── terraform.tfvars
├── output.tf
├── .gitignore
└── .github/
    └── workflows/
        └── terraform.yml
```

---

## 🔐 Backend Configuration

Terraform uses:

* **S3 bucket** → stores `terraform.tfstate`
* **DynamoDB table** → prevents concurrent execution

Example:

```hcl
backend "s3" {
  bucket         = "your-bucket-name"
  key            = "devops/ec2/terraform.tfstate"
  region         = "ap-south-1"
  dynamodb_table = "terraform-lock"
  encrypt        = true
}
```

---

## 🔄 CI/CD Pipeline

The pipeline runs automatically on every push to `main` branch.

Steps:

1. Checkout code
2. Setup Terraform
3. Configure AWS credentials
4. Run `terraform init`
5. Run `terraform plan`
6. Run `terraform apply -auto-approve`

---

## 🔑 GitHub Secrets Required

Add these in your repository:

* `AWS_ACCESS_KEY`
* `AWS_SECRET_KEY`

---

## 🚫 Important Notes

* `.terraform/` is ignored (local cache)
* `terraform.tfstate` is NOT stored locally (uses S3)
* DynamoDB prevents multiple pipelines from running at the same time

---

## ⚠️ Common Issues & Fixes

### ❌ Large file error (GitHub)

Cause: `.terraform/` pushed
Fix: Add to `.gitignore`

---

### ❌ Stuck on "Acquiring state lock"

Cause: Previous run didn’t release lock
Fix:

```bash
terraform force-unlock <LOCK_ID>
```

---

### ❌ Asking for variables in CI/CD

Cause: `terraform.tfvars` not committed
Fix: Add it or use GitHub Secrets

---

## 🧪 How It Works

* First push → creates EC2
* Next push → Terraform checks state → no changes
* No duplicate EC2 created

---

## 🔥 Key Learning

* Remote state is **mandatory** for CI/CD
* DynamoDB locking prevents **race conditions**
* Terraform ensures **idempotency** (same result every time)

---

## 🚀 Future Improvements

* Add multi-environment setup (dev/prod)
* Use Terraform modules
* Integrate Docker deployment
* Use AWS KMS for encryption

---

## 👨‍💻 Author

Arikaran

---

## ⭐ Final Note

This project demonstrates a **production-style Terraform workflow** with proper state management and CI/CD automation.

> "Write once, deploy safely, and avoid duplicates." 🚀
