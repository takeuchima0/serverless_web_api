resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.sig}-vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "example_subnet" {
  count = 2

  vpc_id            = aws_vpc.example_vpc.id
  cidr_block        = count.index == 0 ? "10.0.1.0/24" : "10.0.2.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "${local.sig}-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name = "${local.sig}-igw"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.example_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.example_igw.id
}