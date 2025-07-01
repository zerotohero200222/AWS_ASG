variable "instance_type" {
  default = "c5.large"
}

variable "ami_id" {
  description = "Amazon Machine Image ID"
  default     = "ami-0c55b159cbfafe1f0" # Use a valid AMI ID for your region
}
