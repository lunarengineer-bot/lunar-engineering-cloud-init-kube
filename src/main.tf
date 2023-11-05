# What variables do I have in this?
# I have users, groups

variable "hosts" {
    type = set(string)
    default = ["localhost"]
}

variable "users" {
    type = list(object({
        username=string
    }))
    default = [{
        username = "tim"
    }]
}

variable "groups" {
    type = list(object({
        group_name=string,
        group_members=list(string)
    }))
    default = []
}

variable "packages" {
    type = list(string)
    default = [ "ntp" , "qemu-agent"]
}

locals {
    user_data_files = {
        # We need a file for each host.
        for host in var.hosts :
        host => templatefile(
            "${path.module}/cloud-init.yaml.tftpl",
            { users = users, groups = groups }
        )
    }
}
