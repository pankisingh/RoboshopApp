resource "aws_instance" "sample" {
  ami                   = "ami-074df373d6bafa625"
  instance_type         = "t2.micro"

  tags                  = {
    Name                = "Sample2"
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform{
    backend "s3" {
        bucket = "terraform-state-b57"
        key    = "sample/terraform-tfstate"
        region = "us-east-1"
        dynamodb_table = "terraform"
    }
}