resource "aws_instance" "web" {
    ami                        = "ami-074df373d6bafa625"
    instance_type              = "t2.micro"
    svpc_security_group_ids    =  []
    tags                       = {
                    Name     = "Sample"   
                } 
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "allow_ssh"

  ingress = [
    {
      description      = "Tssh"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  tags = {
    Name = "allow_ssh"
  }
}

output "sg-attributes" {
    value = aws_security_group.allow_ssh
}