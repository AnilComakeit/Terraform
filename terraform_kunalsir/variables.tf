variable "access_key" {
  description = "Access Key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Secret Key"
  type        = string
  sensitive   = true
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "ap-south-1"
}
variable "availability_zone1" {
    description = "Avaialbility Zones"
    default = "ap-south-1"
}

variable "availability_zone2" {
    description = "Avaialbility Zones"
    default = "ap-south-1"
}

variable "main_vpc_cidr" {
    description = "CIDR of the VPC"
    default = "10.0.0.0/16"
}
