resource "random_pet" "my-list" {
 prefix  = var.prefix[0]
}

output "myName" {
    value = random_pet.my-list.prefix
}