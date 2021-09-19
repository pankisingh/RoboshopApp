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