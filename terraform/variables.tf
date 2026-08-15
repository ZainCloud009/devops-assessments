variable "aws_region" {
  default     = "us-east-1"
  description = "AWS Region where existing instances are running"
}

variable "environment" {
  default     = "staging"
  description = "Environment name"
}

# Master Jenkins instance ID (Inbound/Outbound references ke liye)
variable "jenkins_master_instance_id" {
  type        = string
  default     = "i-0123456789abcdef0" # Apni AWS Console se Jenkins Master ki Instance ID lagayein
  description = "Instance ID of existing Jenkins Master"
}

# Jenkins Agent / Deployment instance ID
variable "jenkins_agent_instance_id" {
  type        = string
  default     = "i-0987654321fedcba0" # Apni AWS Console se Jenkins Agent ki Instance ID lagayein
  description = "Instance ID of existing Jenkins Agent/Deployer"
}
