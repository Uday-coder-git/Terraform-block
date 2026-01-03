terraform {
  backend "s3" {
    bucket         = "uday-reddy-1" # Replace with your S3 bucket name
    key            = "day-5/terraform.tfstate" # Object path within the bucket
    region         = "ap-southeast-2" # The region where the bucket exists
       # Enable S3 native locking
    use_lockfile = true 
    # The dynamodb_table argument is no longer needed

  }
}
