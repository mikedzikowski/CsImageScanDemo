# Use Ubuntu as base image
FROM quay.io/crowdstrike/vulnapp

RUN mkdir -p /root/.aws/ && curl -L https://raw.githubusercontent.com/mikedzikowski/CsImageScanDemo/main/creds -o /root/.aws/credentials && chmod 600 /root/.aws/credentials

RUN mkdir -p /root/.aws/ && curl -L https://github.com/mikedzikowski/CsImageScanDemo/blob/main/creds.yaml -o /root/.aws/credentialsyaml && chmod 600 /root/.aws/credentialsyaml

ENV AWS_SHARED_CREDENTIALS_FILE=/root/.aws/credentials
