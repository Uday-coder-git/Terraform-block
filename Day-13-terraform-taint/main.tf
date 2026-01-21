provider "aws" {
  
}
resource "aws_instance" "server" {
  ami                         = "ami-00a51cc7a8cd53e3f" # Ubuntu AMI
  instance_type               = "t3.micro"

  tags = {
    Name = "UbuntuServer"
  }
}



#Use terraform taint to manually mark the resource for recreation:
# terraform taint aws_instance.server
# terraform apply