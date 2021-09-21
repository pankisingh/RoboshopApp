
resource "aws_security_group" "allowssh" {
  name        = "allowssh"
  description = "allowssh"

  ingress {
      description      = "ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  
  egress {
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
    }
  

  tags = {
    Name = "allowssh"
  }
}

output "SG_ID" {
    value = aws_security_group.allowssh.id
}

output "IP" {
    value = var.private_ip
}


variable "private_ip"{

}