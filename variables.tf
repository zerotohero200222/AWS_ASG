# No resource blocks here – only variables

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "us-east-2"
}
