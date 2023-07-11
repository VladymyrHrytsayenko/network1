resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "MyServer-VPC"
  }
}

resource "aws_internet_gateway" "my_gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main_gw"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "Public" {
  count                   = length(var.public_cidr)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_cidr, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-subnet-${count.index + 1}"
  }
}


resource "aws_subnet" "Private" {
  count             = length(var.privat_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.privat_cidr, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "Private-subnet-${count.index + 1}"
  }
}



resource "aws_route_table" "Public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gw.id
  }

}

resource "aws_route_table_association" "Public" {
  count          = length(aws_subnet.Public[*].id)
  subnet_id      = element(aws_subnet.Public[*].id, count.index)
  route_table_id = aws_route_table.Public.id
}

