variable "ENV" {
}

resource "aws_security_group" "allow-ssh" {
  name        = "allow-ssh-${var.ENV}"
  description = "allow-ssh-${var.ENV}"

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
    Name = "allow-ssh-${var.ENV}"
  }
}