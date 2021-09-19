variable "Sample"{
    default = "Hello World"
}

# variable "sample2"{}


# output "sample2" {
#     value = var.sample2
# }


output "sample" {
    value = var.Sample 
}

output "sample1" {
    value = "${var.Sample}" 
}

variable "string"{
    default = "Hello World"
}
variable "number"{
    default =10
}

variable "boolean"{
    default = true
}

variable "list" {
    default =["devops", true , 10]
}

output "list" {
    value = var.list[0]
}

variable "map" {
    default = {
        Role="devops Engineer"
        Age= 43
    }
}

output "map" {
    value = "My details - ${var.map["Role"]}"
}
output "string" {
    value = var.string
}


output "number" {
    value = var.number
}


output "bool" {
    value = var.boolean
}



variable "Fruits" {
}

output "Fruits" {
    value = "My Fav Fruits are - ${var.Fruits[0]}, ${var.Fruits[1]}"
}

variable "country" {
}

output "country" {
    value = var.country
}