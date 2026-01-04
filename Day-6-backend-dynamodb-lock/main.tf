resource "aws_instance" "name" {
    ami = "ami-0b3c832b6b7289e44"
    instance_type = "t3.micro"
    tags = {
      Name ="dev"
    }
    
}
