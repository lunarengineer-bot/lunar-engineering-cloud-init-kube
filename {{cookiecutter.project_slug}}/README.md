# {{cookiecutter.organization_name}} Deployment Infrastructure

This project deploys the infrastructure which will be used in automation for {{cookiecutter.organization_name}}.

This will be used for:
1. Continuous Integration / Continuous Delivery
2. Storing Data.
3. Hosting Services.

You may find the control panel for the infrastructure [here](Insert Rancher link post deployment.)

## SETUP AND TROUBLESHOOT

This section may be removed from your README at any point after deployment.

### Assumptions

1. This assumes you have a proxmox cluster. If you do not have one, it is a very simple process that requires nothing other than a thumb drive, a computer you wish to put proxmox on, and a computer that you use otherwise, coupled with some of your time and modest experience with IT.
2. This assumes that you have information concerning your proxmox cluster and that the values were appropriate at the time you deployed this project. If you have a proxmox cluster you should be able to find (or learn how to find) elements of information like the proxmox api url. If you feel this needs more information, please feel free to reach back to me.
3. This assumes that all the selections made in the project initialization are appropriate.

### Order of Operations

During deployment this project:

1. Checks for credentials at `{{cookiecutter.ssh_keypair_filepath}}`: If credentials do not exist they are *created* and execution is short-circuited.
2. Tests for SSH connectivity with the Proxmox cluster: If connectivity cannot be established execution is short-circuited.
3. Automates proxmox node setup: If this fails execution is short-circuited.
4. Tests for project deployment by deploying a single node into the cluster: If deployment fails execution is short-circuited.
5. Deploys the stack.