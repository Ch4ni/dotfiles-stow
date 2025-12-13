#! /usr/bin/env zsh

config_dir=${XDG_CONFIG_HOME:-${HOME}/.config}
repo_dir=${0:h}
pkg_dir=${repo_dir}/packages

stow -vv -d ${pkg_dir} -t ${config_dir} --dotfiles -D 10-mise-cfg
stow -vv -d ${pkg_dir} -t ${config_dir} --dotfiles -D 19-starship-cfg
stow -vv -d ${pkg_dir} -t ${HOME} --dotfiles -D 20-zsh
stow -vv -d ${pkg_dir} -t ${HOME} --dotfiles -D 40-git
stow -vv -d ${pkg_dir} -t ${HOME} --dotfiles -D 50-nvim

