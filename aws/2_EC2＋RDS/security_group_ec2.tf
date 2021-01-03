resource "aws_security_group" "ec2" {
  name        = "ec2"
  description = "Allow RDP from my place"
  vpc_id      = aws_vpc.sample.id

  ingress {
    description = "for ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"] #ここを作業場所のIPアドレスに変える
  }

  egress {
    description = "all traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sample-ec2"
  }
}