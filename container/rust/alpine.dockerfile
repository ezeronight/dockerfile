ARG ARCH=amd64
# docker flavored arch name
ARG DOCKER_ARCH=amd64

FROM arhatdev/builder-rust:debian as builder
FROM ${DOCKER_ARCH}/alpine:latest

ONBUILD ARG TARGET
ONBUILD ARG APP=${TARGET}
ONBUILD COPY --from=builder /app/build/${TARGET} /${APP}
