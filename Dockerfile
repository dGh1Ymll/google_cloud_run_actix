FROM gcr.io/actix-test/cargo:latest as builder

RUN apt-get update && apt-get -y install ca-certificates cmake musl-tools libssl-dev && rm -rf /var/lib/apt/lists/*

# create a new empty shell project
RUN USER=root cargo new --bin cloud_run_actix
WORKDIR /cloud_run_actix

COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

# this build step will cache our dependencies
RUN cargo build --release
RUN rm src/*.rs

# copy over our source tree
COPY ./src ./src

# build our source for release 
RUN cargo build --target x86_64-unknown-linux-musl --release

# final image for prod 
FROM alpine:latest
# Copy over our service
COPY --from=builder /cloud_run_actix/target/x84_64-unknown-linux-musl/release/cloud_run_actix .
# set up our start up command
CMD ["/cloud_run_actix"]
