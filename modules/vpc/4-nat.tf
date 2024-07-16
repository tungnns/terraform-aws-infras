resource "aws_eip" "this" {
  vpc = true

  tags = {
    Name = "${var.env}-nat"
  }
}

resource "aws_nat_gateway" "this" {
    subnet_id = aws_subnet.public[0].id
    allocation_id = aws_eip.this.id

    tags = {
        Name = "${var.env}-nat"
    }

    depends_on = [aws_internet_gateway.this]
}