provider "aws" {
    region = "us-east-1"
}

terraform {
  backednd "s3"{

  bucket = "terraform-backup-057"
  key    = "roboshop/shell-scripting/terraform-tfstate"
  region =  "us-east-1"
  dynamo_table = "terraform"
  }
}