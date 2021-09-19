variable "Sample"{
    default = "Hello World"
}

variable "sample2"{}


output "sample2" {
    value = var.sample2
}


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


output "string" {
    value = var.string
}


output "number" {
    value = var.number
}


output "bool" {
    value = var.boolean
}




