resource "aws_instance" "name" {
    ami = "ami-048ab8ac7e8c6533d"
    instance_type = "t3.micro"
    tags = {
       name="dev"
     }
  
}
