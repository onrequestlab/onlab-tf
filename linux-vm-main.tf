###################################
## Virtual Machine Module - Main ##
###################################
resource "aws_eip" "lb" {
  for_each = aws_instance.linux-server
  instance = each.value.id
}

# Create EC2 Instance
resource "aws_instance" "linux-server" {
  for_each                    = var.instance_names
  ami                         = "ami-0763cf792771fe1bd"
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.default.id
  vpc_security_group_ids      = [aws_security_group.aws-linux-sg.id]
  associate_public_ip_address = false
  key_name                    = data.aws_key_pair.example.key_name
  
  # root disk
  root_block_device {
    volume_size           = "20"
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = true
  }
  
  tags = {
    Name        = "${lower(var.app_name)}-${each.key}"
    Environment = var.app_environment
  }
}
resource "random_integer" "priority" {
  min = 2
  max = 5
}

# Define the security group for the Linux server
resource "aws_security_group" "aws-linux-sg" {
  name        = "${lower(var.app_name)}-${random_integer.priority.result}-linux-sg"
  description = "Allow incoming HTTP connections"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming connections"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming SSH connections"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-sg"
    Environment = var.app_environment
  }
}
