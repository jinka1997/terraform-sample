resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "tf-study-123"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "tf-study-123"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "tf-study-123-public1"
  }
}

resource "aws_main_route_table_association" "public-1a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.r.id
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "tf-study-123"
  }
}