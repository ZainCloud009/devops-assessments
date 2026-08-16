variable "aws_region" {
  default     = "eu-north-1"
  description = "AWS Region where existing instances are running"
}

variable "environment" {
  default     = "staging"
  description = "Environment name"
}

# Master Jenkins instance ID (Inbound/Outbound references ke liye)
variable "jenkins_master_instance_id" {
  type        = string
  default     = "i-00fdf5361782e07fc" # Apni AWS Console se Jenkins Master ki Instance ID lagayein
  description = "Instance ID of existing Jenkins Master"
}

# Jenkins Agent / Deployment instance ID
variable "jenkins_agent_instance_id" {
  type        = string
  default     = "i-0848ceb55e5a3e438" # Apni AWS Console se Jenkins Agent ki Instance ID lagayein
  description = "Instance ID of existing Jenkins Agent/Deployer"
}
