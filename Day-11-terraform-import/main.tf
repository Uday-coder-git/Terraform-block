resource "aws_instance" "name" {
 ami = "ami-00a51cc7a8cd53e3f"
    instance_type = "t3.micro"
    tags = {
      Name = "dev"
    }  
   
}
resource "aws_s3_bucket" "name" {
   bucket = "uday-reddy-1" 
  
}
resource "aws_s3_bucket_versioning" "name" {
    bucket = aws_s3_bucket.name.id
  versioning_configuration {
    status = "Enabled"
  
}
}