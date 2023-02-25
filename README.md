# [Automate A Secure Cloud Init](https://github.com/lunarengineer-bot/lunar-engineering-cloud-init-kube)

This is designed to create a cloud-init image for automating the process of adding kubernetes nodes to a compute cluster.

This was heavily inspired by [another project](https://github.com/paklids/rpi-terraform-rke.git)

## Testing Environment

I could not find an easy way to test cloud-init within a container. Ultimately, I got fed up and just booted up a VM; it's not as friendly with my workflows (VSCode and Github friendly) but it supports using *lxd*.

LXD makes vms easy. Like, seriously easy.

Boot up a VM and, inside the rancher_pi folder, you may run `script.sh` to deploy a cloud-init based container with lxc named `test-container`.

You may interact with that test container to do things like:
1. Use `lxc console test-container` to drop into a shell within test-container.
2. Attempt to log in with a *password enabled user*. That's not included and must be added (example below.)

You may implement whatever testing you desire for your processes past this point.

### Test user-data

This enables a password based user.

```yaml
#cloud-config
# vim: syntax=yaml
#
growpart: { mode: "off" }
locale: en_US.UTF-8
resize_rootfs: false
ssh_pwauth: false
system_info:
  default_user:
    name: terraform
users:
  - default
  - name: terraform
    gecos: Terrafom User
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, adm, docker, sudo
    lock_passwd: true
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAA...== terraformuser
  - name: pi
    shell: /bin/bash
    lock_passwd: true
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin, sudo
    plain_text_passwd: 'raspberry'
