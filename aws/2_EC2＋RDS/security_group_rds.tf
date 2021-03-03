resource "aws_security_group" "rds" {
    name        = "rds-sample-rds"
    description = "security group for rds"
    vpc_id      = aws_vpc.sample.id

    ingress  {
        description = "from ec2"
        from_port   = 1433
        to_port     = 1433
        protocol    = "TCP"
        security_groups = [aws_security_group.ec2.id]
    } 

    egress {
      description = "all traffic"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "rds-sample-rds"
    }
}