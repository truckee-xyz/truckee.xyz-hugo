FROM debian:bookworm
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  git \
  ca-certificates \
  hugo
