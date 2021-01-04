
resource "aws_instance" "sample" {
  ami                         = "ami-01748a72bed07727c" #Amazon Linux 2 AMI (HVM), SSD Volume Type 64 ビット x86
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public1.id
  associate_public_ip_address = true
  key_name                    = "ec2-sample"
  security_groups             = [aws_security_group.ec2.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = "ec2-sample"
  }
}
