terraform {
  backend "s3" {
    bucket = "terraform-state-your-asg-bucket"
    key    = "asg/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
