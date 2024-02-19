FROM debian:bookworm as base
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  git \
  ca-certificates \
  hugo
WORKDIR /app
COPY truckee.xyz .

FROM base as debug
ENTRYPOINT ["/usr/bin/bash"]

FROM base as dev
ENTRYPOINT ["/usr/bin/hugo", "server", "--bind", "0.0.0.0", "--port", "8080"]

FROM base as ssg
ENTRYPOINT ["/usr/bin/hugo"]
