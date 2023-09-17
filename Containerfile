ARG UPSTREAM_IMAGE="${UPSTREAM_IMAGE:-quay.io/fedora-ostree-desktops/silverblue}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-37}"

FROM ${UPSTREAM_IMAGE}:${FEDORA_MAJOR_VERSION} AS builder

ARG VERSION
RUN sed -i "s,^PRETTY_NAME=.*,PRETTY_NAME=\"Fedora Linux ${VERSION} \(Blueconfig\)\"," /usr/lib/os-release

COPY usr /usr

ADD build.sh /tmp/build.sh
RUN bash /tmp/build.sh

RUN rpm-ostree cleanup -m && ostree container commit
