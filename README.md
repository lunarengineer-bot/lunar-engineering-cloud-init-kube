# [Automate A Secure Cloud Image Creation and Usage](https://github.com/lunarengineer-bot/lunar-engineering-cloud-init-kube)

This is designed to create an ISO image for automating the process of adding kubernetes nodes to the Lunar Engineering compute cluster. This creates a USB-deployable [cloud-init](https://github.com/canonical/cloud-init) image when the main.sh script is run which is securely deployed to <WHERE>?.

This pulls secrets from the GitHub command line and pipes those into the creation of the cloud-init file; when the cloud-init file is written out it is piped into a testing routine which does some validation on the init.

There are two environments maintained in the secrets within this project; one of the environments is the development / testing environment, used simply to assert that everything is behaving appropriately, while the other is the production environment which generates and uses production output.

To test this, or to use this locally with your own secrets (i.e. 'I do not want to manage my secrets in GitHub, but I want to use this to bootstrap a cluster) you may create a local file and run `./local.sh`

TL;DR: `./main.sh`.

This automates a secure access pattern.

This authenticates and then uses GitHub secrets to write out a cloudinit file.

gh run
gh workflow (disable / enable / list / view / run)

todo act install

This uses 'act' to support local testing and development for the CI, which is implemented in GitHub Actions.

What is the purpose of this? The purpose is to generate SSH keys and include them in the cloud init file.

We have multiple environments. We have test and prod.

