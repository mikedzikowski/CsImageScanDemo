# Use Ubuntu as base image
FROM quay.io/crowdstrike/vulnapp

# Create test directories
RUN mkdir -p /test/secrets /root/.aws /root/.azure

# Create files with various "secret" patterns for demonstration
RUN echo "# AWS Credentials Examples" > /test/secrets/aws_secrets.txt && \
    echo "aws_access_key_id = AKIAIOSFODNN7EXAMPLE" >> /test/secrets/aws_secrets.txt && \
    echo "aws_secret_access_key = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" >> /test/secrets/aws_secrets.txt && \
    echo "AWS_KEY='AKIAJSIE39JDOEJD9371'" >> /test/secrets/aws_secrets.txt && \
    echo "amzn.mws.12345678-1234-1234-1234-123456789012" >> /test/secrets/aws_secrets.txt

# Slack token examples
RUN echo "# Slack Tokens" > /test/secrets/slack_tokens.txt && \
    echo "xoxb-123456789012-123456789012-123456789012" >> /test/secrets/slack_tokens.txt && \
    echo "xoxp-123456789012-123456789012-123456789012" >> /test/secrets/slack_tokens.txt

# GCP examples
RUN echo "# GCP Credentials" > /test/secrets/gcp_secrets.txt && \
    echo "AIzaSyC2O_LgjlC5lFTyqr6LTfU3m7mS3sYI1Kg" >> /test/secrets/gcp_secrets.txt && \
    echo "123456789012-abcdefghijklmnopqrstuvwxyz123456.apps.googleusercontent.com" >> /test/secrets/gcp_secrets.txt

# Azure examples
RUN echo '{"accessToken":"dummy_token"}' > /root/.azure/accessTokens.json && \
    echo '{"subscriptionId":"dummy_subscription"}' > /root/.azure/azureProfile.json

# Set appropriate permissions
RUN chmod 600 /test/secrets/* /root/.azure/*

# Create a README explaining this is a demo
RUN echo "This is a demonstration container with example secrets for testing detection tools.\nDO NOT USE THESE IN PRODUCTION!" > /test/README.md

WORKDIR /test

