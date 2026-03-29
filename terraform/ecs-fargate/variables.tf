variable "aws_region" {
  description = "AWS region for ECS Fargate resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Base name for ECS resources"
  type        = string
  default     = "devops-fargate"
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 5000
}