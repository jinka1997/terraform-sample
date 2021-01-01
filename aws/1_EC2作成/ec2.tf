/*
data "aws_ami" "windows_server" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }
}
*/

resource "aws_instance" "for-study" {
  ami           = "ami-014612c2d9afaf1ac"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main.id
  associate_public_ip_address = true
  key_name = "keypair-for-study"
  security_groups = [aws_security_group.allow_rdp.id]
  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           = 30
    volume_type           = "standard"
  }

  tags = {
    Name = "tf-study-123"
  }
}



resource "aws_security_group" "allow_rdp" {
  name        = "allow_rdp"
  description = "Allow RDP from my home"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Remoter desktop"
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_rdp"
  }
}