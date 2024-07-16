variable "env" {
    description = "Environment"
    type = string
}

variable "vpc_cidr_block" {
    description = "VPC CIDR block"
    type = string
}

variable "public_subnets_cidr" {
    description = "List of public subnets CIDR blocks"
    type = list(string)
}

variable "private_subnets_cidr" {
    description = "List of private subnets CIDR blocks"
    type = list(string)
}

variable "public_subnet_tags" {
    description = "Tags for public subnets"
    type = map(any)
}

variable "private_subnet_tags" {
    description = "Tags for private subnets"
    type = map(any)
}

variable "azs" {
    description = "Availability zones"
    type = list(string)
}