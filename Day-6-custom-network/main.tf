#create of the vpc
resource "aws_vpc" "vpc_uday" {
    cidr_block = "10.0.0.0/16"
  
}

#create of the subnet
resource "aws_subnet" "subnet_public"{
    vpc_id = aws_vpc.vpc_uday.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name="subnet-1"
    }
  
}
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc_uday.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name="subnet-2"
    }
  
}
resource "aws_subnet" "subnet_private" {
    vpc_id = aws_vpc.vpc_uday.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name="subnet-3"
    }
  
}
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc_uday.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name="subnet-4"
    }
  
}
#create of the internet_gateway
resource "aws_internet_gateway" "In_gate" {
    vpc_id = aws_vpc.vpc_uday.id
  tags = {
    Name="internet"
  }
}
#lnternet_gateway to attached the vpc
#resource "aws_internet_gateway_attachment" "ig" {
 #   internet_gateway_id = aws_internet_gateway.In_gate.id
  #  vpc_id = aws_vpc.vpc_uday.id


  
#}
#create of the elastic ip from nat gateway
resource "aws_eip" "nat_gw" {
    domain = "vpc"
  
}
#create of the nat-gateway
resource "aws_nat_gateway" "nat_gate" {
    allocation_id = aws_eip.nat_gw.id
    subnet_id = aws_subnet.subnet_public.id
    
  
}
#route table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc_uday.id
    

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.In_gate.id
    }
    tags = {
      Name ="public-rt"
    }
  
}
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc_uday.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gate.id
    }
    tags = {
      Name="private-rt"
    }
  
}

#route table association create
resource "aws_route_table_association" "public_uday" {
    
    route_table_id = aws_route_table.public_rt.id
    subnet_id = aws_subnet.subnet_public.id

  
}
resource "aws_route_table_association" "public_assoc" {
    route_table_id = aws_route_table.public_rt.id
    subnet_id = aws_subnet.public_subnet.id
  
}
resource "aws_route_table_association" "private_kiran" {
    subnet_id = aws_subnet.subnet_private.id
    route_table_id = aws_route_table.private_rt.id
  
}
resource "aws_route_table_association" "private_assoc" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_rt.id
  
}
#create of the security group

resource "aws_security_group" "dev_sg" {
  name   = "allow_tls"
  vpc_id = aws_vpc.vpc_uday.id
  
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #indicate all protocol 
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# create of the instance
resource "aws_instance" "test" {
    ami = "ami-068c0051b15cdb816"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.subnet_public.id
    vpc_security_group_ids = [aws_security_group.dev_sg.id]
    tags = {
      Name="bastion"
    }
  
}
resource "aws_instance" "dev" {
    ami = "ami-068c0051b15cdb816"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.subnet_private.id
    vpc_security_group_ids = [aws_security_group.dev_sg.id]
    tags = {
      Name="pvt-server"
    }
  
}



