FROM ubuntu:latest

# Create test directories
RUN mkdir -p /.azure

# AWS Credentials
RUN echo "# AWS Credentials Examples" > /aws_config.txt && \
    echo "aws_access_key_id = AKIAIOSFODNN7EXAMPLE" >> /aws_config.txt && \
    echo "aws_secret_access_key = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" >> /aws_config.txt && \
    echo "AWS_KEY='AKIAJSIE39JDOEJD9371'" >> /aws_config.txt && \
    echo "amzn.mws.12345678-1234-1234-1234-123456789012" >> /aws_config.txt

# Slack tokens
RUN echo "xoxb-123456789012-123456789012-123456789012" > /slack_config.txt

# GCP credentials
RUN echo "AIzaSyC2O_LgjlC5lFTyqr6LTfU3m7mS3sYI1Kg" > /gcp_api.txt && \
    echo "123456789012-abcdefghijklmnopqrstuvwxyz123456.apps.googleusercontent.com" >> /gcp_api.txt

# Azure credentials - exact path matches from rules
RUN echo '{"accessToken":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IlNTUWRoSTFjS3ZoUUVEU0p4RTJnR1lzNDBRPSIsImtpZCI6IlNTUWRoSTFjS3ZoUUVEU0p4RTJnR1lzNDBRPSJ9"}' > /.azure/accessTokens.json && \
    echo '{ \
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
    }' > /.azure/azureProfile.json

# Set appropriate permissions
RUN chmod 600 /.azure/accessTokens.json /.azure/azureProfile.json

# Create a README explaining this is a demo
RUN echo "This is a demonstration container with example secrets for testing detection tools.\nDO NOT USE THESE IN PRODUCTION!" > /README.md
