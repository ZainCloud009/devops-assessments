# Security Considerations & Enhancements

This document outlines the security measures implemented in this project and key recommendations for production environments.

## Implemented Security Measures
1. **Non-Root Docker Execution**: Docker containers run as a dedicated non-root user (`www-data`) to prevent privilege escalation.
2. **Environment Variable Protection**: Sensitive secrets and application keys are excluded from git history via `.gitignore` and handled dynamically.
3. **Restricted S3 Permissions**: S3 bucket access is restricted using AWS IAM roles attached directly to EC2 instances instead of hardcoded API access keys.
4. **Least Privilege Ingress**: AWS Security Groups limit inbound traffic strictly to required application and SSH ports.

## Recommendations for Production Scale
- **SSL/TLS Encryption**: Implement Let's Encrypt / AWS Certificate Manager (ACM) on Application Load Balancer / Nginx.
- **Secrets Management**: Transition environment secrets to AWS Secrets Manager or HashiCorp Vault.
- **Automated Container Scanning**: Integrate Trivy or Docker Scout in Jenkins CI pipeline for automated vulnerability scanning.
