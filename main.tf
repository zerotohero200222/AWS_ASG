provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
}

resource "aws_subnet" "example2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-2b"
}

resource "aws_placement_group" "test" {
  name     = "test"
  strategy = "cluster"
}

resource "aws_launch_configuration" "foobar" {
  name          = "launch-config"
  image_id      = "ami-0b8b44ec9a8f90422" # ✅ Valid for us-east-2 (Ubuntu 22.04 LTS)
  instance_type = "t3.micro"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bar" {
  name                      = "asg-${random_string.tag_value.result}"
  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  placement_group           = aws_placement_group.test.id
  force_delete              = true
  launch_configuration      = aws_launch_configuration.foobar.name
  vpc_zone_identifier       = [aws_subnet.example1.id, aws_subnet.example2.id]

  tag {
    key                 = "Name"
    value               = random_string.tag_value.result
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
}

resource "random_string" "tag_value" {
  length  = 6
  special = false
  upper   = false
}

