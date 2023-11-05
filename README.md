# [Automate Cloud Init Config Generation](https://github.com/lunarengineer-bot/lunar-engineering-cloud-init-kube)

This is designed to be plugged into a larger Terraform structure. As such, it's simply built with an expectation in mind that it has a src directory which exposes a terraform project.

The details beyond that I just don't care about.

## How do I use this?

You've got your project set up, you clone this puppy down into it somewhere, and then you call it as a Terraform module with some inputs (see vars.tf at the root level.)

When you call it you're going to feed it a simplified input representation (fun enhancement: and potentially an organizational mapping document) which builds a set of files for reuse.

## Development

What does this do? Well, when you give it a simplified set of inputs it's going to generate cloud init configurations according to your specifications.

What does that look like?

It looks like an input variable which is arbitrarily descriptive that results in a dataset from which I can obtain a set of nodes and their communications structure; given that a node has communication capability established this recipe deploys a templated cloud init file which is dependent on the chunks.
THis is intended to be used in preprovision and, as such, it is called upon a set of bare resources.

So, how do I arbitrarily describe group structure in just a few inputs?

DNS resolution!

### Terraform Patterns

%{ for addr in ip_addrs ~}
backend ${addr}:${port}
%{ endfor ~}

> templatefile("${path.module}/backends.tftpl", { port = 8080, ip_addrs = ["10.0.0.1", "10.0.0.2"] })
backend 10.0.0.1:8080
backend 10.0.0.2:8080

%{ for config_key, config_value in config }
set ${config_key} = ${config_value}
%{ endfor ~}

> templatefile(
               "${path.module}/config.tftpl",
               {
                 config = {
                   "x"   = "y"
                   "foo" = "bar"
                   "key" = "value"
                 }
               }
              )

### Testing Environment

If you are modifying a cloud-init user configuration you'll probably want an environment to test it in.

The tests folder shows a recipe for testing.


Potential additional interesting sections:
* [ansible](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#ansible): Can run a playbook after deployment.
* [certs](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#ca-certificates): Deploy certs.
* [disk setup](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#disk-setup): Disk partitioning.
* [hotplug](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#install-hotplug): Udev hotplugging.
* [keyboard](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#keyboard)
* [locale](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#locale): Set system locale.
* [mounts](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#mounts): Mount things.
* [ntp](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#ntp): Potentially necessary.
* [update packages](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#package-update-upgrade-install): Self explanatory.
* [phone home](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#phone-home): POST to url.
* [scripts per...](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#scripts-per-boot): Scripts to run on boot, once, and create.
* [set hostname](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#set-hostname): Yep.
* [snap](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#snap): microk8s
* [ssh](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#ssh): SSH...
* [ssh import id](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#ssh-import-id): can make life simple
* [update hosts](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#update-etc-hosts)
* [users and groups](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#users-and-groups)
* [wireguard](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#wireguard): VPN!
* [write files](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#write-files): write files on boot.