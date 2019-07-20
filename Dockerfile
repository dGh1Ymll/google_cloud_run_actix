FROM gcr.io/actix-test/cargo:latest

workdir /usr/src/project

COPY . .

RUN cargo build --release

