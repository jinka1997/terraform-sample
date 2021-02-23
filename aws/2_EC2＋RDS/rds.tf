resource "aws_db_instance" "sqlserver_ex" {
  identifier     = "rds-sample-sqlserver"
  instance_class = "db.t3.small"
  engine         = "sqlserver-ex"
  engine_version = "15.00.4073.23.v1"
  license_model  = "license-included"
  multi_az       = false   # default false
  username       = "sampleuser"
  password       = "hogefugapiyoS"

  # storage
  storage_type          = "gp2" 
  allocated_storage     = 20    
  max_allocated_storage = 1000

  # network
  db_subnet_group_name   = aws_db_subnet_group.sample.name
  vpc_security_group_ids = [aws_security_group.ec2.id]
  port                   = 1433


  skip_final_snapshot       = true   # default false

  parameter_group_name       = aws_db_parameter_group.sample.name
  option_group_name          = aws_db_option_group.sample.name
  tags = {
    Name = "rds-sample-sqlserver-ex"
  }
}

resource "aws_db_subnet_group" "sample" {
  name       = "rds-sample"
  subnet_ids = [aws_subnet.private1a.id, aws_subnet.private1c.id]

  tags = {
    Name = "rds-sample"
  }
}


resource "aws_db_parameter_group" "sample" {
  name   = "rds-sample-sqlserver-ex"
  family = "sqlserver-ex-15.0"

  tags = {
      Name = "rds-sample-sqlserver-ex"
  }
}

resource "aws_db_option_group" "sample" {
  name                 = "rds-sample-sqlserver-ex"
  engine_name          = "sqlserver-ex"
  major_engine_version = "15.00"

  tags = {
      Name = "rds-sample-sqlserver-ex"
  }
}