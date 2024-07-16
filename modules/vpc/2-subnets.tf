resource "aws_subnet" "public" {
    
    count = length(var.public_subnets_cidr)
    vpc_id = aws_vpc.this.id
    cidr_block = element(var.public_subnets_cidr, count.index)
    availability_zone = element(var.azs, count.index)

    tags = merge (
        { Name = "${var.env}-public-${count.index}" }, 
        var.public_subnet_tags
    )

}

resource "aws_subnet" "private" {
    
    count = length(var.private_subnets_cidr)
    vpc_id = aws_vpc.this.id
    cidr_block = element(var.private_subnets_cidr, count.index)
    availability_zone = element(var.azs, count.index)

    tags = merge (
        { Name = "${var.env}-private-${count.index}" }, 
        var.private_subnet_tags
    )

}