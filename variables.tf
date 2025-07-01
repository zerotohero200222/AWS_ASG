resource "random_pet" "asg_name" {
  length = 2
}

resource "random_string" "launch_name" {
  length  = 8
  special = false
  upper   = false
}

resource "random_string" "tag_value" {
  length  = 5
  upper   = false
  special = false
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami_id" {
  type    = string
  default = "ami-0c94855ba95c71c99" # Ubuntu 18.04 us-east-1
}
