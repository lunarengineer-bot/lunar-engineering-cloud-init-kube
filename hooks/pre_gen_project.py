"""Produce an SSH Key.

This makes an SSH key if it needs to for use in a cloud init file.

"""
import os
import pathlib
import subprocess
import sys

# This should appropriately account for relative, absolute, and ~ paths.
ssh_keypair_filepath = os.path.abspath(os.path.expanduser('{{ cookiecutter.ssh_keypair_filepath }}'))

if not os.path.exists(ssh_keypair_filepath):  # If the key DNE
    # Make an SSH Key.
    print(f"Writing SSH Key to {ssh_keypair_filepath}")
    subprocess.run(
        [
            'ssh-keygen',
            '-t', '{{ cookiecutter.ssh_cipher }}',
            '-a', '{{ cookiecutter.ssh_rounds }}',
            '-f', f'{ssh_keypair_filepath}',
            '-N', '{{ cookiecutter.ssh_passphrase }}',
            '-C', '{{ cookiecutter.ssh_username }}',
        ]
    )
else:
    print("SSH Already exists.")
