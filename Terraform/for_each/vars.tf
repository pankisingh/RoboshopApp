variable "filename" {
  type = set(string)
  default = [
    "/home/centos/RoboshopApp/Terraform/for_each/hello1.txt",
    "/home/centos/RoboshopApp/Terraform/for_each/hello2.txt",
    "/home/centos/RoboshopApp/Terraform/for_each/hello3.txt",
  ]
}