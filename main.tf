data "aws_ami" "amazon_linux" {
  most_recent = true
  owners       = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "lab_key" {
  key_name   = "terraform-lab-key"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "lab_sg" {
  name        = "terraform-lab-sg"
  description = "Allow SSH from my IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "lab" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.lab_key.key_name
  vpc_security_group_ids = [aws_security_group.lab_sg.id]

  tags = {
    Name = "terraform-lab-instance"
  }
}
