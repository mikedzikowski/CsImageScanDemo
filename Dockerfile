FROM ubuntu:latest

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

# Azure examples with storage account key
RUN echo "# Azure Credentials" > /test/secrets/azure_secrets.txt && \
    echo "DefaultEndpointsProtocol=https;AccountName=storageaccountname;AccountKey=V7LFzwXAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6=" >> /test/secrets/azure_secrets.txt

# Azure service principal credentials
RUN echo '{ \
  "clientId": "11111111-2222-3333-4444-555555555555", \
  "clientSecret": "Q~ThisIsADummySecretKeyForTesting123!@#", \
  "subscriptionId": "66666666-7777-8888-9999-000000000000", \
  "tenantId": "12345678-90ab-cdef-ghij-klmnopqrstuv", \
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com", \
  "resourceManagerEndpointUrl": "https://management.azure.com/", \
  "activeDirectoryGraphResourceId": "https://graph.windows.net/", \
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/", \
  "galleryEndpointUrl": "https://gallery.azure.com/", \
  "managementEndpointUrl": "https://management.core.windows.net/" \
}' > /root/.azure/azureProfile.json

# Azure access tokens
RUN echo '{"accessToken":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IlNTUWRoSTFjS3ZoUUVEU0p4RTJnR1lzNDBRPSIsImtpZCI6IlNTUWRoSTFjS3ZoUUVEU0p4RTJnR1lzNDBRPSJ9"}' > /root/.azure/accessTokens.json

# Set appropriate permissions
RUN chmod 600 /test/secrets/* /root/.azure/*

# Create a README explaining this is a demo
RUN echo "This is a demonstration container with example secrets for testing detection tools.\nDO NOT USE THESE IN PRODUCTION!" > /test/README.md

WORKDIR /test
