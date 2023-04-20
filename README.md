# [Automate A Secure Cloud Init Enabled Kubernetes Cluster](https://github.com/lunarengineer-bot/lunar-engineering-cloud-init-kube)

This is designed to create a cloud-init image (using Cookiecutter) to assist automating the process of adding kubernetes nodes to a compute cluster.

## How do I use this?

This uses a project called CookieCutter to either interactively (or not) build templated files which go through the process of creating cloud init user data files and *also* don't leak secrets accidentally.

You need python and cookiecutter.

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
2. Attempt to log in with a *password enabled user*. That's not included and must be added (example below.)

You may implement whatever testing you desire for your processes past this point.