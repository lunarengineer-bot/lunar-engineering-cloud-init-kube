#########################
# User Group Validation #
#########################
# Every user shou

# resource "null_resource" "assertion" {
#   count = local.all_dns_resolvable ? 0 : 1

#   provisioner "local-exec" {
#     command = "echo 'Not all hosts are DNS resolvable' && false"
#   }
# }