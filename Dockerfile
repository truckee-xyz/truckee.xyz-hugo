FROM debian:bookworm as builder
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  git \
  hugo
WORKDIR /app
COPY truckee.xyz .


FROM builder as debug-container
ENTRYPOINT ["/usr/bin/bash"]

FROM builder as dev-container
ENTRYPOINT ["/usr/bin/hugo", "server", "--bind", "0.0.0.0", "--port", "8080"]


FROM builder as static-build
ENTRYPOINT ["/usr/bin/hugo"]
