module "vpc" {
  source       = "./modules/vpc"
  cidr_block   = "10.0.0.0/16"
  subnet_1_cidr  = "10.0.1.0/24"
  subnet_2_cidr = "10.0.2.0/24"
  az1           = "ap-southeast-2a"
  az2           = "ap-southeast-2b"
}

module "ec2" {
   source        = "./modules/ec2"
   ami_id        = "ami-00a51cc7a8cd53e3f"  # Replace with valid AMI
   instance_type = "t3.micro"
   subnet_1_id     = module.vpc.subnet_1_id
}

module "rds" {
  source         = "./modules/rds"
  subnet_1_id      = module.vpc.subnet_1_id
  subnet_2_id      = module.vpc.subnet_2_id
  instance_class = "db.t3.micro"
  db_name        = "mydb"
  db_user        = "admin"
  db_password    = "uday12345"
}

module "s3" {
    source = "./modules/s3"
    bucket = "uday-reddy-1"
  

}

module "lambda" {
    source = "./modules/lambda"
}