ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-37}"

FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_MAJOR_VERSION} AS builder

ARG VERSION
RUN sed -i "s,^PRETTY_NAME=.*,PRETTY_NAME=\"Fedora Linux ${VERSION} \(Blueconfig\)\"," /usr/lib/os-release

COPY files/etc /etc

ADD build.sh /tmp/build.sh
RUN bash /tmp/build.sh

RUN rpm-ostree cleanup -m && ostree container commit
