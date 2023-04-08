#!/bin/bash
set -x
# Create an output artifact folder.
mkdir -p artifacts
# Create an .ssh key for the testing routine.
ssh-keygen -t ed25519 \
    -a 100 \
    -f artifacts/lunarengineer-bot-key \
    -N "" \
    -C lunarengineerbot
# Pipe this SSH Key into a user-data script.
USER_KEY="$(cat artifacts/lunarengineer-bot-key.pub)"
# Create a user data file from the template, with the key in it.
sed "s:<USER_KEY>:$USER_KEY:g" user-data-template > artifacts/lunarengineer-bot-user-data