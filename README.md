# [Automate A Secure Cloud Init](https://github.com/lunarengineer-bot/lunar-engineering-cloud-init-kube)

This is designed to create a cloud-init image for automating the process of adding kubernetes nodes to a compute cluster.

This was heavily inspired by [another project](https://github.com/paklids/rpi-terraform-rke.git)

## How do I use this?

Navigate to the src folder here and run gen-user-data.sh.
Use the files that it dumps out (keys and cloud init user data) to spin up machines.

## Testing Environment

I could not find an easy way to test cloud-init within a container. Ultimately, I got fed up and just booted up a VM; it's not as friendly with my workflows (VSCode and Github friendly) but it supports using *lxd*.

LXD makes vms easy. Like, seriously easy.

The tests folder demonstrates a method of spinning up a vm using lxc and attaching the user data to test cloud init.

You may interact with that test container to do things like:
1. Use `lxc console test-container` to drop into a shell within test-container.
2. Attempt to log in with a *password enabled user*. That's not included and must be added (example below.)

You may implement whatever testing you desire for your processes past this point.

This needs to transition to *more* general, but this is a good start.