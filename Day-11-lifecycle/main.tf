resource "aws_instance" "name" {
    ami = "ami-00a51cc7a8cd53e3f"
    instance_type = "t3.micro"
    tags = {
      Name = "dev"
    }

     #lifecycle {
      # prevent_destroy = true
     #}
    #lifecycle {
     # ignore_changes = [ instance_type, ]

    #}
      lifecycle {
  create_before_destroy = true
}
}