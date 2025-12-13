#! /usr/bin/env zsh

stow -vv -t ${HOME} initial
stow -vv -t ${HOME} --dotfiles zsh
stow -vv -t ${HOME} --dotfiles git
stow -vv -t ${HOME} nvim

# TODO: refactor zsh into its own package
# TODO: refactor git into its own package
