ARG UPSTREAM_IMAGE="${UPSTREAM_IMAGE:-quay.io/fedora-ostree-desktops/silverblue}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"

FROM quay.io/fedora/fedora:${FEDORA_MAJOR_VERSION} AS builder

WORKDIR /tmp
COPY install-nix.sh /tmp/install-nix.sh
RUN bash /tmp/install-nix.sh

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
