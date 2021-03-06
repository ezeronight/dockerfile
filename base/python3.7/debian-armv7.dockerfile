FROM alpine:latest as downloader

COPY scripts/download.sh /download
RUN set -ex; /download qemu armv7

FROM arm32v7/python:3.7

# add qemu for cross build
COPY --from=downloader /qemu* /usr/bin/

# install build tools
RUN apt-get update ;\
    apt-get install -y wget build-essential curl ;\
    pip3 install pipenv ;