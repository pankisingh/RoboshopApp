resource "random_pet" "my-list" {
 prefix  = var.prefix[0]
}

output "myName" {
    value = my-list.*.prefix[0]
}