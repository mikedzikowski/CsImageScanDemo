# Base image
FROM ubuntu:22.04

# Build arguments (passed at build time)
ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_BRANCH

# OCI standard labels + custom build labels
LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.version="${BUILD_VERSION}" \
      org.opencontainers.image.revision="${GIT_COMMIT}" \
      org.opencontainers.image.source="https://github.com/crowdstrike/myapp" \
      org.opencontainers.image.title="My Application" \
      org.opencontainers.image.description="A simple example application" \
      org.opencontainers.image.vendor="CrowdStrike" \
      build.branch="${GIT_BRANCH}" \
      build.number="${BUILD_VERSION}" \
      maintainer="noreply@crowdstrike.com" \
      build.team="platform-engineering" \
      build.environment="production"

# Your app setup
WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8080
CMD ["bash"]
