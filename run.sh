#!/usr/bin/env bash

# set up bash to handle errors more aggressively - a "strict mode" of sorts
set -o errexit # give an error if any command finishes with a non-zero exit code
set -o nounset # give an error if we reference unset variables
set -o pipefail # for a pipeline, if any of the commands fail with a non-zero exit code, fail the entire pipeline with that exit code

SCRIPT_DIR=$(dirname $(readlink -f "$0")) # get the directory containing the bash script

sudo apt-get install ansible

# do software setup with Ansible
ansible-playbook \
    -i "$SCRIPT_DIR/inventory/local.ini" \
    --ask-become-pass \
    --extra-vars "user_name=az real_name='Anthony Zhang' email=me@anthonyz.ca" \
    "$SCRIPT_DIR/main.yml"

echo "PROVISIONING COMPLETE - RESTART MACHINE TO FULLY APPLY CHANGES"
