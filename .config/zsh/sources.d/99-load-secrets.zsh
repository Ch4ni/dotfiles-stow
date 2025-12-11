#! /usr/bin/env zsh

for secretfile in ${HOME}/.config/secrets/*.zsh; do
    source ${secretfile}
done
