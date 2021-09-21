module "sg" {
    source = "./sg"
    
}

module "ec2" {
    source = "./ec2"
    SG_ID  = module.sg.SG_ID
}

provider "aws" {
    region = "us_east_1"
}