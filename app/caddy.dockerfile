ARG ARCH=amd64

FROM abiosoft/caddy:builder as builder

ARG VERSION="1.0.3"
ARG PLUGINS="git,cors,realip,expires,cache,cloudflare,dyndns"

ARG ARCH=amd64
ARG GOARCH=amd64
ARG GOARM=7

# temporary fix
ADD https://raw.githubusercontent.com/jeffreystoke/caddy-docker/master/builder/builder.sh /usr/bin/builder.sh
COPY scripts/download.sh /download
RUN /download qemu ${ARCH} ;\
    mkdir -p /app/build ;\
    CGO_ENABLED=0 ENABLE_TELEMETRY=false GOOS=linux /bin/sh /usr/bin/builder.sh ;\
    # move to standard dir
    mv /install/caddy /app/build/caddy-linux-${ARCH}

FROM arhatdev/go:alpine-${ARCH}

ENV ENABLE_TELEMETRY="false"
COPY --from=builder /qemu* /usr/bin/
RUN apk add --no-cache ca-certificates git mailcap openssh-client tzdata

# validate caddy install
RUN /caddy -version ;\
    /caddy -plugins

ENTRYPOINT ["/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout", "--agree=true"]
