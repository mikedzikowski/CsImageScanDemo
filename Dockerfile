# Use Ubuntu as base image
FROM quay.io/crowdstrike/vulnapp

RUN mkdir -p /root/.aws/ && curl -L https://raw.githubusercontent.com/mikedzikowski/CsImageScanDemo/main/creds -o /root/.aws/credentials && chmod 600 /root/.aws/credentials

