resource "random_string" "tag_value" {
  length  = 6
  upper   = false
  special = false
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
}

resource "aws_security_group" "lb_sg" {
  name        = "lb-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_template" "foobar" {
  name_prefix   = "foobar-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.lb_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "asg-instance-${random_string.tag_value.result}"
    }
  }
}

resource "aws_placement_group" "test" {
  name     = "test-${random_string.tag_value.result}"
  strategy = "cluster"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bar" {
  name                      = "foobar3-terraform-test"
  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 1
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true
  placement_group           = aws_placement_group.test.name
  vpc_zone_identifier       = [aws_subnet.example.id]

  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }

  tag {
    key                 = "Environment"
    value               = "dev-${random_string.tag_value.result}"
    propagate_at_launch = true
  }
}

