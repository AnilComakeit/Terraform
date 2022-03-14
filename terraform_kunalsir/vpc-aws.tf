# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.main_vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "main"
  }
}

# Public Subnets 
resource "aws_subnet" "publicsubnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone1


  tags {
    Name = "public-subnet1"
  }
  # Mapping because when we launcg instance this will have public ip
    map_public_ip_on_launch = true

}

# resource "aws_subnet" "subnet2" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = var.availability_zone2


#   tags {
#     Name = "public-subnet2"
#   }
# }
# Private Subnets 

resource "aws_subnet" "privatesubnet3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.availability_zone1


  tags {
    Name = "private_subnet1"
  }
}

# resource "aws_subnet" "subnet4" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.0.4.0/24"
#   availability_zone = var.availability_zone2


#   tags {
#     Name = "private_subnet2"
#   }
# }

# internet gateway
# internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  depends_on = [
    aws_vpc.vpc,
  ]

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "internet-gateway"
  }
}


# route table with target as internet gateway
resource "aws_route_table" "IG_route_table" {
  depends_on = [
    aws_vpc.vpc,
    aws_internet_gateway.internet_gateway,
  ]

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "IG-route-table"
  }
}

# associate route table to public subnet
resource "aws_route_table_association" "associate_routetable_to_public_subnet" {
  depends_on = [
    aws_subnet.public_subnet,
    aws_route_table.IG_route_table,
  ]
  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.IG_route_table.id
}
