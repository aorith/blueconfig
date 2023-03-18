ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-37}"

FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_MAJOR_VERSION} AS builder

ARG VERSION

ADD build.sh /tmp/build.sh
COPY usr /usr
COPY etc /etc

RUN chmod +x /tmp/build.sh && /tmp/build.sh

RUN rm -rf /tmp/* /var/* && mkdir -p /var/tmp && chmod -R 1777 /var/tmp
RUN sed -i "s,^PRETTY_NAME=.*,PRETTY_NAME=\"Fedora Linux ${VERSION} \(Blueconfig\)\"," /usr/lib/os-release
RUN rpm-ostree cleanup -m && ostree container commit
