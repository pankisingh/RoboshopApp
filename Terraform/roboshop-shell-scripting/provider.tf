provider "aws" {
    region = "us-east-1"
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3"{
  bucket = "terraform-state-b57"
  key    = "roboshop/shell-scripting/terraform-tfstate"
  region =  "us-east-1"
  dynamodb_table = "terraform-lock"
  }
}