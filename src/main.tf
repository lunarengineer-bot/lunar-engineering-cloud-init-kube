####################################################################
#                       Cloud Organization                         #
# ---------------------------------------------------------------- #
# This file produces a cloud organization set of cloud-init config #
#   files. It produces one file per host with all the appropriate  #
#   users, groups, and whatever else was passed.                   #
# TODO: Wireguard.
# Note that if you DO NOT give me ssh keys I will generate my own. #
# SSH IS MORE SECURE. DEAL WITH IT!
####################################################################



locals {
  usernames = [for user in var.users : lookup(user, "username", "NA")]
  default_group = {
    "groupname" : "${var.organization_name}",
    "groupmembers" : local.usernames
  }
  groupnames = var.groups == null ? [local.default_group.groupname] : concat([local.default_group], var.groups)
}


#########################
# Auto-Build Components #
#########################
# Thanks GPT! GPTs let me build this neat automated pattern.
# Wouldn't be GPT without breakages, though, so it took some finagling.
# This picks up all the templates and builds them, one after another.
# It just lets you put arbitrary files out there and they're all built in turn.check
# You just stuff all the input variables in, regardless of which template they're in.
locals {
  component_file_set = sort(fileset("${path.module}/components", "*.tftpl"))
  flname_map         = { for tpl in local.component_file_set : split("_", tpl)[1] => "${path.module}/components/${tpl}" }
}

locals {
  templates = { for k, v in local.flname_map : k => templatefile(v, {
    organization_name = var.organization_name
    users             = var.users
    groups            = jsonencode(local.groupnames)
    packages          = var.packages
  }) }
}

# This jams all the built templates together.
data "template_file" "cloud_init" {
  template = replace(join("\n", values(local.templates)), "EOT\n", "")
}

# This lets me get at the output cloud init file.
output "cloudinitfile" {
  value = data.template_file.cloud_init.rendered
}


# locals {
#     user_data_files = {
#         # We need a file for each host.
#         for host in var.hosts :
#         host => templatefile(
#             "${path.module}/cloud-init.yaml.tftpl",
#             { users = users, groups = groups }
#         )
#     }
# }