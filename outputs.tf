output "aws_ami_id" {
  value = data.aws_ami.latest-amazon-linux-image.id
}

output "ec2-public-ip" {
  value = aws_instance.myapp-server.public_ip
}