resource "random_pet" "my-list" {
 prefix  = var.prefix
}

output "myName" {
    value = random_pet.my-list.*.prefix
}