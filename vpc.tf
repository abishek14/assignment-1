# VPC

resource "aws_vpc" "ecomm" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ecomm-vpc"
  }
}

# SUBNET
resource "aws_subnet" "ecomm-sn" {
  vpc_id     = aws_vpc.ecomm.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "ecomm subnet"
  }
}

# SUBNET 2
resource "aws_subnet" "ecomm-pvt_sn" {
  vpc_id     = aws_vpc.ecomm.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "ecomm pvt subnet"
  }
}



# INTERNET GATE WAY
resource "aws_internet_gateway" "ecomm-igw" {
  vpc_id = aws_vpc.ecomm.id

  tags = {
    Name = "ecomm igw"
  }
}


# ROUTE TABLE & ROUTE
resource "aws_route_table" "ecomm-rt" {
  vpc_id = aws_vpc.ecomm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecomm-igw.id
  }

  tags = {
    Name = "ecomm route table"
  }
}

# PRIVATE  ROUTE TABLE & ROUTE
resource "aws_route_table" "ecomm-pvt_rt" {
  vpc_id = aws_vpc.ecomm.id


  tags = {
    Name = "ecomm pvt route table"
  }
}


# Route Table & Subnet Association
resource "aws_route_table_association" "public_subrt" {
  subnet_id      = aws_subnet.ecomm-sn.id
  route_table_id = aws_route_table.ecomm-rt.id
}

resource "aws_route_table_association" "private_subrt" {
  subnet_id     = aws_subnet.ecomm-pvt_sn.id
  route_table_id = aws_route_table.ecomm-pvt_rt.id
}
