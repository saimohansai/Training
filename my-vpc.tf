provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "my-aws" {
  cidr_block = var.vpc-cidr
  enable_dns_hostnames = true
  tags = {
    Name= var.vpc-name
  }
}
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.my-aws.id
  count = "${length(var.azs)}"
  cidr_block ="${cidrsubnet(var.vpc-cidr,8,count.index+2)}"
  availability_zone = "${element(var.azs,count.index )}"
  tags = {
    Name= "Personal-Private-${count.index}"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.my-aws.id
  cidr_block = var.public-jumpserver
  availability_zone = "us-east-1a"#var.my-region
  tags = {
    Name = "Personal-Jump-Server"
  }
}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.my-aws.id
  tags = {
    Name= "Personal-public-jumpserver"
  }
}

resource "aws_route_table" "public_rout" {
  vpc_id = aws_vpc.my-aws.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "Personal-IGW_Jump"
  }
}
resource "aws_route_table_association" "rjumpserver" {
  route_table_id = aws_route_table.public_rout.id
  #count = length(var.azs)
  #subnet_id = aws_subnet.private[count.index].id
  subnet_id = aws_subnet.public.id
}

resource "aws_eip" "Nat_IP" {
  tags = {
    Name="private_Nat"
  }
}

resource "aws_nat_gateway" "My_Nat" {

  allocation_id = "${aws_eip.Nat_IP.id}"
  subnet_id = "${aws_subnet.public.id}"
  tags = {
    Name= "My-Nat"
  }
}

resource "aws_route_table" "My_NAT" {
  vpc_id = aws_vpc.my-aws.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.My_Nat.id
  }
  tags = {
    Name = "NAT_Testing"
  }
}
resource "aws_route_table_association" "Private_NAT" {
  route_table_id = aws_route_table.My_NAT.id
  count = length(var.azs)
  subnet_id = aws_subnet.private[count.index].id
}
