#! /usr/bin/env zsh

[[ ! -d /etc/apt/keyrings ]] && sudo mkdir -p /etc/apt/keyrings/

function install_apt_keyring() {
  name="$1"
  url="$2"
  tgt_location="${3:-/etc/apt/keyrings/${name//-/}-archive-keyring.gpg}"

  echo "=== installing ${name} apt repo keyring"
  curl --location --silent ${url} | gpg --dearmor | sudo install -m 0644 -o 0 -g 0 /dev/stdin ${tgt_location}
}


for name url in \
  github-cli https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  hashicorp https://apt.releases.hashicorp.com/gpg \
  kubernetes https://pkgs.k8s.io/core:/stable:/v1.34/deb/Release.key \
  mise https://mise.jdx.dev/gpg-key.pub
do
  install_apt_keyring ${name} ${url}
done
