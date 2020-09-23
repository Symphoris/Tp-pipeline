resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "submet_vpc" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main_vpc"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main_vpc"
  }
}