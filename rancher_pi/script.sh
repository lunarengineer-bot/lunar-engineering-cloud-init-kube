#!/bin/bash
lxc launch ubuntu-daily:bionic test-container \
  --config=user.network-config="$(cat network-config)" \
  --config=user.user-data="$(cat user-data)"