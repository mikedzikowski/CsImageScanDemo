FROM ubuntu:22.04

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_BRANCH
ARG GIT_REPO
ARG WORKFLOW_NAME
ARG TRIGGERED_BY

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.version="${BUILD_VERSION}" \
      org.opencontainers.image.revision="${GIT_COMMIT}" \
      org.opencontainers.image.source="https://github.com/${GIT_REPO}" \
      org.opencontainers.image.title="My Application" \
      org.opencontainers.image.description="A simple example application" \
      org.opencontainers.image.vendor="CrowdStrike" \
      build.branch="${GIT_BRANCH}" \
      build.number="${BUILD_VERSION}" \
      build.workflow="${WORKFLOW_NAME}" \
      build.triggered_by="${TRIGGERED_BY}" \
      build.team="platform-engineering" \
      build.environment="production" \
      maintainer="noreply@crowdstrike.com"

WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8080
CMD ["bash"]
