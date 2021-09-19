variable "Sample"{
    default = "Hello World"
}

output "sample" {
    value = var.Sample 
}


output "sample1" {
    value = "${var.Sample}" 
}