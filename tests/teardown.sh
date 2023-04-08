#!/bin/bash
# Tear everything down.
lxc stop test-container
lxc delete test-container
rm -rf artifacts