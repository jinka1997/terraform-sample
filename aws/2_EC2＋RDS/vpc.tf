resource "aws_vpc" "sample" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "rds-sample"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.sample.id #ここでVPCを指定することでアタッチされる
  tags = {
    Name = "rds-sample"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.sample.id
  cidr_block = "10.0.1.0/24"
  #availability_zone = "ap-northeast-1a"

  tags = {
    Name = "rds-sample-public1"
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.sample.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "rds-sample-private1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.sample.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "rds-sample-private2"
  }
}

resource "aws_route_table" "public1" {
  vpc_id = aws_vpc.sample.id

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rds-sample-route-table"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public1.id
}

