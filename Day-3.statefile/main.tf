resource "aws_instance" "name" {
    ami = var.uday
    instance_type = var.type
     tags = {
       name="test"
     }
  
}