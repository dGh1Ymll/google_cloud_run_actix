FROM rust:latest as builder

RUN apt-get update && apt-get -y install ca-certificates cmake musl-tools libssl-dev && rm -rf /var/lib/apt/lists/*

RUN rustup target add x86_64-unknown-linux-musl
RUN rustup update

WORKDIR /cloud_run_actix

COPY . .

# build our source for release 
RUN cargo build --target x86_64-unknown-linux-musl --release

# final image for prod 
FROM alpine:latest
RUN apk add --no-cache ca-certificates
# Copy over our service
COPY --from=builder /cloud_run_actix/target/x86_64-unknown-linux-musl/release/cloud_run_actix .
# set up our start up command
CMD ["/cloud_run_actix"]
