FROM gcr.io/actix-test/cargo:latest as builder

RUN apt-get update && apt-get -y install ca-certificates cmake musl-tools libssl-dev && rm -rf /var/lib/apt/lists/*

workdir /usr/src/project

COPY . .

RUN cargo build --target x86_64-unknown-linux-musl --release

FROM alpine:latest

COPY --from=builder /target/x84_64-unknown-linux-musl/release/google_cloud_run_actix .

CMD ["/google_cloud_run_actix"]
