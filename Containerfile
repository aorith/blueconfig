ARG UPSTREAM_IMAGE="${UPSTREAM_IMAGE:-quay.io/fedora-ostree-desktops/silverblue}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"

FROM quay.io/fedora/fedora:${FEDORA_MAJOR_VERSION} AS builder

WORKDIR /tmp

RUN touch /.dockerenv \
    && dnf install -y xz --setopt=install_weak_deps=False \
    && useradd nix && mkdir -m 0755 /nix && chown nix /nix

USER nix
RUN curl -fLs https://nixos.org/nix/install | sh -s -- --no-daemon --yes

USER root
RUN cp -pr /home/nix/.local/state/nix/profiles/profile-1-link /nix/var/nix/profiles/default

FROM ${UPSTREAM_IMAGE}:${FEDORA_MAJOR_VERSION}

LABEL org.opencontainers.image.title="Fedora Silverblue"
LABEL org.opencontainers.image.description="Customized Fedora Silverblue (Blueconfig)"
LABEL org.opencontainers.image.source="https://github.com/aorith/blueconfig"
LABEL org.opencontainers.image.licenses="MIT"

RUN sed -i "s,^PRETTY_NAME=.*,PRETTY_NAME=\"Fedora Linux $(rpm -E %fedora) \(Blueconfig\)\"," /usr/lib/os-release

COPY --from=builder --chown=1000:1000 /nix /usr/share/nix
COPY rootfs /
COPY build.sh /tmp/build.sh
RUN bash /tmp/build.sh
