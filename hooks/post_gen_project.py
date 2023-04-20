"""Copy SSH Key into user-data.

This copies an existing SSH key into a user-data file."""

import os

# Filepath for the public key
ssh_keypair_filepath = os.path.abspath(
    os.path.expanduser(
        '{{ cookiecutter.ssh_keypair_filepath }}'
    )
) + '.pub'

with open('user-data.yml', 'r') as template_file:
    template = template_file.read()

with open(ssh_keypair_filepath, 'r') as ssh_keyfile:
    ssh_key = ssh_keyfile.read()

with open('user-data.yml', 'w') as output_file:
    output_file.write(
        template.replace('<USER_KEY>', ssh_key)
    )
