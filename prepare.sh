#!/usr/bin/bash

# Checking pre-requisites...

command -v stow &> /dev/null ||
    (echo "Missing command: `stow`" && exit 1)

command -v reflector &> /dev/null ||
    (echo "Missing command: `reflector`" && exit 2)

mkdir ./etc/pacman.d ||
    (echo "Please run at project root" && exit 3)

# Install githooks.

env -C stow/ -S stow git

# Generates pacman mirrorlist.

reflector --threads 16 --protocol https --age 12 --sort rate -n 5 \
    --save ./etc/pacman.d/mirrorlist
