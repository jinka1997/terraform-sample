resource "aws_vpc" "sample" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "rds-sample"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.sample.id #ここでVPCを指定することでアタッチされる
  depends_on = [aws_vpc.sample]
  tags = {
    Name = "rds-sample"
  }
}

resource "aws_subnet" "public1a" {
  vpc_id     = aws_vpc.sample.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "rds-sample-public1a"
  }
}

resource "aws_eip" "nat" {
  vpc      = true

  tags = {
    Name = "rds-sample-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public1a.id

  tags = {
    Name = "rds-sample-ngw"
  }
}




resource "aws_subnet" "private1a" {
  vpc_id     = aws_vpc.sample.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "rds-sample-private1a"
  }
}

resource "aws_subnet" "private1c" {
  vpc_id     = aws_vpc.sample.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "rds-sample-private1c"
  }
}

resource "aws_route_table" "custom" {
  vpc_id = aws_vpc.sample.id

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rds-sample-custom"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.sample.id

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "rds-sample-main"
  }
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.sample.id
  route_table_id = aws_route_table.main.id
}