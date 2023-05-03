# [Automate A Secure Cloud Init Enabled Kubernetes Cluster](https://github.com/lunarengineer-bot/lunar-engineering-cloud-init-kube)

This project is designed to 'easy-button' a custom proxmox k3s cluster.

It does this in two phases:

* Phase 1: Using CookieCutter this creates a local project customized to your needs, including This is designed to create a cloud-init image (using Cookiecutter) project to assist automating the process of adding kubernetes nodes to a compute cluster.

This deploys in two phases; the first phase deploys a project customized to your environment and your hardware into your local environment, initializing a git repository at the same time.

You need python and cookiecutter; if you've got python you can pip install cookiecutter.

There are two ways to use this:

1. Interactively: `cookiecutter git@github.com:lunarengineer-bot/lunar-engineering-cloud-init-kube.git` will ask you nicely what you'd like and where you want to put it.
2. '[Sudo make me a sandwich](https://xkcd.com/149/)': `cookiecutter git@github.com:lunarengineer-bot/lunar-engineering-cloud-init-kube.git --no-input` will just create a 'cloud-init-files' folder with a cloud init user-data.yml in it.

## Development

If you clone this project down you can open it in a devcontainer (easy to do using VSCode.)

Now, run `cookicutter . --no-input`. Modify the template and the cookiecutter.json as appropriate to achieve desired behavior.

Tests will come if I ever care enough to be arsed.

### Testing Environment

If you are modifying the cloud-init user configuration you'll probably want an environment to test it in.

I could not find an easy way to test cloud-init within a container. Ultimately, I got fed up and just booted up a VM; it's not as friendly with my workflows (VSCode and Github friendly) but it supports using *lxd*.

LXD makes vms easy. Like, seriously easy.

The tests folder demonstrates a method of spinning up a vm using lxc and attaching the user data to test cloud init.

You may interact with that test container to do things like:
1. Use `lxc console test-container` to drop into a shell within test-container.
2. Attempt to log in with a *password enabled user*. That's not included and must be added.

You may implement whatever testing you desire for your processes past this point.