#! /usr/bin/env zsh

zparseopts -D -K -- \
    {d,-unstow}=unstow \
    {v+,-verbose+}=verbose \
    {g,s,-root,-global,-system}=system


config_dir=${XDG_CONFIG_HOME:-${HOME}/.config}
repo_dir=${0:h}
pkg_dir=${repo_dir}/packages

function install_pkgs() {
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
}

function install_system_pkgs() {
  sys_pkg_dir=${repo_dir}/system/packages

  for package in ${sys_pkg_dir}/[0-9][0-9]-*(/); do
    pkg_name=${package:t}

    printf '\n=== installing system package: %s\n\n' ${pkg_name#??-}
    sudo stow --verbose=${#verbose} -d ${sys_pkg_dir} -t / -R ${unstow:+-D} ${pkg_name} 2>&1 | sed 's/^/\t/'
  done
}

function run_system_scripts() {
  sys_script_dir=${repo_dir}/system/scripts
  for script_dir in ${sys_script_dir}/*(/); do

    pkg_name=${${package:t}#??-}

    for script in ${script_dir}/*(.); do
      script_name=${script:t}
      printf '\n=== running system script: %s/%s\n\n' ${pkg_name} ${script_name}
      ${script} 2>&1| sed 's/^/\t/'
    done
  done
}

if [[ -n "${system}" ]]; then
  install_system_pkgs && run_system_scripts
else
  install_pkgs
fi

