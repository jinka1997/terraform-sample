resource "aws_security_group" "ec2" {
  name        = "rds-sample-ec2"
  description = "RDP from my home and http"
  vpc_id      = aws_vpc.sample.id

  ingress {
    description = "Remoter desktop"
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"] #ここを作業場所のIPアドレスに変える
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"] 
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