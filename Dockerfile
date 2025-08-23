# Docker image for interactive use in dev-container.
FROM archlinux:latest

RUN --mount=type=cache,target=/var/cache/pacman \
    pacman -Sy

RUN pacman -Sy

RUN --mount=type=cache,target=/var/cache/pacman \
    pacman --noconfirm -S \
	reflector git fish sudo

RUN usermod -s /usr/bin/fish root

# Create user with `sudo` group to gain access to sudo without password.
COPY sudoers.d/01-sudo-nopasswd /etc/sudoers.d/01-sudo-nopasswd

# Create user with default name `dev`.
RUN useradd -m -G sudo -s /usr/bin/fish dev
USER dev
WORKDIR /home/dev

# Stay idle.
CMD ["sleep", "infinity"]
