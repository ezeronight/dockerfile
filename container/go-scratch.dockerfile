FROM arhatdev/go-builder:onbuild as builder
FROM scratch

ONBUILD ARG TARGET
ONBUILD COPY --from=builder /arhat/build/${TARGET} /app

# set OCI default command
ENTRYPOINT [ "/app" ]
