ARG UPSTREAM_IMAGE="${UPSTREAM_IMAGE:-quay.io/fedora-ostree-desktops/silverblue}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"

FROM ${UPSTREAM_IMAGE}:${FEDORA_MAJOR_VERSION} AS builder
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"

LABEL org.opencontainers.image.title="Fedora Silverblue"
LABEL org.opencontainers.image.description="Customized Fedora Silverblue (Blueconfig)"
LABEL org.opencontainers.image.source="https://github.com/aorith/blueconfig"
LABEL org.opencontainers.image.licenses="MIT"

RUN sed -i "s,^PRETTY_NAME=.*,PRETTY_NAME=\"Fedora Linux $(rpm -E %fedora) \(Blueconfig\)\"," /usr/lib/os-release

COPY rootfs /

# RPM Fusion
RUN wget -P /tmp/rpms/ \
        "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_MAJOR_VERSION}.noarch.rpm" \
        "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_MAJOR_VERSION}.noarch.rpm" \
    && rpm-ostree install /tmp/rpms/*.rpm fedora-repos-archive

# Docker
RUN wget -P /etc/yum.repos.d/ \
        "https://download.docker.com/linux/fedora/docker-ce.repo" \
    && wget -P /tmp/ \
        "https://download.docker.com/linux/fedora/gpg" \
    && install -o 0 -g 0 -m644 "/tmp/gpg" "/etc/pki/rpm-gpg/docker-ce.gpg"


COPY packages.sh /tmp/packages.sh
RUN bash /tmp/packages.sh

# Enable automatic updates
RUN sed -i 's,.*AutomaticUpdatePolicy=.*,AutomaticUpdatePolicy=stage,g' /etc/rpm-ostreed.conf \
    && systemctl enable rpm-ostreed-automatic.timer \
    && systemctl enable rpm-ostree-countme.timer

# Enable sockets
RUN systemctl enable docker.socket libvirtd.socket

# Disable suspend & hibernate
RUN systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

RUN fc-cache --system-only --really-force --verbose \
        && rm -rf /tmp/* \
        && ostree container commit \
        && mkdir -p /var/lib \
        && mkdir -p /var/tmp && chmod -R 1777 /var/tmp
