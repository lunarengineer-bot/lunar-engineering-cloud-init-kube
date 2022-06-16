#!/bin/bash
echo "Running local boot iso generation"
# First, install act if necessary.
if ! command -v act &> /dev/null
then
    echo "act does not appear to be installed."
    echo "Installing act from https://raw.githubusercontent.com/nektos/act/master/install.sh."
    curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
    exit
fi
# Now we're going to look for a local key file.
# If it does not exist, we are going to generate it.
# The structure of this key
act --secret-file local_keys.secrets
