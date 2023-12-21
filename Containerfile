ARG UPSTREAM_IMAGE="${UPSTREAM_IMAGE:-quay.io/fedora-ostree-desktops/silverblue}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-39}"

FROM ${UPSTREAM_IMAGE}:${FEDORA_MAJOR_VERSION} AS builder

ARG VERSION
RUN sed -i "s,^PRETTY_NAME=.*,PRETTY_NAME=\"Fedora Linux ${VERSION} \(Blueconfig\)\"," /usr/lib/os-release

COPY etc /etc
COPY usr /usr

ADD build.sh /tmp/build.sh
RUN bash /tmp/build.sh

ADD install-nerd-font.sh /tmp/install-nerd-font.sh
RUN bash /tmp/install-nerd-font.sh 3.1.1 Hack \
        && bash /tmp/install-nerd-font.sh 3.1.1 JetBrainsMono \
        && bash /tmp/install-nerd-font.sh 3.1.1 IBMPlexMono \
        && bash /tmp/install-nerd-font.sh 3.1.1 IosevkaTerm \
        && bash /tmp/install-nerd-font.sh 3.1.1 SourceCodePro \
        && rm -rf /tmp/*

RUN rpm-ostree cleanup -m && ostree container commit
