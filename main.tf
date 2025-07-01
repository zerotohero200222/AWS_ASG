# Random tag value to use in resources
resource "random_string" "tag_value" {
  length  = 6
  special = false
  upper   = false
}

# Example VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc-${random_string.tag_value.result}"
  }
}

# Example Subnet
resource "aws_subnet" "example" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-${random_string.tag_value.result}"
  }
}

