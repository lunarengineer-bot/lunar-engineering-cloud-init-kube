#!/bin/bash
# Create a testing network.
lxc network create testing_net --type=bridge
# Use a flavor of Ubuntu to create a VM using this network configuration and user configuration
lxc launch ubuntu:22.04 test-container \
    --config=cloud-init.user-data="$(cat cloud-init-files/user-data.yml)"
# Attach that container to this testing network to ensure a unique IP.
lxc network attach testing_net test-container eth0