#!/bin/sh

# Variables
project_dir=${HOME}/projects;
config_dir=${project_dir}/nixos-config;
config_url="https://github.com/yam-k/nixos-config.git";

# Input sudo password
echo -n "Enter sudo password: ";
read -s sudo_pass;

# Delete old files and create project directory
if [ -e ${config_dir} ]; then
    echo ${sudo_pass} | sudo -S rm -rf ${config_dir};
fi
if [ -f ${project_dir} ]; then
    echo ${sudo_pass} | sudo -S rm -f ${project_dir};
fi
if [ ! -e {$project_dir} ]; then
    mkdir -p ${project_dir};
fi

# Download configuration files
nix-shell --packages git \
          --command "git clone ${config_url} ${config_dir}" \
    || exit 1;

# Build system
${config_dir}/rebuild.sh ${sudo_pass} || exit 1;

# Wait WiFi connection
sleep 30s;

# Some settings
LANG="C" xdg-user-dirs-update;

emacs_dir=${project_dir}/emacs-settings;
emacs_url="https://github.com/yam-k/emacs-settings.git";
git clone ${emacs_url} ${emacs_dir} \
    && ${emacs_dir}/utils/setup.sh;

rustup default stable;
rustup component add rust-src;
rustup component add rust-analyzer;
