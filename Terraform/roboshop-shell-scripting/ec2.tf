# Request a spot instance at $0.03
resource "aws_spot_instance_request" "cheap_worker" {
  count                  = local.Length
  ami                    = "ami-074df373d6bafa625"
  spot_price             = "0.03"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  wait_for_fulfillment  = true
  tags = {
    Name        = element(var.COMPONENTS, count.index)
    }
}


resource "aws_security_group" "allow_ssh" {
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
    Name = "allow_ssh"
  }
}

resource "aws_ec2_tag" "name_tag" {
  count                 = local.Length
  resource_id           = element(aws_spot_instance_request.cheap_worker.*.spot_instance_id, count.index)
  key                   = "Name"
  value                  = element(var.COMPONENTS, count.index)
}

resource "aws_route53_record" "records" {
count       = local.Length
name        = element(var.COMPONENTS, count.index)
type        = "A"
zone_id     = "Z01980721OZZ7K55MWU3"
ttl         = 300
records     = [element(aws_spot_instance_request.cheap_worker.*.private_id, count.index)]
}

resource "null_resource" "run-shell-scripting" {
  count         = local.Length
  provisioner "remote-exec" {
  connection {
    host        = element(aws_spot_instance_request.cheap_worker.*.public_id, count.index)
    user        = "centos"
    password    =   DevOps321

  }
    inline =[
    "cd/home/centos",
    "git clone https://github.com/pankisingh/RoboshopApp",
    "cd Terraform/roboshop-shell-scripting",
    "sudo make ${element(var.COMPONENTS, count.index )}"
    ]
  }
}

locals {
  Length = length(var.COMPONENTS)
}