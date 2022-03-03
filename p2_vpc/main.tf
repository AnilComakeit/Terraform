provider "aws" {
    region = "ap-south-1"
    access_key = "AKIA5JLBZPYPV44ZR4HQ"
    secret_key = "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"
  
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
