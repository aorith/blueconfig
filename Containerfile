ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-37}"

FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_MAJOR_VERSION} AS builder

ADD build.sh /tmp/build.sh
COPY usr /usr
COPY etc /etc

RUN chmod +x /tmp/build.sh && /tmp/build.sh

RUN rm -rf /tmp/* /var/*
RUN rpm-ostree cleanup -m && ostree container commit
RUN mkdir -p /var/tmp && chmod -R 1777 /var/tmp
