#!/bin/sh

# Variables
config_dir=$(cd $(dirname $0); pwd);
sudo_pass=$1;
nixos_dir=/etc/nixos;
hardware_config=hardware-configuration.nix

# Input sudo password if not given from command line
if [ -z ${sudo_pass} ]; then
    echo -n "Enter sudo password: ";
    read -s sudo_pass;
fi

# Get hardware configuration
cp -f ${nixos_dir}/${hardware_config} ${config_dir};

# Build system
echo ${sudo_pass} | sudo -S nixos-rebuild switch \
                         --flake ${config_dir}#nixos;
result=$?;

# Erase hardware configuration
rm -f ${config_dir}/${hardware_config};
touch ${config_dir}/${hardware_config};

# When system build was failure, return error status
if [ ${result} -ne 0 ]; then
    echo "nixos-rebuild was failure!"
    exit 1;
fi
