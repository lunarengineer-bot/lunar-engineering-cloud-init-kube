import os
from .credentials import write_key

# This should appropriately account for relative, absolute, and ~ paths.
ssh_keypair_filepath = os.path.abspath(
    os.path.expanduser('{{ cookiecutter.ssh_keypair_filepath }}')
)

# This attempts to get a key from this location, will write one if
#   one does not exist.
# If it writes, it will break.
write_key(ssh_keypair_filepath)

# This attempts to conduct an ssh login to the server, will fail if
#   the key is not valid.

# TODO: Add a check to see if the key is valid.
def test_ssh_login():
    """Connect to the server with the keypair."""
    # This line uses python