terraform {
  backend "s3" {
    bucket = "uday-reddy-1"
    key    = "day-6/terraform.tfstate"
    region = "ap-southeast-2"
    # Enable S3 native locking
    #use_lockfile = true   #tf version should be above 1.10
    # The dynamodb_table argument is no longer needed
    dynamodb_table = "uday"

  }
}