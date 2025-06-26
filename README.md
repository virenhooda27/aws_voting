# 🗳️ MyVoteAWS — A Serverless Live Voting App on AWS

[![Made with AWS](https://img.shields.io/badge/Made%20with-AWS-orange?style=for-the-badge&logo=amazon-aws)](https://aws.amazon.com/)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-blueviolet?style=for-the-badge&logo=terraform)](https://www.terraform.io/)
[![Built by Viren Hooda](https://img.shields.io/badge/Built%20By-Viren%20Hooda-blue?style=for-the-badge)](https://github.com/virenhooda27)

> A beautifully designed, fully serverless voting platform on AWS that lets users vote 🐱 Cats vs 🐶 Dogs and view real-time results via dynamic charts.

---

## 🔥 Live Demo

🖥️ **Frontend (S3 Static Website):**  
🌐 [https://myvote-frontend-<your-id>.s3-website-us-east-1.amazonaws.com](https://myvote-frontend-06cce7d5.s3.us-east-1.amazonaws.com/index.html)

⏱️ Updates every 5 seconds | Emoji voting | CORS-enabled API

---

## 🧠 Motivation

To create a scalable, real-time cloud-native voting system using only managed services — demonstrating infrastructure automation, serverless compute, event-driven architecture, and frontend/backend decoupling — all within AWS.

---

## 🗳️ Features

- 🐱 Vote for Cats or 🐶 Vote for Dogs
- 📊 Live results page with a pie chart (Chart.js)
- 🔄 Auto-refreshes every 5 seconds
- 🌍 Public S3 hosting with dynamic HTML/JS
- 🔐 IAM-managed Lambda permissions and CORS
- ⚙️ Infrastructure deployed via **Terraform**



---

## ⚙️ Tech Stack

| Layer         | Technology                       |
|---------------|----------------------------------|
| Frontend      | HTML, CSS, JavaScript, Chart.js  |
| Backend       | Python (AWS Lambda)              |
| API           | AWS API Gateway (HTTP API)       |
| Database      | AWS DynamoDB                     |
| Infra as Code | Terraform                        |
| Hosting       | AWS S3 (static website)          |
| Auth          | IAM role-based access policies   |

---

## 📸 Screenshots

### 🐱 Voting Page
![Voting Page](https://github.com/virenhooda27/aws_voting/blob/main/screenshots/Screenshot%202025-06-26%20161606.png?raw=true)

### 📊 Results Page
![Results Page](https://github.com/virenhooda27/aws_voting/blob/main/screenshots/Screenshot%202025-06-26%20161602.png?raw=true)

---

## 🛠️ Project Structure

```bash
MyVoteAWS/
├── index.html             # Voting page (Cats vs Dogs)
├── results.html           # Live results page with pie chart
├── README.md              # You're reading it!
├── voting-backend/
│   ├── vote.py            # Lambda function to cast votes
│   └── results.py         # Lambda function to return vote counts
├── iac/                   # Terraform infrastructure code
│   ├── main.tf
│   ├── s3_bucket_vote.tf
│   ├── dynamodb.tf
│   ├── vote_lambda.tf
│   └── variables.tf       # Optional variables
