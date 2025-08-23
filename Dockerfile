# Docker image for interactive use in dev-container.
FROM archlinux:latest

# Merge customizations into /etc
COPY ./etc/. /etc/

RUN --mount=type=cache,target=/var/cache/pacman \
    pacman -Sy

RUN --mount=type=cache,target=/var/cache/pacman \
    pacman --noconfirm -S \
	reflector git fish sudo

RUN usermod -s /usr/bin/fish root

# Create user with `sudo` group to gain access to sudo without password. See
# `etc/sudoers.d/01-sudo-nopasswd`.
RUN groupadd sudo

# Create user with default name `dev`.
RUN useradd -m -G sudo -s /usr/bin/fish dev
USER dev
WORKDIR /home/dev

# Stay idle.
CMD ["sleep", "infinity"]
