# 1. Fetch Existing Architecture Data (No New Instances Created)
data "aws_instance" "jenkins_master" {
  instance_id = var.jenkins_master_instance_id
}

data "aws_instance" "jenkins_agent" {
  instance_id = var.jenkins_agent_instance_id
}

# Subnet Data Source se VPC ID extract karna
data "aws_subnet" "agent_subnet" {
  id = data.aws_instance.jenkins_agent.subnet_id
}

# 2. Managed Security Group for Laravel Application
resource "aws_security_group" "laravel_app_sg" {
  name        = "laravel-app-sg"
  description = "Security group for Laravel App container hosted on existing Agent instance"
  vpc_id      = data.aws_subnet.agent_subnet.vpc_id

  # HTTP Web Access for Laravel Container
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH Access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Laravel-App-SG"
    Environment = var.environment
  }
}

# 3. S3 Bucket for Database & Application Backups
resource "aws_s3_bucket" "app_backups" {
  bucket        = "devops-assessment-zain-backups-2026"
  force_destroy = true

  tags = {
    Name        = "Laravel-Backups"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "backup_versioning" {
  bucket = aws_s3_bucket.app_backups.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 4. CloudWatch Log Group & High CPU Alert Alarm
resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/aws/ec2/laravel-app-logs"
  retention_in_days = 7
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name          = "jenkins-agent-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This alarm monitors high CPU usage on the Jenkins Agent instance."

  dimensions = {
    InstanceId = data.aws_instance.jenkins_agent.id
  }
}
