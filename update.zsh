#! /usr/bin/env zsh

zparseopts -D -K -- \
	{d,-unstow}=unstow \
	{v+,-verbose+}=verbose


config_dir=${XDG_CONFIG_HOME:-${HOME}/.config}
repo_dir=${0:h}
pkg_dir=${repo_dir}/packages

for package in ${pkg_dir}/[0-9][0-9]-*(/); do
    pkg_name=${package:t}

    if [[ ${pkg_name} == *-cfg ]]; then
	printf '\n=== installing configuration package: %s\n\n' ${${pkg_name#??-}%-cfg}
	stow --verbose=${#verbose} -d ${pkg_dir} -t ${config_dir} -R --dotfiles ${unstow:+-D} ${pkg_name} 2>&1 | sed 's/^/\t/'

    else
	printf '\n=== installing package: %s\n\n' ${${pkg_name#??-}%-cfg}
	stow --verbose=${#verbose} -d ${pkg_dir} -t ${HOME} -R --ignore '.*/.steam/.*' --dotfiles  ${unstow:+-D} ${pkg_name} 2>&1 | sed -e '/^BUG in find_stowed_path/d' -e 's/^/\t/'

    fi

done

