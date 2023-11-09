#!/bin/bash
# Tear everything down.
lxc stop test-container
lxc delete test-container
rm -rf artifacts
# I should delete the network too. Oh well. Someday.