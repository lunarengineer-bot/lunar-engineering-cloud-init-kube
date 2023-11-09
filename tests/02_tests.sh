#!/bin/bash
#############################
# The Stupid Testing Script #
#############################
# Deploying a VM and running the bootstrapping procedure on it
#   when using cloud-init, has requirements which I wasn't able
#   to get working in a container, so must be done via VM.
# This 'tests' the cloud-init setup during the setup.sh.
# Basically, if the testing script can run, the setup worked.
# This runs required tests.
# 1. Run setup
# 2. Run tests *MANUALLY*
lxc list test-container -c 4 # Get IPV4
# ssh whomever@ipv4
lxc exec test-container -- bash -c "cat /var/log/cloud-init.log"
lxc exec test-container -- bash -c "cat /root/.ssh/authorized_keys"
# 3. Run teardown