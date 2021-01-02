
resource "aws_instance" "sample" {
  ami                         = "ami-014612c2d9afaf1ac" #Microsoft Windows Server 2019 Base
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public1.id
  associate_public_ip_address = true
  key_name                    = "ec2-sample"
  security_groups             = [aws_security_group.allow_rdp.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = "ec2-sample"
  }
}

resource "aws_security_group" "allow_rdp" {
  name        = "allow_rdp"
  description = "Allow RDP from my home"
  vpc_id      = aws_vpc.sample.id

  ingress {
    description = "Remoter desktop"
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"] #ここを作業場所のIPアドレスに変える
  }

  tags = {
    Name = "allow_rdp"
  }
}