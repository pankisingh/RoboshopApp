module "sg" {
    source = "./sg"
    private_ip = module.ec2.private_ip
}

module "ec2" {
    source = "./ec2"
    SG_ID  = module.sg.SG_ID
}

provider "aws" {
    region = "us_east_1"
}