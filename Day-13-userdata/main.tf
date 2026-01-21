
provider "aws" {
  
}
resource "aws_instance" "server" {
  ami                         = "ami-00a51cc7a8cd53e3f" # Ubuntu AMI
  instance_type               = "t3.micro"
  user_data = file("test.sh")

  tags = {
    Name = "UbuntuServer"
  }
}