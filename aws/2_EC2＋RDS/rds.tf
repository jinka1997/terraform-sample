resource "aws_db_instance" "sample" {
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.medium"
  name                   = "rdssample"
  username               = "admin"
  password               = "hogefugapiyo"
  allocated_storage      = 20
  storage_type           = "gp2"
  #parameter_group_name   = "default.sqlserver-ex-15.0"
  #option_group_name      = "default:sqlserver-ex-15-00"
  db_subnet_group_name   = aws_db_subnet_group.sample.name
  #security_group_names   = [aws_subnet.private1.id, aws_subnet.private2.id]
  vpc_security_group_ids = [aws_security_group.rds_sample.id]
  skip_final_snapshot    = true

  tags = {
      Name = "rds-sample"
  }
}


resource "aws_db_subnet_group" "sample" {
  name       = "rds-sample"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]

  tags = {
    Name = "rds-sample"
  }
}