provider "aws" {
    region = "ap-south-1"
    access_key = var.access_key
    secret_key = var.secret_key
  
} 



resource "aws_vpc" "anilvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "production"
  }
}


resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.anilvpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "prod-subnet"
  }
}
