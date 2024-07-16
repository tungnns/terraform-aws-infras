resource "aws_route_table" "private" {
    vpc_id = aws_vpc.this.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.this.id}"
    }

    tags = {
        Name = "${var.env}-private-route"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.this.id}"
    }

    tags = {
        Name = "${var.env}-public-route"
    }
}

resource "aws_route_table_association" "private" {
    count = 2
    subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
    route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "public" {
    count = 2
    subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
    route_table_id = "${aws_route_table.public.id}"
}