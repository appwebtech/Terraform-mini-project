output "subnet" {
  value = aws_subnet.myapp-subnet-1
}

/* output "subnet" {
  value = ["${aws_subnet.myapp-subnet.id}"]
} */