# Launch the 1st instance
resource "aws_instance" "ec2-instance-1" {
  ami               = "ami-00874d747dde814fa"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "laravelkeys"
  subnet_id         = aws_subnet.public-subnet-1.id
  security_groups   = [aws_security_group.alb-security-group.id]
  tags = {
    Name = "Server 1"
  }
}

# Launch the 2nd instance
resource "aws_instance" "ec2-instance-2" {
  ami               = "ami-00874d747dde814fa"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1b"
  key_name          = "laravelkeys"
  subnet_id         = aws_subnet.public-subnet-2.id
  security_groups   = [aws_security_group.alb-security-group.id]
  tags = {
    Name = "Server 2"
  }
}

# Launch the 3rd instance
resource "aws_instance" "ec2-instance-3" {
  ami               = "ami-00874d747dde814fa"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1c"
  key_name          = "laravelkeys"
  subnet_id         = aws_subnet.public-subnet-3.id
  security_groups   = [aws_security_group.alb-security-group.id]
  tags = {
    Name = "Server 3"
  }
}

# Create a file to store ip addresses of the instances
resource "local_file" "ip_address" {
  filename = "~/OneDrive/Desktop/Terraform-project/Mini-project/host-inventory"
  content  = <<EOT
${aws_instance.ec2-instance-1.public_ip}
${aws_instance.ec2-instance-2.public_ip}
${aws_instance.ec2-instance-3.public_ip}
  EOT
}