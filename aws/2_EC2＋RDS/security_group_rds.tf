resource "aws_security_group" "rds_sample" {
    name        = "rds-sample"
    description = "security group for rds"
    vpc_id      = aws_vpc.sample.id

    ingress  {
        description = "from ec2 only"
        from_port   = 1433
        to_port     = 1433
        protocol    = "TCP"
        security_groups = [aws_security_group.ec2.name]
    } 
    tags = {
        Name = "rds-sample"
    }
}