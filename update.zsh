#! /usr/bin/env zsh

set -x
config_dir=${XDG_CONFIG_HOME:-${HOME}/.config}
repo_dir=${0:h}
pkg_dir=${repo_dir}/packages
set +x

stow -vv -d ${pkg_dir} -t ${config_dir} --dotfiles 10-mise-cfg
stow -vv -d ${pkg_dir} -t ${config_dir} --dotfiles 19-starship-cfg
stow -vv -d ${pkg_dir} -t ${HOME} --dotfiles 20-zsh
stow -vv -d ${pkg_dir} -t ${HOME} --dotfiles 40-git
stow -vv -d ${pkg_dir} -t ${HOME} --dotfiles 50-nvim

