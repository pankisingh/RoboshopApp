resource "random_name" "my-list" {
 prefix  = var.prefix[0]
}

output "my-Name" {
    value = random_name.my-list.prefix
}

output "name"{
 value = var.prefix[0]
}
