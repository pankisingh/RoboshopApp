resource "random_pet" "my-list" {
 prefix  = var.prefix[0]
}

output "random_pet" {
    value = var.prefix
}