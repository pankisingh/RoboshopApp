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
records    = [element(aws_spot_instance_request.cheap_worker.*.private_ip, count.index)]
}

locals {
  Length = length(var.COMPONENTS)
}

//COMPONENTS = ["mysql", "mongodb", "rabbitmq", "redis", "cart", "catalogue", "user", "shipping", "payment", "frontend"]

//resource "local_file" "inventory-file" {
//  content     = "[FRONTEND]\n${aws_instance.instances.*.private_ip[9]}\n[PAYMENT]\n${aws_instance.instances.*.private_ip[8]}\n[SHIPPING]\n${aws_instance.instances.*.private_ip[7]}\n[USER]\n${aws_instance.instances.*.private_ip[6]}\n[CATALOGUE]\n${aws_instance.instances.*.private_ip[5]}\n[CART]\n${aws_instance.instances.*.private_ip[4]}\n[REDIS]\n${aws_instance.instances.*.private_ip[3]}\n[RABBITMQ]\n${aws_instance.instances.*.private_ip[2]}\n[MONGODB]\n${aws_instance.instances.*.private_ip[1]}\n[MYSQL]\n${aws_instance.instances.*.private_ip[0]}\n"
//  filename    = "/tmp/inv-roboshop-${var.ENV}"
//}

locals {
  COMPONENTS = concat(aws_instance.db-instances.*.private_ip, aws_instance.app-instances.*.private_ip)
}

resource "local_file" "inventory-file" {
  content     = "[FRONTEND]\n${local.COMPONENTS[9]}\n[PAYMENT]\n${local.COMPONENTS[8]}\n[SHIPPING]\n${local.COMPONENTS[7]}\n[USER]\n${local.COMPONENTS[6]}\n[CATALOGUE]\n${local.COMPONENTS[5]}\n[CART]\n${local.COMPONENTS[4]}\n[REDIS]\n${local.COMPONENTS[3]}\n[RABBITMQ]\n${local.COMPONENTS[2]}\n[MONGODB]\n${local.COMPONENTS[1]}\n[MYSQL]\n${local.COMPONENTS[0]}\n"
  filename    = "/tmp/inv-roboshop-${var.ENV}"
}
