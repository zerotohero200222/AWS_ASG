terraform {
  backend "s3" {
    bucket = "terraform-state-asg-dev"
    key    = "asg/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
