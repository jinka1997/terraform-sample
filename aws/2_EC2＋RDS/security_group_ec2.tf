resource "aws_security_group" "ec2" {
  name        = "ec2"
  description = "Allow RDP from my place"
  vpc_id      = aws_vpc.sample.id

  ingress {
    description = "Remote desktop"
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"] #ここを作業場所のIPアドレスに変える
  }

/*
  egress  {
    description     = "all traffic"
    cidr_blocks     = ["0.0.0.0/0"]
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [ aws_security_group.ec2.id ]
  } 
*/
  tags = {
    Name = "rds-sample-ec2"
  }
}