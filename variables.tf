variable "instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
  description = "Amazon Machine Image ID"
  default     = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI in your region
}
