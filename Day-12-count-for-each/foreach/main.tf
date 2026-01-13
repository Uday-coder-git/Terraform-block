
variable "env" {
    type = list(string)
    default = ["dev","test", "prod"]
  
}

resource "aws_instance" "name" {
    ami = "ami-00a51cc7a8cd53e3f"
    instance_type = "t3.micro"
    for_each = toset(var.env) # toset not folows any order like list (index)
    tags = {
        Name = each.value
    }
}