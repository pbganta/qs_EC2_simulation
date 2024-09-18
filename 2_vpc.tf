resource "aws_vpc" "main" {
  cidr_block = var.init.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.init.env}-main"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.init.env}-igw"
  }
}

resource "aws_subnet" "public_zone1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.subnets_list[0]
  availability_zone       = local.zone1
  map_public_ip_on_launch = true

  tags = {
    "Name" = "${var.init.env}-public-${local.zone1}"
  }
}

resource "aws_subnet" "public_zone2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.subnets_list[1]
  availability_zone       = local.zone2
  map_public_ip_on_launch = true

  tags = {
    "Name"  = "${var.init.env}-public-${local.zone2}"
  }
}

resource "aws_subnet" "private_zone1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.subnets_list[2]
  availability_zone = local.zone1

  tags = {
    "Name" = "${var.init.env}-private-${local.zone1}"
  }
}

resource "aws_subnet" "private_zone2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.subnets_list[3]
  availability_zone = local.zone2

    tags = {
    "Name"  = "${var.init.env}-private-${local.zone2}"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "${var.init.env}-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_zone1.id

  tags = {
    Name = "${var.init.env}-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.init.env}-public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.init.env}-private"
  }
}

resource "aws_route_table_association" "private_zone1" {
  subnet_id      = aws_subnet.private_zone1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_zone2" {
  subnet_id      = aws_subnet.private_zone2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_zone1" {
  subnet_id      = aws_subnet.public_zone1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_zone2" {
  subnet_id      = aws_subnet.public_zone2.id
  route_table_id = aws_route_table.public.id
}
