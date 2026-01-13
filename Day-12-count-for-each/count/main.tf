 #resource "aws_instance" "name" {
     #ami = "ami-00a51cc7a8cd53e3f"
     #instance_type = "t3.micro"
     #count = 2
      #tags = {
       # Name = "dev"
      #}
   #tags ={
   #  Name = "dev-${count.index}"
  # }
 #}
 variable "env" {
    type = list(string)
    default = ["dev",  "prod"]
  
}

resource "aws_instance" "name" {
    ami = "ami-00a51cc7a8cd53e3f"
    instance_type = "t3.micro"
    count = length(var.env)
    tags = {
        Name = var.env[count.index]
    }
}
 
