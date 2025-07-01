output "asg_name" {
  value = aws_autoscaling_group.bar.name
}

output "placement_group" {
  value = aws_placement_group.test.name
}

output "subnet_id" {
  value = aws_subnet.example.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}
