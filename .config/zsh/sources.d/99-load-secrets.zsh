#! /usr/bin/env zsh

# This is kind of a hack-job meant to unblock me until I've got time to set up a proper
# shell secrets management solution.
#
# Define the default secrets dir (~/.config/secrets), and if it doesn't exist then
# create it with rwx permissions for only the owner.
# Iterate through all of the files in the directory, and source them.

# TODO: replace this with an actual dynamic secrets management solution. Preferably
# something that's encrypted at rest. In the meantime:
# DO NOT COMMIT THE CONTENTS OF ~/.config/secrets TO SOURCE CONTROL.

SECRETS_D_DIR=${SECRETS_D_DIR:-${XDG_CONFIG_HOME:-${HOME}/.config}/secrets}
if [[ ! -d ${SECRETS_D_DIR} ]]; then
  install -d -m 0700 ${SECRETS_D_DIR}
fi

for secretfile in ${HOME}/.config/secrets/*.zsh; do
    source ${secretfile}
done
