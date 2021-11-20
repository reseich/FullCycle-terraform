resource "aws_vpc" "eich-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.prefix}-vpc"
  }
}
data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnets" {
  count = 3
  vpc_id     = aws_vpc.eich-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "new-igw" {
  vpc_id = aws_vpc.eich-vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "new-rtb" {
  vpc_id = aws_vpc.eich-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new-igw.id
  }
  tags = {
    Name = "${var.prefix}-rtb"
  }
}

resource "aws_route_table_association" "new-rtb-association" {
  count = 3
  route_table_id = aws_route_table.new-rtb.id
  subnet_id = aws_subnet.subnets.*.id[count.index]
}

output "a2" {
  value = data.aws_availability_zones.available.names
}