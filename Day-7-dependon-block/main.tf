resource "aws_instance" "name" {
  ami = "ami-00a51cc7a8cd53e3f"
  instance_type = "t3.micro"
  
}
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name="test"
  }
  
}
resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-2a"
  tags = {
    Name = "subnet"
  }
}

resource "aws_s3_bucket" "name" {
    bucket = "uday-reddy-1"
    depends_on = [ aws_instance.name ]
  
}