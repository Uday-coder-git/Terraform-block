# create the vpc
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc"
  }
  
}
#create the subnet
resource "aws_subnet" "subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-2a"
  tags = {
    Name ="subnet-1"
  }
  
}
resource "aws_subnet" "subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-southeast-2b"
  tags = {
    Name ="subnet-2"
  }
  
}

# create the subnet-group
resource "aws_db_subnet_group" "group" {
  name = "subnet group"
  subnet_ids = [ aws_subnet.subnet_1.id,
   aws_subnet.subnet_2.id ]
  tags = {
    Name = "subnet-group"
  }
  
}
# create the security group
resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# create the rds database
resource "aws_db_instance" "default" {
  allocated_storage       = 10
  db_name                 = "mydb"
  identifier              = "rds-test"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"

  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  parameter_group_name = "default.mysql8.0"

  backup_retention_period = 7
  backup_window           = "02:00-03:00"

  monitoring_interval = 60
  #monitoring_role_arn = aws_iam_role.rds_monitoring.arn

  maintenance_window   = "sun:04:00-sun:05:00"
  deletion_protection  = true
  skip_final_snapshot  = true
}

# # IAM Role for RDS Enhanced Monitoring
#resource "aws_iam_role" "rds_monitoring" {
  #name = "rds-monitoring-role"
  
  #assume_role_policy = jsonencode({
  #  Version = "2012-10-17"
   # Statement = [{
    #  Action = "sts:AssumeRole"
     ##Principal = {
       # Service = "monitoring.rds.amazonaws.com"
     # }
   # }]
  #})
#}

#IAM Policy Attachment for RDS Monitoring
#resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
 # role       = aws_iam_role.rds_monitoring.name
  #policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
#}
 
 # create the s3 bucket
 resource "aws_s3_bucket" "name" {
  bucket = "uday-reddy-2"
   
 }

  




  

