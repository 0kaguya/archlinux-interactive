# Docker image for interactive use in dev-container.
FROM archlinux:latest

RUN --mount=type=cache,target=/var/cache/pacman \
    pacman -Sy

RUN pacman -Sy

RUN --mount=type=cache,target=/var/cache/pacman \
    pacman --noconfirm -S \
	reflector git fish

RUN usermod -s /usr/bin/fish root
WORKDIR /root

# Stay idle.
CMD ["sleep", "infinity"]
