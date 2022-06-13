# [Automate A Secure Cloud Image](https://github.com/lunarengineer-bot/lunar-engineering-cloud-init-kube)

This is designed to create an ISO image for automating the process of adding kubernetes nodes to a compute cluster. This creates a USB-deployable cloud-init image when the main.sh script is run.

TL;DR: `./main.sh`.

This automates a secure access pattern.

This authenticates and then uses GitHub secrets to write out a cloudinit file.