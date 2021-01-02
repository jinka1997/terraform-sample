resource "aws_vpc" "sample" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "ec2-sample"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.sample.id #ここでVPCを指定することでアタッチされる
  tags = {
    Name = "ec2-sample"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.sample.id
  cidr_block = "10.0.1.0/24"
  #availability_zone = "ap-northeast-1a"

  tags = {
    Name = "ec2-sample-public1"
  }
}

resource "aws_main_route_table_association" "public1" {
  vpc_id         = aws_vpc.sample.id
  route_table_id = aws_route_table.r.id
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.sample.id

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "ec2-sample-route-table"
  }
}