output "asg_name" {
  value = aws_autoscaling_group.bar.name
}

output "placement_group" {
  value = aws_placement_group.test.name
}
