# devops-assessments
This is my Devops-Assesment task for digitalsofts.

# Production-Grade DevOps Assessment & Infrastructure Setup

This repository contains a fully automated, containerized, and scalable deployment pipeline for a **Laravel Application** using AWS, Docker, Jenkins (Master/Agent Architecture), and Terraform.

## Architecture Overview

[ Developer ] ──> [ GitHub ] ──(Webhook)──> [ Jenkins Master ]
│
(Build & Deploy)
▼
[ End User ] ──> [ AWS ALB ] ──(Port 8080)──> [ Jenkins Agent / Docker Container ]
│
┌────────────┴────────────┐
▼                         ▼
[ MySQL Database ]        [ AWS S3 Backup ]


- **Application:** Laravel PHP Application
- **CI/CD Automation:** Jenkins Master/Agent setup with GitHub Webhook triggers
- **Containerization:** Docker with automated cache clearing
- **Load Balancing:** AWS Application Load Balancer (ALB) with HTTP-to-HTTPS Redirection
- **Database Backup:** Automated shell scripts uploading MySQL dumps to AWS S3
- **Infrastructure:** EC2 Instances, Target Groups, Security Groups, and CloudWatch Alarms
---
## 📁 Repository Directory Structure

```text
devops-assessment/
├── app/                  # Laravel application codebase
├── docker/               # Docker & Nginx specific configuration files
├── terraform/            # Infrastructure as Code (.tf files)
├── k8s/                  # Kubernetes manifests (Deployments, Services)
├── scripts/              # Automation scripts (deploy.sh, backup.sh)
├── devops-assessments/
│   └── workflows/        # Jenkins CI/CD workflows
├── monitoring/           # CloudWatch Alarm definitions & configurations
├── docs/
├    └── screenshots/     # Architecture diagrams & proof screenshots
├── Dockerfile            # Container build definition
├── Jenkinsfile           # Multi-stage CI/CD pipeline script
├── docker-compose.yml    # Multi-container orchestration config
├── README.md             # Project documentation
├── SECURITY.md           # Security policies and best practices
└── AI_USAGE.md           # AI assistance usage disclosures
