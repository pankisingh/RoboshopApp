resource "random_pet" "my-list" {
 prefix  = var.prefix[0]
}

output "my-Name" {
    value = random_pet.my-list.prefix
}

output "name"{
 value = var.prefix[0]
}