variable "organization_name" {
  type        = string
  default     = "private-org"
  description = "Defines the group containing everything."
}


variable "hosts" {
  type        = set(string)
  default     = ["localhost"]
  description = "This is a set of DNS resolvable hostnames. Each gets a cloudinit file."
}


variable "users" {
  type = list(object({
    username       = string
    sudo           = bool
    ssh_public_key = string
  }))
  default = [{
    username = "tim",
    sudo     = true,
    ssh_public_key = "Whatever"
  }]
}


variable "groups" {
  type = list(object({
    groupname    = string,
    groupmembers = list(string)
  }))
  default = null
}