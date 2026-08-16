output "jenkins_master_public_ip" {
  value       = data.aws_instance.jenkins_master.public_ip
  description = "Public IP of existing Jenkins Master"
}

output "jenkins_agent_public_ip" {
  value       = data.aws_instance.jenkins_agent.public_ip
  description = "Public IP of existing Jenkins Agent (Deploy Server)"
}

output "s3_backup_bucket" {
  value       = aws_s3_bucket.app_backups.id
  description = "S3 Bucket created for backups"
}

output "cloudwatch_log_group" {
  value       = aws_cloudwatch_log_group.app_logs.name
  description = "CloudWatch log group created for application"
}
